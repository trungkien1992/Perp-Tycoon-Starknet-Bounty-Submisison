import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
import 'package:http/http.dart' as http;
import '../app_mode.dart';

/// Real Starknet service that uses actual starkli keystore and RPC calls
class RealStarknetService {
  static const String _sepoliaRpcUrl = 'https://starknet-sepolia.public.blastapi.io';
  static const String _mainnetRpcUrl = 'https://starknet-mainnet.public.blastapi.io';
  
  String? _keystorePath;
  String? _accountPath;
  String? _accountAddress;
  String? _rpcUrl;
  bool _useMainnet;
  
  /// Initialize service with testnet by default
  RealStarknetService({bool useMainnet = false}) : _useMainnet = useMainnet {
    _rpcUrl = useMainnet ? _mainnetRpcUrl : _sepoliaRpcUrl;
  }
  
  /// Initialize with real starkli configuration
  Future<void> initializeWithStarkli() async {
    try {
      // Load environment configuration
      final envFile = File('deployment/.env.real');
      if (!await envFile.exists()) {
        throw StarknetException('Real environment configuration not found. Run setup_real_starknet.sh first.');
      }
      
      final envContent = await envFile.readAsString();
      final envLines = envContent.split('\n');
      
      for (final line in envLines) {
        if (line.startsWith('STARKNET_KEYSTORE=')) {
          _keystorePath = line.split('=')[1];
        } else if (line.startsWith('STARKNET_ACCOUNT=')) {
          _accountPath = line.split('=')[1];
        } else if (line.startsWith('STARKNET_RPC=')) {
          _rpcUrl = line.split('=')[1];
        } else if (line.startsWith('ACCOUNT_ADDRESS=')) {
          _accountAddress = line.split('=')[1];
        }
      }
      
      if (_keystorePath == null || _accountPath == null || _accountAddress == null) {
        throw StarknetException('Missing required configuration in .env.real');
      }
      
      // Verify keystore and account files exist
      final keystoreFile = File(_keystorePath!);
      final accountFile = File(_accountPath!);
      
      if (!await keystoreFile.exists()) {
        throw StarknetException('Keystore file not found: $_keystorePath');
      }
      
      if (!await accountFile.exists()) {
        throw StarknetException('Account file not found: $_accountPath');
      }
      
      // Verify account is deployed
      final isDeployed = await _checkAccountDeployment();
      if (!isDeployed) {
        throw StarknetException('Account not deployed. Run: starkli account deploy --rpc $_rpcUrl --account $_accountPath');
      }
      
      print('✅ Real Starknet service initialized');
      print('📁 Keystore: $_keystorePath');
      print('👤 Account: $_accountPath');
      print('🏠 Address: $_accountAddress');
      print('🌐 RPC: $_rpcUrl');
    } catch (e) {
      throw StarknetException('Failed to initialize with starkli: $e');
    }
  }
  
  /// Check if account is deployed on the network
  Future<bool> _checkAccountDeployment() async {
    try {
      final result = await Process.run('starkli', [
        'account',
        'verify',
        '--rpc',
        _rpcUrl!,
        '--account',
        _accountPath!,
      ]);
      
      return result.exitCode == 0;
    } catch (e) {
      print('Account deployment check failed: $e');
      return false;
    }
  }
  
  /// Get account address
  Future<String> getAccountAddress() async {
    if (_accountAddress != null) {
      return _accountAddress!;
    }
    
    try {
      final result = await Process.run('starkli', [
        'account',
        'address',
        '--account',
        _accountPath!,
      ]);
      
      if (result.exitCode != 0) {
        throw StarknetException('Failed to get account address: ${result.stderr}');
      }
      
      _accountAddress = result.stdout.toString().trim();
      return _accountAddress!;
    } catch (e) {
      throw StarknetException('Failed to get account address: $e');
    }
  }
  
  /// Sign a message using starkli
  Future<String> signMessage(String message) async {
    if (_keystorePath == null || _accountPath == null) {
      throw StarknetException('Service not initialized');
    }
    
    try {
      // Create temporary file with message
      final tempFile = File('/tmp/starknet_message_${DateTime.now().millisecondsSinceEpoch}.txt');
      await tempFile.writeAsString(message);
      
      // Sign using starkli
      final result = await Process.run('starkli', [
        'signer',
        'sign',
        '--keystore',
        _keystorePath!,
        tempFile.path,
      ]);
      
      // Clean up temp file
      await tempFile.delete();
      
      if (result.exitCode != 0) {
        throw StarknetException('Failed to sign message: ${result.stderr}');
      }
      
      return result.stdout.toString().trim();
    } catch (e) {
      throw StarknetException('Failed to sign message: $e');
    }
  }
  
  /// Call a contract function
  Future<String> callContract({
    required String contractAddress,
    required String functionName,
    required List<String> calldata,
  }) async {
    try {
      final args = [
        'call',
        '--rpc',
        _rpcUrl!,
        contractAddress,
        functionName,
        ...calldata,
      ];
      
      final result = await Process.run('starkli', args);
      
      if (result.exitCode != 0) {
        throw StarknetException('Contract call failed: ${result.stderr}');
      }
      
      return result.stdout.toString().trim();
    } catch (e) {
      throw StarknetException('Failed to call contract: $e');
    }
  }
  
