import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import '../providers/auth_provider.dart';
import '../providers/xp_provider.dart';

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
    
    // Simulate trade execution
    await Future.delayed(Duration(seconds: 2));
    
    // Generate random P&L and XP
    final random = math.Random();
    final pnl = (random.nextDouble() - 0.5) * 200; // -100 to +100
    final xpGained = 10 + random.nextInt(20); // 10-30 XP
    
    // Update XP
    ref.read(xpProvider.notifier).gainXP(xpGained);
    
    if (mounted) {
      context.push('/result', extra: {
        'direction': direction,
        'pnl': pnl,
        'xpGained': xpGained,
      });
      
      setState(() {
        _isTrading = false;
        _selectedDirection = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final currentXP = ref.watch(xpProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ETH-USDC TRADING',
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
                // User info
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
                  child: Row(
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
                ),
                
                SizedBox(height: 40),
                
                // Asset info
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.currency_bitcoin,
                            color: Color(0xFF627EEA),
                            size: 32,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'ETH-USDC',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Ethereum / USD Coin',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '\$2,845.67',
                        style: TextStyle(
                          color: Color(0xFF00FF41),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '+2.3% (24h)',
                        style: TextStyle(
                          color: Color(0xFF00FF41),
                          fontSize: 14,
                        ),
                      ),
                    ],
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
                  'Tap LONG if you think ETH will go up\nTap SHORT if you think ETH will go down',
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