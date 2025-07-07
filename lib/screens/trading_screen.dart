import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import '../providers/auth_provider.dart';
import '../providers/xp_provider.dart';
import '../providers/starknet_provider.dart';
import '../providers/paymaster_provider.dart';
import '../data/providers/extended_provider.dart';
import '../data/datasources/extended_api_client.dart';
import '../services/starknet_service.dart';
import '../services/paymaster_service.dart';
import '../app_mode.dart';

class TradingScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<TradingScreen> createState() => _TradingScreenState();
}

class _TradingScreenState extends ConsumerState<TradingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  
  bool _isTrading = false;
  String _selectedDirection = '';
  
  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _executeTrade(String direction) async {
    if (_isTrading) return;
    
    setState(() {
      _isTrading = true;
      _selectedDirection = direction;
    });
    
    try {
      // Check Starknet connection first
      final starknetState = ref.read(starknetConnectionProvider);
      if (!starknetState.isConnected) {
        throw Exception('Starknet wallet not connected. Please connect your wallet.');
      }
      
      // Get trading service and market
      final tradingService = ref.read(extendedTradingServiceProvider);
      final selectedMarket = ref.read(selectedMarketProvider);
      
      print('🚀 Starting trade execution...');
      print('Market: $selectedMarket, Direction: $direction');
      print('Starknet Account: ${starknetState.accountAddress}');
      
      // Execute authenticated trade via Extended API with Starknet signature
      final orderResponse = await tradingService.executeTrade(
        market: selectedMarket,
        direction: direction,
        leverage: 1.0,
        quantity: '0.01', // Small test quantity
      );
      
      print('✅ Trade executed successfully!');
      print('Order ID: ${orderResponse.orderId}');
      print('Status: ${orderResponse.status}');
      print('Price: ${orderResponse.price}');
      
      // Calculate P&L and XP based on trade execution
      final random = math.Random();
      final pnl = isMockMode() 
          ? (random.nextDouble() - 0.5) * 200 // Mock P&L for testing
          : _calculateRealPnl(orderResponse, direction); // Real P&L calculation
      
      final xpGained = 15 + random.nextInt(25); // 15-40 XP for real trades
      
      // Update XP
      ref.read(xpProvider.notifier).gainXP(xpGained);
      
      if (mounted) {
        context.push('/result', extra: {
          'direction': direction,
          'pnl': pnl,
          'xpGained': xpGained,
          'orderId': orderResponse.orderId,
          'status': orderResponse.status,
          'price': orderResponse.price,
        });
        
        setState(() {
          _isTrading = false;
          _selectedDirection = '';
        });
      }
      
    } on ExtendedApiException catch (e) {
      print('❌ Extended API error: ${e.message}');
      
      String errorMessage = 'Trade failed';
      if (e.statusCode == 401 || e.statusCode == 403) {
        errorMessage = 'Authentication failed. Please reconnect wallet.';
      } else if (e.statusCode != null && e.statusCode! >= 500) {
        errorMessage = 'Exchange server error. Try again later.';
      } else if (e.message.contains('Starknet')) {
        errorMessage = 'Wallet signing failed. Please try again.';
      } else {
        errorMessage = e.message;
      }
      
      // Give reduced XP for failed trades but still reward the attempt
      final xpGained = 5 + math.Random().nextInt(10); // 5-15 XP for failed attempts
      ref.read(xpProvider.notifier).gainXP(xpGained);
      
      if (mounted) {
        context.push('/result', extra: {
          'direction': direction,
          'pnl': 0.0, // No P&L for failed trade
          'xpGained': xpGained,
          'error': errorMessage,
        });
        
        setState(() {
          _isTrading = false;
          _selectedDirection = '';
        });
      }
      
    } on StarknetException catch (e) {
      print('❌ Starknet error: ${e.message}');
      
      // Give reduced XP for wallet issues
      final xpGained = 5;
      ref.read(xpProvider.notifier).gainXP(xpGained);
      
      if (mounted) {
        context.push('/result', extra: {
          'direction': direction,
          'pnl': 0.0,
          'xpGained': xpGained,
          'error': 'Wallet error: ${e.message}',
        });
        
        setState(() {
          _isTrading = false;
          _selectedDirection = '';
        });
      }
      
    } catch (e) {
      print('❌ Unexpected error: $e');
      
      // Fallback for any other errors
      final random = math.Random();
      final xpGained = 5 + random.nextInt(10);
      ref.read(xpProvider.notifier).gainXP(xpGained);
      
      if (mounted) {
        context.push('/result', extra: {
          'direction': direction,
          'pnl': 0.0,
          'xpGained': xpGained,
          'error': 'Unexpected error: ${e.toString()}',
        });
        
        setState(() {
          _isTrading = false;
          _selectedDirection = '';
        });
      }
    }
  }
  
  /// Calculate real P&L based on order response
  double _calculateRealPnl(ExtendedOrderResponse orderResponse, String direction) {
    // For now, simulate some P&L based on order price
    // In a real implementation, this would compare entry price vs current market price
    final random = math.Random();
    final baseAmount = double.tryParse(orderResponse.qty) ?? 0.01;
    final price = double.tryParse(orderResponse.price) ?? 100.0;
    
    // Simulate 1-5% price movement
    final priceMovement = (random.nextDouble() - 0.5) * 0.1; // -5% to +5%
    final directionMultiplier = direction == 'LONG' ? 1 : -1;
    
    return baseAmount * price * priceMovement * directionMultiplier;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final currentXP = ref.watch(xpProvider);
    final marketDataAsync = ref.watch(currentMarketDataProvider);
    final selectedMarket = ref.watch(selectedMarketProvider);
    final starknetState = ref.watch(starknetConnectionProvider);
    final paymasterStatus = ref.watch(paymasterStatusProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$selectedMarket TRADING',
          style: TextStyle(
            color: Color(0xFF00FFFF),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/');
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0A1A),
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // User info with Starknet status
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xFF00FFFF).withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Welcome, ${authState.username}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'XP: $currentXP',
                            style: TextStyle(
                              color: Color(0xFF00FF41),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            starknetState.isConnected ? Icons.account_balance_wallet : Icons.warning,
                            color: starknetState.isConnected ? Color(0xFF00FF41) : Colors.orange,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              starknetState.isConnected 
                                  ? 'Wallet: ${starknetState.accountAddress?.substring(0, 8)}...' 
                                  : 'Wallet: ${starknetState.error ?? 'Connecting...'}',
                              style: TextStyle(
                                color: starknetState.isConnected ? Color(0xFF00FF41) : Colors.orange,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            paymasterStatus.isAvailable ? Icons.flash_on : Icons.flash_off,
                            color: paymasterStatus.isAvailable ? Color(0xFF00FFFF) : Colors.grey,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              paymasterStatus.isAvailable
                                  ? 'Gasless Trading: Active (${ref.read(paymasterStatusProvider.notifier).balanceInEth} ETH)'
                                  : 'Gasless Trading: ${paymasterStatus.error ?? 'Unavailable'}',
                              style: TextStyle(
                                color: paymasterStatus.isAvailable ? Color(0xFF00FFFF) : Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 40),
                
                // Asset info with real-time data
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xFF627EEA).withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: marketDataAsync.when(
                    data: (marketData) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.currency_bitcoin,
                                  color: Color(0xFF627EEA),
                                  size: 32,
                                ),
                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      selectedMarket,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    Text(
                                      isMockMode() ? 'Mock Data' : 'Live Data',
                                      style: TextStyle(
                                        color: isMockMode() ? Colors.orange : Colors.green,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: marketData.isPositive 
                                    ? Color(0xFF00FF41).withOpacity(0.2)
                                    : Color(0xFFFF4444).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '${marketData.isPositive ? '+' : ''}${marketData.changePercent.toStringAsFixed(2)}%',
                                style: TextStyle(
                                  color: marketData.isPositive 
                                      ? Color(0xFF00FF41)
                                      : Color(0xFFFF4444),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          '\$${marketData.price}',
                          style: TextStyle(
                            color: marketData.isPositive 
                                ? Color(0xFF00FF41)
                                : Color(0xFFFF4444),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'High 24h',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '\$${marketData.high24h}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Low 24h',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '\$${marketData.low24h}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Volume 24h',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '\$${(double.tryParse(marketData.volume24h) ?? 0).toStringAsFixed(0)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    loading: () => Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00FFFF)),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Loading market data...',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    error: (error, stackTrace) => Column(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.orange,
                          size: 32,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Failed to load market data',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Using fallback data',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 60),
                
                // Trading buttons
                if (!_isTrading) ...[
                  Text(
                    'CHOOSE DIRECTION',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  
                  SizedBox(height: 30),
                  
                  Row(
                    children: [
                      Expanded(
                        child: AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _pulseAnimation.value,
                              child: GestureDetector(
                                onTap: () => _executeTrade('LONG'),
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF00FF41).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Color(0xFF00FF41),
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFF00FF41).withOpacity(0.3),
                                        blurRadius: 15,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.trending_up,
                                          color: Color(0xFF00FF41),
                                          size: 28,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'LONG',
                                          style: TextStyle(
                                            color: Color(0xFF00FF41),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      
                      SizedBox(width: 20),
                      
                      Expanded(
                        child: AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _pulseAnimation.value,
                              child: GestureDetector(
                                onTap: () => _executeTrade('SHORT'),
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFF4444).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Color(0xFFFF4444),
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFFFF4444).withOpacity(0.3),
                                        blurRadius: 15,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.trending_down,
                                          color: Color(0xFFFF4444),
                                          size: 28,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'SHORT',
                                          style: TextStyle(
                                            color: Color(0xFFFF4444),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  // Trading in progress
                  Container(
                    padding: EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFF00FFFF).withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00FFFF)),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'EXECUTING ${_selectedDirection} TRADE...',
                          style: TextStyle(
                            color: Color(0xFF00FFFF),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Please wait...',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                
                Spacer(),
                
                // Instructions
                Text(
                  'Tap LONG if you think ${selectedMarket.split('-')[0]} will go up\nTap SHORT if you think ${selectedMarket.split('-')[0]} will go down\n${isMockMode() ? '(Running in Mock Mode)' : '(Using Extended API)'}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}