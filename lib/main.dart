import 'package:flutter/material.dart';
import 'package:moneymanager/screens/add_expense_screen.dart';
import 'package:moneymanager/screens/add_income_screen.dart';
import 'package:moneymanager/screens/budget_screen.dart';
import 'package:moneymanager/screens/create_budget_screen.dart';
import 'package:moneymanager/screens/history_subscription.dart';
import 'package:moneymanager/screens/home_screen.dart';
import 'package:moneymanager/screens/login_screen.dart';
import 'package:moneymanager/screens/next_transcation.dart';
import 'package:moneymanager/screens/otp_verification_screen.dart';
import 'package:moneymanager/screens/profile_screen.dart';
import 'package:moneymanager/screens/register_screen.dart';
import 'package:moneymanager/screens/report_screen.dart';
import 'package:moneymanager/screens/splash_screen.dart';
import 'package:moneymanager/screens/transaction_screen.dart';
import 'package:moneymanager/screens/welcome_screen.dart';

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
        '/home': (context) => const HomeScreen(),
        '/transaction': (context) => const TransactionScreen(),
        '/report': (context) => const ReportScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/splash': (context) => const SplashScreen(),
        '/create-income': (context) => const AddIncomeScreen(),
        '/create-expense': (context) => const AddExpenseScreen(),
        '/verification': (context) => const OtpVerificationScreen(),
        '/budget': (context) => const BudgetScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/create-budget': (context) => const CreateBudgetScreen(),
        '/nextPayment': (context) => const NextPayment(),
        '/history-subscription': (context) => const HistorySubscription()
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      },
    );
  }
}
