import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import '../providers/auth_provider.dart';
import '../providers/xp_provider.dart';
import '../providers/game_state_provider.dart';
import '../providers/idle_earnings_provider.dart';
import '../app_mode.dart';

class CasinoFloorScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<CasinoFloorScreen> createState() => _CasinoFloorScreenState();
}

class _CasinoFloorScreenState extends ConsumerState<CasinoFloorScreen>
    with TickerProviderStateMixin {
  
  // Animation controllers
  late AnimationController _coinTossController;
  late AnimationController _pulseController;
  late AnimationController _coinRainController;
  late AnimationController _xpBarController;
  
  // Animations
  late Animation<double> _coinFlip;
  late Animation<double> _pulseAnimation;
  late Animation<double> _coinRainAnimation;
  late Animation<double> _xpBarAnimation;
  
  // Game state
  bool _isTrading = false;
  TradeResult? _lastTradeResult;
  String _selectedMarket = 'BTC-USD';
  
  // Available markets
  final List<String> _markets = ['BTC-USD', 'ETH-USD', 'AVAX-USD', 'DOGE-USD', 'USDC-USD'];
  
  @override
  void initState() {
    super.initState();
    
    // Initialize animation controllers
    _coinTossController = AnimationController(
      duration: Duration(milliseconds: 2000),
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
    _coinFlip = Tween<double>(begin: 0.0, end: 6.0).animate(
      CurvedAnimation(parent: _coinTossController, curve: Curves.easeOutBack),
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
    _coinTossController.dispose();
    _pulseController.dispose();
    _coinRainController.dispose();
    _xpBarController.dispose();
    super.dispose();
  }

  Future<void> _executeCoinToss() async {
    if (_isTrading) return;
    
    final coinType = ref.read(coinTypeProvider);
    final direction = ref.read(tradingDirectionProvider);
    
    setState(() {
      _isTrading = true;
    });
    
    // Haptic feedback
    HapticFeedback.mediumImpact();
    
    // Start coin toss animation
    _coinTossController.reset();
    _coinTossController.forward();
    
    // Execute the trade through game state provider
    try {
      final result = await ref.read(gameStateProvider.notifier).executeCoinToss(
        direction: direction,
        coinType: coinType,
        market: _selectedMarket,
      );
      
      if (mounted) {
        setState(() {
          _lastTradeResult = result;
          _isTrading = false;
        });
        
        // Update XP
        ref.read(xpProvider.notifier).gainXP(result.xpGained);
        
        // Trigger appropriate visual effects
        if (result.isWin) {
          _triggerWinEffects();
        } else {
          _triggerLossEffects();
        }
        
        // Animate XP bar
        _xpBarController.reset();
        _xpBarController.forward();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isTrading = false;
        });
      }
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

  /// Build direction selection button
  Widget _buildDirectionButton(TradingDirection buttonDirection, TradingDirection selectedDirection) {
    final isSelected = buttonDirection == selectedDirection;
    return GestureDetector(
      onTap: () {
        ref.read(tradingDirectionProvider.notifier).state = buttonDirection;
        HapticFeedback.selectionClick();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected 
              ? (buttonDirection == TradingDirection.long ? Color(0xFF00FF41) : Color(0xFFFF4444))
              : Colors.transparent,
          border: Border.all(
            color: buttonDirection == TradingDirection.long ? Color(0xFF00FF41) : Color(0xFFFF4444),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              buttonDirection.emoji,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(width: 8),
            Text(
              buttonDirection.displayName,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final gameState = ref.watch(gameStateProvider);
    final coinType = ref.watch(coinTypeProvider);
    final direction = ref.watch(tradingDirectionProvider);
    final idleEarnings = ref.watch(idleEarningsProvider);
    final offlineEarnings = ref.watch(offlineEarningsProvider);
    
    final xpState = ref.watch(xpProvider);
    final currentXP = xpState.localXP;
    final xpLevel = xpState.level;
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
                                    '\$${gameState.vaultCash.toStringAsFixed(0)}',
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
                
                // Coin Toss Table
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
                        '🪙 COIN TOSS TABLE',
                        style: TextStyle(
                          color: Color(0xFFFFD700),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      
                      SizedBox(height: 20),
                      
                      // Market & Coin Selection
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Market selector
                          Column(
                            children: [
                              Text('Market', style: TextStyle(color: Colors.white70, fontSize: 12)),
                              DropdownButton<String>(
                                value: _selectedMarket,
                                dropdownColor: Colors.black,
                                style: TextStyle(color: Color(0xFF00FFFF), fontSize: 14),
                                items: _markets.map((market) => DropdownMenuItem(
                                  value: market,
                                  child: Text(market),
                                )).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() => _selectedMarket = value);
                                  }
                                },
                              ),
                            ],
                          ),
                          // Coin type selector
                          Column(
                            children: [
                              Text('Coin', style: TextStyle(color: Colors.white70, fontSize: 12)),
                              DropdownButton<CoinType>(
                                value: coinType,
                                dropdownColor: Colors.black,
                                style: TextStyle(color: Color(0xFFFFD700), fontSize: 14),
                                items: CoinType.values.map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(type.emoji),
                                      SizedBox(width: 4),
                                      Text(type.displayName),
                                    ],
                                  ),
                                )).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    ref.read(coinTypeProvider.notifier).state = value;
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 30),
                      
                      // Coin with flip animation
                      AnimatedBuilder(
                        animation: _coinFlip,
                        builder: (context, child) {
                          return Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(_coinFlip.value),
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.8),
                                border: Border.all(
                                  color: Color(0xFFFFD700),
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFFFD700).withOpacity(0.3),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  _lastTradeResult?.coinEmoji ?? coinType.emoji,
                                  style: TextStyle(fontSize: 60),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      
                      SizedBox(height: 20),
                      
                      // Long/Short Selection
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDirectionButton(TradingDirection.long, direction),
                          _buildDirectionButton(TradingDirection.short, direction),
                        ],
                      ),
                      
                      SizedBox(height: 20),
                      
                      // Last trade result
                      if (_lastTradeResult != null)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: _lastTradeResult!.isWin 
                                ? Color(0xFF00FF41).withOpacity(0.2)
                                : Color(0xFFFF4444).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Text(
                                _lastTradeResult!.pnlText,
                                style: TextStyle(
                                  color: _lastTradeResult!.isWin 
                                      ? Color(0xFF00FF41)
                                      : Color(0xFFFF4444),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'XP +${_lastTradeResult!.xpGained} | ${_lastTradeResult!.direction.displayName}',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
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
                          onTap: _executeCoinToss,
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
                                'TOSS COIN',
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
                            'TOSSING...',
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
                  'Choose LONG (Heads) or SHORT (Tails) and toss the coin!\nEarn XP and cash based on market volatility\n${isMockMode() ? '(Demo Mode)' : '(Live Trading)'}',
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