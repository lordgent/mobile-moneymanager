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
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 149, 33, 243),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(Icons.person, color: Colors.white),
        ),
        DropdownButton<String>(
          hint: Text("Choose a month"),
          value: selected,
          onChanged: (String? newValue) {
            setState(() {
              selected = newValue!;
            });
          },
          items: monthList.map<DropdownMenuItem<String>>((String bulan) {
            return DropdownMenuItem<String>(
              value: bulan,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(child: Text(bulan,style: TextStyle(fontSize: 20),textAlign: TextAlign.center),),
              ),
            );
          }).toList(),
          icon: null,  
          underline: SizedBox(),  
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
