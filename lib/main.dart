import 'package:flutter/material.dart';
import 'package:moneymanager/screens/add_transaction_screen.dart';
import 'package:moneymanager/screens/home_screen.dart';
import 'package:moneymanager/screens/login_screen.dart';
import 'package:moneymanager/screens/profile_screen.dart';
import 'package:moneymanager/screens/register_screen.dart';
import 'package:moneymanager/screens/report_screen.dart';
import 'package:moneymanager/screens/splash_screen.dart';
import 'package:moneymanager/screens/transaction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Manager',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/home': (context) => HomeScreen(), 
        '/transaction': (context) => const TransactionScreen(),
        '/report': (context) => const ReportScreen(),
        '/profile': (context) => ProfileScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/splash': (context) => const SplashScreen(),  
        '/init-transaction': (context) => const AddTransactionScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      },
    );
  }
}
