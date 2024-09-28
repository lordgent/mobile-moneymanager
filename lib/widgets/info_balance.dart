import 'package:flutter/material.dart';

class InfoBalance extends StatelessWidget {
  const InfoBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF00A86B), // Menggunakan warna kustom
              borderRadius: BorderRadius.circular(30),
            ),
            height: 80, // Tinggi yang ditentukan
            child: const Center(
              child: Text("Income",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 17)),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFD3C4A),
              borderRadius: BorderRadius.circular(30),
            ),
            height: 80,
            child: const Center(
              child: Text("Expense",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 17)),
            ),
          ),
        ),
      ],
    );
  }
}
