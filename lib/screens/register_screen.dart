import 'package:flutter/material.dart';
import 'package:moneymanager/services/auth/register_service.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:moneymanager/utils/Message_global.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final RegisterService service = RegisterService();


    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();


  Future<void> saveRegister() async {
    String email = emailController.text;
    String password = passwordController.text;
    String fullName= fullNameController.text;
    String phoneNumber = phoneNumberController.text;

    bool success = await service.register(email, password, fullName, phoneNumber);

    if (success) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: MessageGlobal.registerSuccessful,
        );
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, '/verification');
        });
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "Registration failed. Please try again.",
        );
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, '/register');
        });
      }
  }


    return Scaffold(
      body: GestureDetector(
         onTap: () {
          FocusScope.of(context).requestFocus(FocusNode()); 
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             const Text("Register",
                style: TextStyle(
                    color: Color.fromARGB(255, 149, 33, 243),
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
             Column(
              children: [
            TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                  labelText: 'Fullname',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0), 
                    borderSide: const BorderSide(
                        color: Colors.blue, width: 1), 
                  ),
                ),
              ),
               const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0), 
                    borderSide: const BorderSide(
                        color: Colors.blue, width: 1), 
                  ),
                ),
              ),
              const SizedBox(height: 10),
               TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0), 
                    borderSide: const BorderSide(
                        color: Colors.blue, width: 1), 
                  ),
                ),
              ),
               const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0), 
                    borderSide: const BorderSide(
                        color: Colors.blue, width: 1), 
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
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
                 onPressed: saveRegister,
                  child: const Text('Daftar', style: TextStyle(
                      color: Colors.white,
                      fontSize:16,
                      fontWeight: FontWeight.w600))),
                ),
                      
              ],
             ),
               TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/login");
                },
                child: Text('Sudah memiliki akun? Masuk'),
              )
            ],
          )),
      ),
    );
  }
}