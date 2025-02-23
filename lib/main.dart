import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymanager/providers/transactions/transaction_controller.dart';
import 'package:moneymanager/screens/add_expense_screen.dart';
import 'package:moneymanager/screens/add_income_screen.dart';
import 'package:moneymanager/screens/budget_screen.dart';
import 'package:moneymanager/screens/create_budget_screen.dart';
import 'package:moneymanager/screens/financial_report_screen.dart';
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
  Get.put(TransactionController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Money Manager',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(
            name: '/home',
            page: () => const HomeScreen(),
            binding: BindingsBuilder(() {
              Get.put(TransactionController());
            })),
        GetPage(name: '/transaction', page: () => const TransactionScreen()),
        GetPage(name: '/report', page: () => const ReportScreen()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/register', page: () => const RegisterScreen()),
        GetPage(name: '/create-income', page: () => const AddIncomeScreen()),
        GetPage(name: '/create-expense', page: () => const AddExpenseScreen()),
        GetPage(
            name: '/verification', page: () => const OtpVerificationScreen()),
        GetPage(name: '/budget', page: () => const BudgetScreen()),
        GetPage(name: '/welcome', page: () => const WelcomeScreen()),
        GetPage(name: '/create-budget', page: () => const CreateBudgetScreen()),
        GetPage(name: '/nextPayment', page: () => const NextPayment()),
        GetPage(
            name: '/history-subscription',
            page: () => const HistorySubscription()),
        GetPage(name: '/financial-report', page: () => FinancialReportScreen()),
      ],
      unknownRoute: GetPage(name: '/home', page: () => const HomeScreen()),
    );
  }
}
