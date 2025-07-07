import 'dart:convert';
import 'package:http/http.dart' as http;
import 'starknet_service.dart';
import '../app_mode.dart';

/// Service for interacting with StreetCred Cairo contracts on Starknet
class ContractService {
  static const String _testnetRpcUrl = 'https://starknet-sepolia.public.blastapi.io';
  static const String _mainnetRpcUrl = 'https://starknet-mainnet.public.blastapi.io';
  
  // Contract addresses (would be set after deployment)
  static const String _xpContractAddress = '0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7'; // Placeholder
  static const String _nftContractAddress = '0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc8'; // Placeholder
  
  final StarknetService _starknetService;
  final bool _useMainnet;
  late String _rpcUrl;
  
  ContractService(this._starknetService, {bool useMainnet = false}) 
      : _useMainnet = useMainnet {
    _rpcUrl = useMainnet ? _mainnetRpcUrl : _testnetRpcUrl;
  }
  
  /// Add XP to a player's account on the XP contract
  /// This is called by the XPNotifier.gainXP function
  Future<String> addXPToContract({
    required String playerAddress,
    required int xpAmount,
  }) async {
    if (isMockMode()) {
      // In mock mode, simulate contract interaction
      print('🔗 Mock Contract Call: addXP($playerAddress, $xpAmount)');
      await Future.delayed(const Duration(milliseconds: 500));
      return 'mock_tx_${DateTime.now().millisecondsSinceEpoch}';
    }
    
    try {
      // Step 1: Create the contract call data
      final calldata = [
        playerAddress, // to: ContractAddress
        xpAmount.toString(), // amount: u256
      ];
      
      // Step 2: Sign the transaction with Starknet service
      final signature = await _starknetService.signMessage(
        'add_xp:$playerAddress:$xpAmount:${DateTime.now().millisecondsSinceEpoch}'
      );
      
      // Step 3: Execute the contract call
      final txHash = await _executeContractCall(
        contractAddress: _xpContractAddress,
        functionName: 'add_xp',
        calldata: calldata,
        signature: signature,
      );
      
      print('✅ XP added to contract: $xpAmount XP for $playerAddress');
      print('📝 Transaction hash: $txHash');
      
      return txHash;
      
    } catch (e) {
      print('❌ Failed to add XP to contract: $e');
      throw ContractException('Failed to add XP to contract: $e');
    }
  }
  
  /// Read XP from the contract for a specific player
  Future<int> getXPFromContract(String playerAddress) async {
    if (isMockMode()) {
      // Mock XP data
      return DateTime.now().millisecondsSinceEpoch % 1000;
    }
    
    try {
      final result = await _callContractView(
        contractAddress: _xpContractAddress,
        functionName: 'get_xp',
        calldata: [playerAddress],
      );
      
      // Parse the result (simplified)
      final xp = int.tryParse(result['result']?.toString() ?? '0') ?? 0;
      return xp;
      
    } catch (e) {
      print('❌ Failed to read XP from contract: $e');
      return 0; // Fallback to 0
    }
  }
  
  /// Read leaderboard from the contract
  Future<List<LeaderboardEntry>> getLeaderboardFromContract() async {
    if (isMockMode()) {
      // Mock leaderboard data
      return [
        LeaderboardEntry('0x123...', 1500, 1),
        LeaderboardEntry('0x456...', 1200, 2),
        LeaderboardEntry('0x789...', 1000, 3),
      ];
    }
    
    try {
      final result = await _callContractView(
        contractAddress: _xpContractAddress,
        functionName: 'get_leaderboard_top_10',
        calldata: [],
      );
      
      // Parse the result into leaderboard entries
      // This is simplified - real implementation would parse the array properly
      return _parseLeaderboardResult(result);
      
    } catch (e) {
      print('❌ Failed to read leaderboard from contract: $e');
      return [];
    }
  }
  
  /// Get player's rank from the contract
  Future<int> getPlayerRankFromContract(String playerAddress) async {
    if (isMockMode()) {
      return DateTime.now().millisecondsSinceEpoch % 100 + 1;
    }
    
    try {
      final result = await _callContractView(
        contractAddress: _xpContractAddress,
        functionName: 'get_player_rank',
        calldata: [playerAddress],
      );
      
      return int.tryParse(result['result']?.toString() ?? '0') ?? 0;
      
    } catch (e) {
      print('❌ Failed to read player rank from contract: $e');
      return 0;
    }
  }
  
  /// Mint achievement NFT for a player
  Future<String> mintAchievementNFT({
    required String playerAddress,
    required int achievementType,
  }) async {
    if (isMockMode()) {
      print('🎨 Mock NFT Mint: Achievement $achievementType for $playerAddress');
      await Future.delayed(const Duration(milliseconds: 800));
      return 'mock_nft_${DateTime.now().millisecondsSinceEpoch}';
    }
    
    try {
      final calldata = [
        playerAddress,
        achievementType.toString(),
      ];
      
      final signature = await _starknetService.signMessage(
        'mint_achievement_nft:$playerAddress:$achievementType:${DateTime.now().millisecondsSinceEpoch}'
      );
      
      final txHash = await _executeContractCall(
        contractAddress: _nftContractAddress,
        functionName: 'mint_achievement_nft',
        calldata: calldata,
        signature: signature,
      );
      
      print('🎨 Achievement NFT minted: Type $achievementType for $playerAddress');
      return txHash;
      
    } catch (e) {
      print('❌ Failed to mint achievement NFT: $e');
      throw ContractException('Failed to mint achievement NFT: $e');
    }
  }
  
