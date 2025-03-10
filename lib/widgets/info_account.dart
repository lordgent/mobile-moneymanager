import 'package:flutter/material.dart';
import 'package:moneymanager/widgets/date_picker.dart';

class InfoAccount extends StatefulWidget {
  const InfoAccount({super.key});

  @override
  _InfoAccountState createState() => _InfoAccountState();
}

class _InfoAccountState extends State<InfoAccount> {
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
    int currentMonthIndex = DateTime.now().month - 1;
    selected = monthList[currentMonthIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 149, 33, 243),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(Icons.person, color: Colors.white),
        ),
        DatePickerWidget(),
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            child: const Icon(
              Icons.notifications,
              color: Color.fromARGB(255, 153, 43, 226),
              size: 35,
            ),
          ),
        ),
      ],
    );
  }
}
