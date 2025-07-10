import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import '../providers/auth_provider.dart';
import '../providers/xp_provider.dart';
import '../app_mode.dart';

class CasinoFloorScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<CasinoFloorScreen> createState() => _CasinoFloorScreenState();
}

class _CasinoFloorScreenState extends ConsumerState<CasinoFloorScreen>
    with TickerProviderStateMixin {
  
  // Animation controllers
  late AnimationController _slotMachineController;
  late AnimationController _pulseController;
  late AnimationController _coinRainController;
  late AnimationController _xpBarController;
  
  // Animations
  late Animation<double> _slotRotation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _coinRainAnimation;
  late Animation<double> _xpBarAnimation;
  
  // Game state
  bool _isTrading = false;
  double _vaultCash = 1000.0; // Starting cash
  String _lastTradeResult = '';
  List<String> _slotSymbols = ['🪙', '💎', '⚡', '🚀', '💰', '🎰'];
  String _currentSlotSymbol = '🎰';
  
  @override
  void initState() {
    super.initState();
    
    // Initialize animation controllers
    _slotMachineController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _coinRainController = AnimationController(
      duration: Duration(milliseconds: 2500),
      vsync: this,
    );
    
    _xpBarController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Setup animations
    _slotRotation = Tween<double>(begin: 0.0, end: 4.0).animate(
      CurvedAnimation(parent: _slotMachineController, curve: Curves.easeOutBack),
    );
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    _coinRainAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _coinRainController, curve: Curves.easeOut),
    );
    
    _xpBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _xpBarController, curve: Curves.elasticOut),
    );
    
    // Start pulsing animation
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _slotMachineController.dispose();
    _pulseController.dispose();
    _coinRainController.dispose();
    _xpBarController.dispose();
    super.dispose();
  }

  Future<void> _executeTapTrade() async {
    if (_isTrading) return;
    
    setState(() {
      _isTrading = true;
    });
    
    // Haptic feedback
    HapticFeedback.mediumImpact();
    
    // Start slot machine animation
    _slotMachineController.reset();
    _slotMachineController.forward();
    
    // Randomly cycle through symbols during spin
    for (int i = 0; i < 8; i++) {
      await Future.delayed(Duration(milliseconds: 150));
      if (mounted) {
        setState(() {
          _currentSlotSymbol = _slotSymbols[math.Random().nextInt(_slotSymbols.length)];
        });
      }
    }
    
    // Simulate trade outcome using volatility
    await Future.delayed(Duration(milliseconds: 1500));
    
    if (mounted) {
      final random = math.Random();
      final isWin = random.nextDouble() < 0.6; // 60% win rate for basic version
      final tradeAmount = 50 + random.nextInt(100); // $50-150 per trade
      final pnl = isWin ? tradeAmount.toDouble() : -tradeAmount.toDouble();
      final xpGained = 10 + random.nextInt(20); // 10-30 XP per trade
      
      // Update vault cash
      setState(() {
        _vaultCash += pnl;
        _lastTradeResult = isWin ? 'MOON! +\$${tradeAmount}' : 'RUG! -\$${tradeAmount}';
        _currentSlotSymbol = isWin ? '🚀' : '💥';
        _isTrading = false;
      });
      
      // Update XP
      ref.read(xpProvider.notifier).gainXP(xpGained);
      
      // Trigger appropriate visual effects
      if (isWin) {
        _triggerWinEffects();
      } else {
        _triggerLossEffects();
      }
      
      // Animate XP bar
      _xpBarController.reset();
      _xpBarController.forward();
    }
  }
  
  void _triggerWinEffects() {
    // Coin rain animation
    _coinRainController.reset();
    _coinRainController.forward();
    
    // Success haptic
    HapticFeedback.heavyImpact();
  }
  
  void _triggerLossEffects() {
    // Light haptic for loss
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final currentXP = ref.watch(xpProvider);
    final xpLevel = (currentXP ~/ 100) + 1; // Level up every 100 XP
    final xpProgress = (currentXP % 100) / 100; // Progress in current level
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '🎰 PERP TYCOON CASINO',
          style: TextStyle(
            color: Color(0xFF00FFFF),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: [
          // Navigation to other screens
          IconButton(
            onPressed: () => context.push('/upgrade-shop'),
            icon: Icon(Icons.upgrade, color: Color(0xFF00FF41)),
            tooltip: 'Upgrade Shop',
          ),
          IconButton(
            onPressed: () => context.push('/bot-management'),
            icon: Icon(Icons.smart_toy, color: Color(0xFFFFD700)),
            tooltip: 'Bot Management',
          ),
          IconButton(
            onPressed: () => context.push('/prestige'),
            icon: Icon(Icons.emoji_events, color: Color(0xFFFF6B6B)),
            tooltip: 'Prestige',
          ),
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
              Color(0xFF0A0A1A), // Dark purple
              Color(0xFF1A1A2E), // Deep blue
              Color(0xFF16213E), // Navy
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // Top Bar - XP and Vault Cash
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Color(0xFF00FFFF).withOpacity(0.6),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF00FFFF).withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // User info and vault cash
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                'Level $xpLevel Trader',
                                style: TextStyle(
                                  color: Color(0xFF00FF41),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.account_balance, color: Color(0xFFFFD700), size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    '\$${_vaultCash.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      color: Color(0xFFFFD700),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Vault Cash',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 12),
                      
                      // XP Bar
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'XP: $currentXP',
                                style: TextStyle(
                                  color: Color(0xFF00FF41),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Next Level: ${100 - (currentXP % 100)} XP',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          AnimatedBuilder(
                            animation: _xpBarAnimation,
                            builder: (context, child) {
                              return Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                child: FractionallySizedBox(
                                  widthFactor: xpProgress * _xpBarAnimation.value,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      gradient: LinearGradient(
                                        colors: [Color(0xFF00FF41), Color(0xFF00FFFF)],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 40),
                
                // Slot Machine Display
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color(0xFFFFD700).withOpacity(0.7),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFFFD700).withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'TRADING CASINO',
                        style: TextStyle(
                          color: Color(0xFFFFD700),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      
                      SizedBox(height: 30),
                      
                      // Slot Machine Symbol
                      AnimatedBuilder(
                        animation: _slotRotation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _slotRotation.value * 2 * math.pi,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Color(0xFF00FFFF),
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  _currentSlotSymbol,
                                  style: TextStyle(fontSize: 60),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      
                      SizedBox(height: 20),
                      
                      // Last trade result
                      if (_lastTradeResult.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: _lastTradeResult.contains('MOON') 
                                ? Color(0xFF00FF41).withOpacity(0.2)
                                : Color(0xFFFF4444).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _lastTradeResult,
                            style: TextStyle(
                              color: _lastTradeResult.contains('MOON') 
                                  ? Color(0xFF00FF41)
                                  : Color(0xFFFF4444),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                
                SizedBox(height: 50),
                
                // Main Tap to Trade Button
                if (!_isTrading) 
                  AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseAnimation.value,
                        child: GestureDetector(
                          onTap: _executeTapTrade,
                          child: Container(
                            width: 200,
                            height: 80,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF00FF41),
                                  Color(0xFF00FFFF),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF00FF41).withOpacity(0.5),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'TAP TO TRADE',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                else
                  Container(
                    width: 200,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00FFFF)),
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'TRADING...',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                
                Spacer(),
                
                // Coin Rain Effect (when winning)
                AnimatedBuilder(
                  animation: _coinRainAnimation,
                  builder: (context, child) {
                    if (_coinRainAnimation.value == 0) return SizedBox.shrink();
                    
                    return Positioned.fill(
                      child: IgnorePointer(
                        child: Stack(
                          children: List.generate(10, (index) {
                            final random = math.Random();
                            final x = random.nextDouble();
                            final delay = random.nextDouble() * 0.5;
                            
                            return AnimatedPositioned(
                              duration: Duration(milliseconds: 100),
                              left: MediaQuery.of(context).size.width * x,
                              top: -50 + (200 * _coinRainAnimation.value * (1 + delay)),
                              child: Text(
                                '💰',
                                style: TextStyle(fontSize: 24),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  },
                ),
                
                // Bottom instructions
                Text(
                  'Tap to execute a leveraged trade!\nEarn XP and cash with each trade\n${isMockMode() ? '(Demo Mode)' : '(Live Trading)'}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
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