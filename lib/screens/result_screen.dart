import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/xp_provider.dart';

class ResultScreen extends ConsumerStatefulWidget {
  final String direction;
  final double pnl;
  final int xpGained;
  final String? orderId;
  final String? status;
  final String? price;
  final String? error;

  const ResultScreen({
    Key? key,
    required this.direction,
    required this.pnl,
    required this.xpGained,
    this.orderId,
    this.status,
    this.price,
    this.error,
  }) : super(key: key);

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _xpController;
  late Animation<double> _slideAnimation;
  late Animation<int> _xpAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _slideController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    _xpController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );
    
    _xpAnimation = IntTween(begin: 0, end: widget.xpGained).animate(
      CurvedAnimation(parent: _xpController, curve: Curves.easeOut),
    );
    
    // Start animations
    _slideController.forward();
    Future.delayed(Duration(milliseconds: 400), () {
      _xpController.forward();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _xpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentXP = ref.watch(xpProvider);
    final isProfit = widget.pnl >= 0;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TRADE RESULT',
          style: TextStyle(
            color: Color(0xFF00FFFF),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
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
          child: AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 50 * (1 - _slideAnimation.value)),
                child: Opacity(
                  opacity: _slideAnimation.value,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Trade direction and result
                        Container(
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isProfit ? Color(0xFF00FF41) : Color(0xFFFF4444),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: (isProfit ? Color(0xFF00FF41) : Color(0xFFFF4444)).withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Direction
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    widget.direction == 'LONG' ? Icons.trending_up : Icons.trending_down,
                                    color: widget.direction == 'LONG' ? Color(0xFF00FF41) : Color(0xFFFF4444),
                                    size: 32,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    '${widget.direction} ETH-USD',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: 20),
                              
                              // P&L
                              Text(
                                isProfit ? 'PROFIT' : 'LOSS',
                                style: TextStyle(
                                  color: isProfit ? Color(0xFF00FF41) : Color(0xFFFF4444),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              
                              SizedBox(height: 8),
                              
                              Text(
                                '${isProfit ? '+' : ''}\$${widget.pnl.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: isProfit ? Color(0xFF00FF41) : Color(0xFFFF4444),
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 20),
                        
                        // Order details (if available)
                        if (widget.orderId != null || widget.error != null)
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: widget.error != null 
                                    ? Colors.orange 
                                    : Color(0xFF00FFFF).withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.error != null ? 'EXECUTION NOTICE' : 'ORDER DETAILS',
                                  style: TextStyle(
                                    color: widget.error != null 
                                        ? Colors.orange 
                                        : Color(0xFF00FFFF),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(height: 8),
                                if (widget.error != null) ...[
                                  Text(
                                    widget.error!,
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 12,
                                    ),
                                  ),
                                ] else ...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Order ID:',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        widget.orderId ?? 'N/A',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (widget.status != null) ...[
                                    SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Status:',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: widget.status == 'FILLED' 
                                                ? Color(0xFF00FF41).withOpacity(0.2)
                                                : Colors.orange.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            widget.status!,
                                            style: TextStyle(
                                              color: widget.status == 'FILLED' 
                                                  ? Color(0xFF00FF41)
                                                  : Colors.orange,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  if (widget.price != null) ...[
                                    SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Execution Price:',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          '\$${widget.price}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ],
                            ),
                          ),
                        
                        SizedBox(height: 20),
                        
                        // Gasless Transaction Notice
                        if (widget.orderId != null && widget.error == null)
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color(0xFF00FFFF).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xFF00FFFF).withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.flash_on,
                                  color: Color(0xFF00FFFF),
                                  size: 24,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'GASLESS TRANSACTION',
                                        style: TextStyle(
                                          color: Color(0xFF00FFFF),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Gas fees paid by StreetCred Paymaster - Zero cost to you!',
                                        style: TextStyle(
                                          color: Color(0xFF00FFFF),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        
                        if (widget.orderId != null && widget.error == null)
                          SizedBox(height: 20),
                        
                        // XP Gained
                        Container(
                          padding: EdgeInsets.all(20),
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
                              Text(
                                'XP GAINED',
                                style: TextStyle(
                                  color: Color(0xFF00FFFF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              
                              SizedBox(height: 12),
                              
                              AnimatedBuilder(
                                animation: _xpAnimation,
                                builder: (context, child) {
                                  return Text(
                                    '+${_xpAnimation.value} XP',
                                    style: TextStyle(
                                      color: Color(0xFFFFFF00),
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                              
                              SizedBox(height: 8),
                              
                              Text(
                                'Total XP: $currentXP',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 60),
                        
                        // Action buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => context.pop(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF00FFFF).withOpacity(0.1),
                                  side: BorderSide(color: Color(0xFF00FFFF)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: Text(
                                  'TRADE AGAIN',
                                  style: TextStyle(
                                    color: Color(0xFF00FFFF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                            
                            SizedBox(width: 16),
                            
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => context.go('/trade'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFF0080).withOpacity(0.1),
                                  side: BorderSide(color: Color(0xFFFF0080)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: Text(
                                  'MAIN MENU',
                                  style: TextStyle(
                                    color: Color(0xFFFF0080),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}