import 'package:flutter/material.dart';
import 'package:moneymanager/services/auth/login_service.dart';
import 'package:moneymanager/screens/home_screen.dart';
import 'package:moneymanager/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    // Wait for 2 seconds and check the authentication status
    Future.delayed(Duration(seconds: 2), () async {
      bool isAuthenticated = await authService.isAuthenticated();
      print("is auth $isAuthenticated ");
      if (isAuthenticated) {

        Navigator.pushReplacementNamed(context, '/home');
      } else {

        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
