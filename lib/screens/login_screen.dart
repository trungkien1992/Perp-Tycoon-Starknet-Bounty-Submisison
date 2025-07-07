import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_usernameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a username')),
      );
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      await ref.read(authProvider.notifier).mockLogin(_usernameController.text.trim());
      if (mounted) {
        context.go('/trade');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF00FFFF), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF00FFFF).withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Text(
                    'STREETCRED CLASH',
                    style: TextStyle(
                      color: Color(0xFF00FFFF),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                
                SizedBox(height: 8),
                
                Text(
                  'MINIMAL TRADING',
                  style: TextStyle(
                    color: Color(0xFFFF0080),
                    fontSize: 12,
                    letterSpacing: 2,
                  ),
                ),
                
                SizedBox(height: 60),
                
                // Login Form
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xFF00FFFF).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _usernameController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Color(0xFF00FFFF)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00FFFF).withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00FFFF)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onSubmitted: (_) => _handleLogin(),
                      ),
                      
                      SizedBox(height: 20),
                      
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF00FFFF).withOpacity(0.1),
                            side: BorderSide(color: Color(0xFF00FFFF)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00FFFF)),
                                )
                              : Text(
                                  'ENTER TRADING',
                                  style: TextStyle(
                                    color: Color(0xFF00FFFF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 40),
                
                // Mock login note
                Text(
                  'Enter any username to continue',
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