import 'package:flutter/material.dart';
import 'package:moneymanager/providers/transactions/transaction_controller.dart';
import 'package:moneymanager/widgets/bottom_tab.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneymanager/widgets/transaction_card.dart';
import 'package:get/get.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionController controller = Get.put(TransactionController());
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
    String? selected = monthList[DateTime.now().month - 1];

    void _showFixedModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            height: 400,
            decoration: const BoxDecoration(
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
                            borderRadius: BorderRadius.circular(17)),
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
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 149, 33, 243),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
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

    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        hint: Text("Choose a month"),
                        onChanged: (String? newValue) {},
                        items: monthList
                            .map<DropdownMenuItem<String>>((String bulan) {
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/financial-report');
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 242, 221, 253),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      width: double.infinity,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("See your financial report",
                              style: TextStyle(color: Colors.purple)),
                          Icon(
                            Icons.arrow_right,
                            color: Colors.purple,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Hari ini",
                    textAlign: TextAlign.start,
                  ),
                  Obx(() {
                    return controller.isLoadingToday.value
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                            width: double.infinity,
                            height: 250,
                            child: SingleChildScrollView(
                              child: Container(
                                height: 250,
                                child: NotificationListener<ScrollNotification>(
                                  onNotification: (scrollNotification) {
                                    if (scrollNotification.metrics.pixels ==
                                            scrollNotification
                                                .metrics.maxScrollExtent &&
                                        !controller.isMoreLoading.value) {
                                      controller.fetchTransactions(
                                          rangeType: "now", isLoadMore: true);
                                    }
                                    return false;
                                  },
                                  child: ListView.builder(
                                    itemCount:
                                        controller.todayTransactions.length +
                                            (controller.isMoreLoading.value
                                                ? 1
                                                : 0),
                                    itemBuilder: (context, index) {
                                      if (index ==
                                          controller.todayTransactions.length) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      final transaction =
                                          controller.todayTransactions[index];
                                      return TransactionCard(
                                          transaction: transaction);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                  }),
                  Text("Kemarin"),
                  Obx(() {
                    return controller.isLoadingYesterday.value
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                            width: double.infinity,
                            height: 250,
                            child: SingleChildScrollView(
                              child: Container(
                                height: 240,
                                child: NotificationListener<ScrollNotification>(
                                  onNotification: (scrollNotification) {
                                    if (scrollNotification.metrics.pixels ==
                                            scrollNotification
                                                .metrics.maxScrollExtent &&
                                        !controller.isMoreLoading.value) {
                                      controller.fetchTransactions(
                                          rangeType: "yesterday",
                                          isLoadMore: true);
                                    }
                                    return false;
                                  },
                                  child: ListView.builder(
                                    itemCount: controller
                                            .yesterdayTransactions.length +
                                        (controller.isMoreLoading.value
                                            ? 1
                                            : 0),
                                    itemBuilder: (context, index) {
                                      if (index ==
                                          controller
                                              .yesterdayTransactions.length) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      final transaction = controller
                                          .yesterdayTransactions[index];
                                      return TransactionCard(
                                          transaction: transaction);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                  })
                ],
              ))),
      bottomNavigationBar: BottomTab(),
    );
  }
}
