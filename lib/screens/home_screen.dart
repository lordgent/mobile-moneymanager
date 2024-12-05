import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager/models/transaction_model.dart';
import 'package:moneymanager/services/balance/balance_info_service.dart';
import 'package:moneymanager/services/transaction/transaction_service.dart';
import 'package:moneymanager/widgets/bottom_tab.dart';
import 'package:moneymanager/widgets/info_account.dart';
import 'package:moneymanager/widgets/info_balance.dart';
import 'package:moneymanager/widgets/transaction_card.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final balanceInfo = BalanceInfo();
  Balance? balance;
  late Future<List<TransactionModel>?> transactions;
  String _permissionStatus = "Unknown";

  @override
  void initState() {
    super.initState();
    _fetchBalanceInfo();
    _fetchTransactions();
        _checkPermission();
  }

  Future<void> _fetchBalanceInfo() async {
    Balance? fetchedBalance = await balanceInfo.fetchBalanceInfo();
    setState(() {
      balance = fetchedBalance;
    });
  }

  Future<void> _fetchTransactions() async {
    transactions = TransactionService().fetchTransactionService(
      offset: 0,
      limit: 10,
    );
  }

   Future<void> _checkPermission() async {
    PermissionStatus status = await Permission.storage.status;
    setState(() {
      _permissionStatus = status.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            const InfoAccount(),
            const SizedBox(
              height: 20,
            ),
            const Text("Account Balance",
                style: TextStyle(
                    color: Color.fromARGB(255, 60, 60, 60),
                    fontSize: 17,
                    fontWeight: FontWeight.w400)),
            balance != null
                ? Text(
                    'Rp ${NumberFormat("#,##0", "id_ID").format(double.parse(balance!.value))}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 69, 69, 69),
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  )
                : const Text(
                    '-',
                    style: TextStyle(
                        color: Color.fromARGB(255, 69, 69, 69),
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
            const SizedBox(height: 10),
            const InfoBalance(),
            const SizedBox(height: 15),
            Container(
              height: 120,
              width: double.infinity,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Spend Frequency",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 17)),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Recent Transaction",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17)),
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 249, 233, 252),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text("See All",
                            style: TextStyle(
                                color: Color.fromARGB(255, 184, 70, 245),
                                fontWeight: FontWeight.w400,
                                fontSize: 15)),
                      ),
                    ],
                  ),
                  Expanded(
                    child: FutureBuilder<List<TransactionModel>?>(
                      future: transactions,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final transactions = snapshot.data;

                          if (transactions == null || transactions.isEmpty) {
                            return const Center(
                                child: Text('No transactions found.'));
                          }

                          return ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              return TransactionCard(
                                  transaction: transactions[index]);
                            },
                          );
                        } else {
                          return const Center(
                              child: Text('No data available.'));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomTab(),
    );
  }
}
