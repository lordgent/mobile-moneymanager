import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 30),
          Image.asset("assets/images/bg-1-p.png"),
          Container(
            width: double.infinity,
            child:  const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Cara Kontrol Keuanganmu",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 59, 59, 59),),textAlign: TextAlign.center),
              Text("Kelola Pemasukan dan pengeluaranmu sendiri dengan satu genggaman",style: TextStyle(fontSize: 16,color: Colors.grey),textAlign: TextAlign.center,)
            ],
          ),
          ),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 149, 33, 243),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () {
                              Navigator.pushReplacementNamed(context, '/register');

                    },
                    child: const Text('Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600))),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 243, 232, 253),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login');

                    },
                    child: const Text('Login',
                        style: TextStyle(
                            color: Color.fromARGB(255, 149, 33, 243),
                            fontSize: 16,
                            fontWeight: FontWeight.w600))),
              )
            ],
          )
        ],
      ),
    ));
  }
}
