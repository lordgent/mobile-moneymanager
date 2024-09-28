import 'package:flutter/material.dart';
import 'package:moneymanager/widgets/bottom_tab.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return const Scaffold(
        body: Text("Profile"),
        bottomNavigationBar: BottomTab()
    );
  }
}