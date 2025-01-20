import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/services/auth/login_service.dart';
import 'package:moneymanager/services/balance/balance_info_service.dart';
import 'package:moneymanager/utils/message_global.dart';
import 'package:moneymanager/widgets/bottom_tab.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService authService = AuthService();
  final balanceInfo = BalanceInfo();
  Balance? balance;

  @override
  void initState() {
    super.initState();
    _fetchBalanceInfo();
  }

  Future<void> _fetchBalanceInfo() async {
    Balance? fetchedBalance = await balanceInfo.fetchBalanceInfo();

    setState(() {
      balance = fetchedBalance;
    });
  }

  void logout() {
    authService.logout();
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: MessageGlobal.logout,
    );
    Navigator.pushReplacementNamed(context, '/welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 149, 33, 243),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.person),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("name",
                          style: TextStyle(
                              color: Color.fromARGB(255, 62, 62, 62),
                              fontWeight: FontWeight.w400,
                              fontSize: 15)),
                      Text(balance != null ? balance!.fullName : "-",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 62, 62, 62),
                              fontWeight: FontWeight.w400,
                              fontSize: 22))
                    ],
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              margin: const EdgeInsets.only(top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/collab.png",
                            width: 47,
                            height: 47,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: const Text(
                              "Subscription",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 62, 62, 62),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 60,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Image.asset("assets/icons/settings.png"),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: const Text(
                              "Settings",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 62, 62, 62),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 60,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Image.asset("assets/icons/export.png"),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: const Text(
                              "Export Data",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 62, 62, 62),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: logout,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 60,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Image.asset("assets/icons/logout.png"),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 62, 62, 62),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomTab(),
    );
  }
}
