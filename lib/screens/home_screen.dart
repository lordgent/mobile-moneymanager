import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moneymanager/widgets/bottom_tab.dart';
import 'package:moneymanager/widgets/info_account.dart';
import 'package:moneymanager/widgets/info_balance.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              const InfoAccount(),
              const SizedBox(
                height: 20,
              ),
              const Text("Balance Info",
                  style: TextStyle(
                      color: Color.fromARGB(255, 60, 60, 60),
                      fontSize: 17,
                      fontWeight: FontWeight.w400)),
              const Text("Rp 6.050.000",
                  style: TextStyle(
                      color: Color.fromARGB(255, 69, 69, 69),
                      fontSize: 25,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              const InfoBalance(),
              const SizedBox(height: 10),
              Container(
                height: 300,
                color: const Color.fromARGB(255, 208, 208, 208),
                child: const Center(child: Text("component 3")),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomTab());
  }
}
