import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("MONTRA",
                style: TextStyle(
                    color: Color.fromARGB(255, 149, 33, 243),
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
            Column(
              children: [
                SizedBox(
                  height: 400,
                  width: 400,
                  child: Center(
                    child: Image.asset(
                      'assets/images/bg-1-p.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Tau di mana Kamu Uang pergi",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Kelola Pemasukan dan pengeluaranmu sendiri dengan satu genggaman",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign
                            .center, // Menengahkan teks dalam widget Text
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/login");
                  }, // Image tapped
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 149, 33, 243),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Text("Daftar",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/login");
                  }, // Image tapped
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 232, 216, 247),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Text("Masuk",
                        style: TextStyle(
                            color: Color.fromARGB(255, 149, 33, 243),
                            fontSize: 17,
                            fontWeight: FontWeight.w500)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
