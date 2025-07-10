import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'screens/login_screen.dart';
import 'screens/casino_floor_screen.dart';
import 'screens/result_screen.dart';
import 'providers/auth_provider.dart';
import 'services/secure_config_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize secure configuration
  await SecureConfigService.initialize();
  
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
      initialLocation: authState.isAuthenticated ? '/casino' : '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: '/casino',
          builder: (context, state) => CasinoFloorScreen(),
        ),
        GoRoute(
          path: '/upgrade-shop',
          builder: (context, state) => Scaffold(
            appBar: AppBar(title: Text('Upgrade Shop - Coming Soon')),
            body: Center(
              child: Text(
                'Upgrade Shop\nComing in Phase 1',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
        GoRoute(
          path: '/bot-management',
          builder: (context, state) => Scaffold(
            appBar: AppBar(title: Text('Bot Management - Coming Soon')),
            body: Center(
              child: Text(
                'Bot Management\nComing in Phase 1',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
        GoRoute(
          path: '/prestige',
          builder: (context, state) => Scaffold(
            appBar: AppBar(title: Text('Prestige - Coming Soon')),
            body: Center(
              child: Text(
                'Prestige System\nComing in Phase 1',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
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
          return '/casino';
        }
        return null;
      },
    );

    return MaterialApp.router(
      title: 'Perp Tycoon - Casino Idle Game',
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