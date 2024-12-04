import 'package:flutter/material.dart';
import 'package:moneymanager/widgets/bottom_tab.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Text("Add Transaction"),
        bottomNavigationBar: BottomTab()
    );
  }
}