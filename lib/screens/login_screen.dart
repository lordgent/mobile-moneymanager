import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: GestureDetector(
         onTap: () {
          FocusScope.of(context).requestFocus(FocusNode()); // Hilangkan fokus
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("WELCOME",
                style: TextStyle(
                    color: Color.fromARGB(255, 149, 33, 243),
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
             Column(
              children: [
                 TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0), // Radius border
                    borderSide: BorderSide(
                        color: Colors.blue, width: 1), // Warna border
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0), // Radius border
                    borderSide: BorderSide(
                        color: Colors.blue, width: 1), // Warna border
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 149, 33, 243),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      // Radius border
                    ),
                  ),
                  onPressed: () {
                    print('Email: ${emailController.text}');
                    print('Password: ${passwordController.text}');
                    Navigator.pushReplacementNamed(context, "/");
                  },
                  child: Text('Masuk', style: TextStyle(
                      color: Colors.white,
                      fontSize:16,
                      fontWeight: FontWeight.w600))),
                ),
                        ],
             ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/register");
                },
                child: Text('Belum memiliki akun? Daftar'),
              ),
            ],
          )),
      ),
    );
  }
}
