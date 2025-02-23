import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager/models/income_exepense_model.dart';
import 'package:moneymanager/models/transaction_model.dart';
import 'package:moneymanager/providers/transactions/income_expense_controller.dart';
import 'package:moneymanager/providers/transactions/transaction_controller.dart';
import 'package:moneymanager/services/balance/balance_info_service.dart';
import 'package:moneymanager/widgets/bottom_tab.dart';
import 'package:moneymanager/widgets/info_account.dart';
import 'package:moneymanager/widgets/info_balance.dart';
import 'package:moneymanager/widgets/line_chart.dart';
import 'package:moneymanager/widgets/transaction_card.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final balanceInfo = BalanceInfo();
  var totalIncomeToday = IncomeOrExpense("-", "0");
  var totalExpenseToday = IncomeOrExpense("-", "0");
  TransactionController controller = Get.put(TransactionController());
  IncomeExpenseController controllerIncomeExpense =
      Get.put(IncomeExpenseController());

  Balance? balance;
  late Future<List<TransactionModel>?> transactions;
  late Future<List<IncomeOrExpense>?> chartStick;

  String _permissionStatus = "Unknown";

  @override
  void initState() {
    super.initState();
    _fetchBalanceInfo();
    _checkPermission();
  }

  Future<void> _fetchBalanceInfo() async {
    Balance? fetchedBalance = await balanceInfo.fetchBalanceInfo();
    setState(() {
      balance = fetchedBalance;
    });
  }

  Future<void> _checkPermission() async {
    PermissionStatus status = await Permission.storage.status;
    setState(() {
      _permissionStatus = status.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_permissionStatus);
    controllerIncomeExpense.fetchAllData(startDate: "", endDate: "");

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const InfoAccount(),
            const SizedBox(
              height: 10,
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
            InfoBalance(
              incomeAmount: totalIncomeToday.total,
              expenseAmount: totalExpenseToday.total,
              typeExpense: totalExpenseToday.name,
              typeIncome: totalIncomeToday.name,
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Spend Frequency",
                      style: TextStyle(
                        color: Color.fromARGB(255, 48, 48, 48),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: TransactionChart(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Recent Transaction",
                          style: TextStyle(
                              color: Color.fromARGB(255, 48, 48, 48),
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/transaction');
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 260,
                    child: SingleChildScrollView(
                      child: Container(
                        height: 250,
                        child: Obx(() {
                          return controller.isLoadingToday.value
                              ? Center(child: CircularProgressIndicator())
                              : Container(
                                  width: double.infinity,
                                  height: 250,
                                  child: SingleChildScrollView(
                                    child: Container(
                                      height: 250,
                                      child: NotificationListener<
                                          ScrollNotification>(
                                        onNotification: (scrollNotification) {
                                          if (scrollNotification
                                                      .metrics.pixels ==
                                                  scrollNotification.metrics
                                                      .maxScrollExtent &&
                                              !controller.isMoreLoading.value) {
                                            controller.fetchTransactions(
                                                rangeType: "now",
                                                isLoadMore: true);
                                          }
                                          return false;
                                        },
                                        child: ListView.builder(
                                          itemCount: controller
                                                  .todayTransactions.length +
                                              (controller.isMoreLoading.value
                                                  ? 1
                                                  : 0),
                                          itemBuilder: (context, index) {
                                            if (index ==
                                                controller
                                                    .todayTransactions.length) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                            final transaction = controller
                                                .todayTransactions[index];
                                            return TransactionCard(
                                                transaction: transaction);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomTab(),
    );
  }
}
