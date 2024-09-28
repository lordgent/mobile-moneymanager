import 'package:flutter/material.dart';
import 'package:moneymanager/widgets/bottom_tab.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Text("report screen"),
        bottomNavigationBar: BottomTab()
    );
  }
}