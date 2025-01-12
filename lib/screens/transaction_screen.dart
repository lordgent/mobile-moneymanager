import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moneymanager/models/transaction_model.dart';
import 'package:moneymanager/services/transaction/transaction_service.dart';
import 'package:moneymanager/widgets/bottom_tab.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager/widgets/transaction_card.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String? selected;
  late Future<List<TransactionModel>?> transactions;
  late Future<List<TransactionModel>?> transactionYesterday;

  final List<String> monthList = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
    _fetchTransactionsYesterday();
    final currentMonth = DateTime.now().month;
    selected = monthList[currentMonth - 1];
  }

  Future<void> _fetchTransactions() async {
    DateFormat dateFormat = DateFormat('ddMMyyyy');
    DateTime currentDate = DateTime.now();
    String? startDate;
    String? endDate;
    startDate ??= dateFormat.format(currentDate);
    endDate ??= dateFormat.format(currentDate);

    transactions = TransactionService().fetchTransactionService(
        offset: 0, limit: 10, startDate: startDate, endDate: endDate);
  }

  Future<void> _fetchTransactionsYesterday() async {
    DateFormat dateFormat = DateFormat('ddMMyyyy');
    DateTime currentDate = DateTime.now().subtract(Duration(days: 1));
    String? startDate;
    String? endDate;

    startDate ??= dateFormat.format(currentDate);
    endDate ??= dateFormat.format(currentDate);

    transactionYesterday = TransactionService().fetchTransactionService(
        offset: 0, limit: 5, startDate: startDate, endDate: endDate);
  }

  void _showFixedModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(12),
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Filter Transaction",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 20)),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 249, 233, 252),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Text("reset",
                          style: TextStyle(
                              color: Color.fromARGB(255, 184, 70, 245),
                              fontWeight: FontWeight.w400,
                              fontSize: 15)),
                    )
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                height: 70,
                width: double.infinity,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Filter By",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16))
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                height: 70,
                width: double.infinity,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sort By",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16))
                  ],
                ),
              ),
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Category",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16))
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 149, 33, 243),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Apply',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  hint: Text("Choose a month"),
                  value: selected,
                  onChanged: (String? newValue) {
                    setState(() {
                      selected = newValue;
                    });
                  },
                  items:
                      monthList.map<DropdownMenuItem<String>>((String bulan) {
                    return DropdownMenuItem<String>(
                      value: bulan,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text(
                            bulan,
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  icon: null,
                  underline: SizedBox(),
                ),
                GestureDetector(
                  onTap: () {
                    _showFixedModal(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        'assets/icons/dropdown.svg',
                        width: 35.0,
                        height: 35.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              "Hari ini",
              textAlign: TextAlign.start,
            ),
            Container(
              width: double.infinity,
              height: 260,
              child: SingleChildScrollView(
                child: Container(
                  height: 250,
                  child: FutureBuilder<List<TransactionModel>?>(
                    future: transactions,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
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
                        return const Center(child: Text('No data available.'));
                      }
                    },
                  ),
                ),
              ),
            ),
            Text("Kemarin"),
            Container(
              width: double.infinity,
              height: 260,
              child: SingleChildScrollView(
                child: Container(
                  height: 250,
                  child: FutureBuilder<List<TransactionModel>?>(
                    future: transactionYesterday,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final transactionYesterday = snapshot.data;

                        if (transactionYesterday == null ||
                            transactionYesterday.isEmpty) {
                          return const Center(
                              child: Text('No transactions found.'));
                        }

                        return ListView.builder(
                          itemCount: transactionYesterday.length,
                          itemBuilder: (context, index) {
                            return TransactionCard(
                                transaction: transactionYesterday[index]);
                          },
                        );
                      } else {
                        return const Center(child: Text('No data available.'));
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomTab(),
    );
  }
}
