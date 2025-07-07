import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'screens/login_screen.dart';
import 'screens/trading_screen.dart';
import 'screens/result_screen.dart';
import 'providers/auth_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: StreetCredMinimalApp(),
    ),
  );
}

class StreetCredMinimalApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    
    final router = GoRouter(
      initialLocation: authState.isAuthenticated ? '/trade' : '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: '/trade',
          builder: (context, state) => TradingScreen(),
        ),
        GoRoute(
          path: '/result',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return ResultScreen(
              direction: extra?['direction'] ?? 'LONG',
              pnl: extra?['pnl'] ?? 0.0,
              xpGained: extra?['xpGained'] ?? 10,
              orderId: extra?['orderId'],
              status: extra?['status'],
              price: extra?['price'],
              error: extra?['error'],
            );
          },
        ),
      ],
      redirect: (context, state) {
        final isAuthenticated = ref.read(authProvider).isAuthenticated;
        final isOnLoginPage = state.matchedLocation == '/';
        
        if (!isAuthenticated && !isOnLoginPage) {
          return '/';
        }
        if (isAuthenticated && isOnLoginPage) {
          return '/trade';
        }
        return null;
      },
    );

    return MaterialApp.router(
      title: 'StreetCred Minimal',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: Color(0xFF0A0A1A),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}