  /// Invoke a contract function (write operation)
  Future<String> invokeContract({
    required String contractAddress,
    required String functionName,
    required List<String> calldata,
  }) async {
    if (_keystorePath == null || _accountPath == null) {
      throw StarknetException('Service not initialized');
    }
    
    try {
      final args = [
        'invoke',
        '--rpc',
        _rpcUrl!,
        '--account',
        _accountPath!,
        '--keystore',
        _keystorePath!,
        contractAddress,
        functionName,
        ...calldata,
      ];
      
      final result = await Process.run('starkli', args);
      
      if (result.exitCode != 0) {
        throw StarknetException('Contract invocation failed: ${result.stderr}');
      }
      
      // Extract transaction hash from output
      final output = result.stdout.toString();
      final txHashMatch = RegExp(r'Transaction hash: (0x[a-fA-F0-9]+)').firstMatch(output);
      if (txHashMatch != null) {
        return txHashMatch.group(1)!;
      }
      
      return output.trim();
    } catch (e) {
      throw StarknetException('Failed to invoke contract: $e');
    }
  }
  
  /// Get contract addresses from environment
  Map<String, String> getContractAddresses() {
    final contracts = <String, String>{};
    
    try {
      final envFile = File('deployment/.env.real');
      if (!envFile.existsSync()) {
        return contracts;
      }
      
      final envContent = envFile.readAsStringSync();
      final envLines = envContent.split('\n');
      
      for (final line in envLines) {
        if (line.startsWith('CONTRACT_') && line.contains('_ADDRESS=')) {
          final parts = line.split('=');
          if (parts.length == 2) {
            final key = parts[0].replaceAll('CONTRACT_', '').replaceAll('_ADDRESS', '');
            contracts[key.toLowerCase()] = parts[1];
          }
        }
      }
    } catch (e) {
      print('Error reading contract addresses: $e');
    }
    
    return contracts;
  }
  
  /// Add XP to contract (real transaction)
  Future<String> addXPToContract({
    required String playerAddress,
    required int xpAmount,
  }) async {
    final contracts = getContractAddresses();
    final xpContractAddress = contracts['streetcred_xp'];
    
    if (xpContractAddress == null) {
      throw StarknetException('XP contract not deployed');
    }
    
    return await invokeContract(
      contractAddress: xpContractAddress,
      functionName: 'add_xp',
      calldata: [playerAddress, xpAmount.toString()],
    );
  }
  
  /// Get XP from contract
  Future<int> getXPFromContract(String playerAddress) async {
    final contracts = getContractAddresses();
    final xpContractAddress = contracts['streetcred_xp'];
    
    if (xpContractAddress == null) {
      throw StarknetException('XP contract not deployed');
    }
    
    final result = await callContract(
      contractAddress: xpContractAddress,
      functionName: 'get_xp',
      calldata: [playerAddress],
    );
    
    // Parse result as integer
    return int.tryParse(result) ?? 0;
  }
  
  /// Get leaderboard from contract
  Future<List<LeaderboardEntry>> getLeaderboard() async {
    final contracts = getContractAddresses();
    final xpContractAddress = contracts['streetcred_xp'];
    
    if (xpContractAddress == null) {
      throw StarknetException('XP contract not deployed');
    }
    
    final result = await callContract(
      contractAddress: xpContractAddress,
      functionName: 'get_leaderboard_top_10',
      calldata: [],
    );
    
    return _parseLeaderboardResult(result);
  }
  
  /// Parse leaderboard result from contract
  List<LeaderboardEntry> _parseLeaderboardResult(String result) {
    try {
      // This is a simplified parser - real implementation would handle Cairo arrays
      final entries = <LeaderboardEntry>[];
      
      // Mock parsing for now - real implementation would parse Cairo output
      final lines = result.split('\n');
      for (final line in lines) {
        if (line.contains('0x') && line.contains(' ')) {
          final parts = line.trim().split(' ');
          if (parts.length >= 2) {
            final address = parts[0];
            final xp = int.tryParse(parts[1]) ?? 0;
            entries.add(LeaderboardEntry(address: address, xp: xp));
          }
        }
      }
      
      return entries;
    } catch (e) {
      print('Error parsing leaderboard: $e');
      return [];
    }
  }
  
  /// Get current account address
  String? get accountAddress => _accountAddress;
  
  /// Check if service is initialized
  bool get isInitialized => _keystorePath != null && _accountPath != null && _accountAddress != null;
  
  /// Check if running in real mode
  bool get isRealMode => !isMockMode();
}

/// Leaderboard entry
class LeaderboardEntry {
  final String address;
  final int xp;
  
  LeaderboardEntry({required this.address, required this.xp});
}

/// Custom exception for Starknet operations
class StarknetException implements Exception {
  final String message;
  
  StarknetException(this.message);
  
  @override
  String toString() => 'StarknetException: $message';
}