import 'package:flutter/material.dart';

class InfoAccount extends StatelessWidget {
  const InfoAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Mengatur space
      children: [
        Container(
            child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 104, 104, 104),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0), // Padding untuk efek visual
            child: Icon(Icons.person, color: Colors.white),
          ),
        )),
        const Text("September"),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0), // Padding untuk efek visual
            child: Icon(
              Icons.notifications,
              color: Color.fromARGB(255, 153, 43, 226),
              size: 30,
            ),
          ),
        )
      ],
    );
  }
}