  /// Mint level milestone NFT
  Future<String> mintLevelMilestoneNFT({
    required String playerAddress,
    required int level,
  }) async {
    if (isMockMode()) {
      print('🏆 Mock Milestone NFT: Level $level for $playerAddress');
      await Future.delayed(const Duration(milliseconds: 800));
      return 'mock_milestone_${DateTime.now().millisecondsSinceEpoch}';
    }
    
    try {
      final calldata = [
        playerAddress,
        level.toString(),
      ];
      
      final signature = await _starknetService.signMessage(
        'mint_level_milestone_nft:$playerAddress:$level:${DateTime.now().millisecondsSinceEpoch}'
      );
      
      final txHash = await _executeContractCall(
        contractAddress: _nftContractAddress,
        functionName: 'mint_level_milestone_nft',
        calldata: calldata,
        signature: signature,
      );
      
      print('🏆 Level milestone NFT minted: Level $level for $playerAddress');
      return txHash;
      
    } catch (e) {
      print('❌ Failed to mint level milestone NFT: $e');
      throw ContractException('Failed to mint level milestone NFT: $e');
    }
  }
  
  /// Get player's NFTs from the contract
  Future<List<NFTMetadata>> getPlayerNFTs(String playerAddress) async {
    if (isMockMode()) {
      return [
        NFTMetadata(1, 'Achievement: First Trade', 'first_trade'),
        NFTMetadata(2, 'Level Milestone: Level 10', 'level_10'),
      ];
    }
    
    try {
      final result = await _callContractView(
        contractAddress: _nftContractAddress,
        functionName: 'get_nfts_by_owner',
        calldata: [playerAddress],
      );
      
      return _parseNFTResult(result);
      
    } catch (e) {
      print('❌ Failed to read player NFTs from contract: $e');
      return [];
    }
  }
  
  /// Execute a contract call (write operation)
  Future<String> _executeContractCall({
    required String contractAddress,
    required String functionName,
    required List<String> calldata,
    required String signature,
  }) async {
    // This is a simplified implementation
    // In production, this would use proper Starknet transaction format
    
    final response = await http.post(
      Uri.parse(_rpcUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "jsonrpc": "2.0",
        "method": "starknet_addInvokeTransaction",
        "params": {
          "invoke_transaction": {
            "type": "INVOKE",
            "max_fee": "0x1000000000000",
            "version": "0x1",
            "signature": [signature],
            "nonce": "0x1",
            "sender_address": _starknetService.accountAddress,
            "calldata": _buildCalldata(contractAddress, functionName, calldata),
          }
        },
        "id": 1,
      }),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['result'] != null) {
        return data['result']['transaction_hash'];
      } else {
        throw Exception('Contract call failed: ${data['error']}');
      }
    } else {
      throw Exception('HTTP Error: ${response.statusCode}');
    }
  }
  
  /// Call a contract view function (read operation)
  Future<Map<String, dynamic>> _callContractView({
    required String contractAddress,
    required String functionName,
    required List<String> calldata,
  }) async {
    final response = await http.post(
      Uri.parse(_rpcUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "jsonrpc": "2.0",
        "method": "starknet_call",
        "params": {
          "request": {
            "contract_address": contractAddress,
            "entry_point_selector": _getSelectorFromName(functionName),
            "calldata": calldata,
          },
          "block_id": "latest"
        },
        "id": 1,
      }),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['result'] != null) {
        return data;
      } else {
        throw Exception('Contract view call failed: ${data['error']}');
      }
    } else {
      throw Exception('HTTP Error: ${response.statusCode}');
    }
  }
  
  List<String> _buildCalldata(String contractAddress, String functionName, List<String> calldata) {
    // Simplified calldata building
    // In production, this would properly encode the function call
    return [
      contractAddress,
      _getSelectorFromName(functionName),
      calldata.length.toString(),
      ...calldata,
    ];
  }
  
  String _getSelectorFromName(String functionName) {
    // Simplified selector calculation
    // In production, this would use proper Keccak hash
    return '0x${functionName.hashCode.abs().toRadixString(16)}';
  }
  
  List<LeaderboardEntry> _parseLeaderboardResult(Map<String, dynamic> result) {
    // Simplified parsing - in production, parse the actual Cairo array
    return [
      LeaderboardEntry('0x123...', 1500, 1),
      LeaderboardEntry('0x456...', 1200, 2),
      LeaderboardEntry('0x789...', 1000, 3),
    ];
  }
  
  List<NFTMetadata> _parseNFTResult(Map<String, dynamic> result) {
    // Simplified parsing - in production, parse the actual Cairo array
    return [
      NFTMetadata(1, 'Achievement NFT', 'achievement'),
      NFTMetadata(2, 'Milestone NFT', 'milestone'),
    ];
  }
}

/// Data models for contract interactions
class LeaderboardEntry {
  final String address;
  final int xp;
  final int rank;
  
  LeaderboardEntry(this.address, this.xp, this.rank);
}

class NFTMetadata {
  final int tokenId;
  final String name;
  final String type;
  
  NFTMetadata(this.tokenId, this.name, this.type);
}

/// Custom exception for contract operations
class ContractException implements Exception {
  final String message;
  
  ContractException(this.message);
  
  @override
  String toString() => 'ContractException: $message';
}