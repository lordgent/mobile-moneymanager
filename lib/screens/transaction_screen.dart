import 'package:flutter/material.dart';
import 'package:moneymanager/widgets/bottom_tab.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Text("Transaction Screen"),
        bottomNavigationBar: BottomTab()
    );
  }
}