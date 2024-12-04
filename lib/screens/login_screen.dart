import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:cool_alert/cool_alert.dart';
import 'package:moneymanager/utils/Message_global.dart';
import '../services/auth/login_service.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();


  Future<void> saveCredentials() async {
    String email = emailController.text;
    String password = passwordController.text;

    bool success = await authService.login(email, password);

    if (success) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: MessageGlobal.loginSuccessful,
      );
          Navigator.pushReplacementNamed(context, '/');

    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
          text: MessageGlobal.loginFailed,
      );
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
                Container(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/splash");
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 27,
                        ),
                      ),
                      const Text(
                        "Login",
                        style: TextStyle(
                            color: Color.fromARGB(255, 48, 48, 48),
                            fontSize: 26,
                            fontWeight: FontWeight.w600),
                      ),
                      Text("___ __",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.5),
                        ),
                        hintText: 'Enter your email',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 0.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.5),
                        ),
                        hintText: 'Enter your password',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                              color: Colors.blue, width: 0.5), // Warna border
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 25),
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 149, 33, 243),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  // Radius border
                                ),
                              ),
                              onPressed: saveCredentials,
                              child: const Text('Masuk',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600))),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, "/register");
                          },
                          child: Text('Lupa password?'),
                        ),
                      ],
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
