import 'package:flutter/material.dart';
import 'package:vista/shared/utils/local_storage.dart';
import 'package:vista/features/auth/login_welcome_screen.dart';
import 'package:vista/features/home_pages/home/home.dart';

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool _isLoading = true;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuthenticationStatus();
  }

  Future<void> _checkAuthenticationStatus() async {
    try {
      // Check if user has valid authentication token
      final token = await LocalStorage.read(key: 'auth_token');
      final userProfile = await LocalStorage.read(key: 'user_profile');
      
      setState(() {
        _isAuthenticated = token != null && token.toString().isNotEmpty;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isAuthenticated = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Route to appropriate screen based on authentication status
    return _isAuthenticated ? const HomePage() : const LoginWelcomeScreen();
  }
}
