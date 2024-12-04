import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 104, 104, 104),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
                DropdownButton<String>(
          hint: Text("choose a month"),
          value: selected,
          onChanged: (String? newValue) {
            setState(() {
              selected = newValue!;
            });
          },
          items: monthList.map<DropdownMenuItem<String>>((String bulan) {
            return DropdownMenuItem<String>(
              value: bulan,
              child: Text(bulan),
            );
          }).toList(),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
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


  