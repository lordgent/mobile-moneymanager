import 'package:flutter/material.dart';
import 'package:moneymanager/services/auth/login_service.dart';

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
    Future.delayed(Duration(seconds: 2), () async {
      bool isAuthenticated = await authService.isAuthenticated();
      print("is auth $isAuthenticated ");
      if (isAuthenticated) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/welcome');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 149, 33, 243),
          ),
          child: Center(
            child: SizedBox(
              width: 60, 
              height: 60,
              child: CircularProgressIndicator(
                strokeWidth: 6.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white), 
                backgroundColor: Colors.white30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
