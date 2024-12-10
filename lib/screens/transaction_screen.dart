import 'package:flutter/material.dart';
import 'package:moneymanager/widgets/bottom_tab.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String? selected;

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
    final currentMonth = DateTime.now().month;
    selected = monthList[currentMonth - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              height: 32,
            ),
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
                Container(
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
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomTab(),
    );
  }
}
