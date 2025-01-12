import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:moneymanager/utils/Message_global.dart';
import '../services/auth/login_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  bool isButtonDisabled = true;

  void checkFormValidity() {
    setState(() {
      isButtonDisabled = !(emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty);
    });
  }

  Future<void> saveCredentials() async {
    String email = emailController.text;
    String password = passwordController.text;

    setState(() {
      isButtonDisabled = true;
    });

    bool success = await authService.login(email, password);

    if (success) {
      setState(() {
        isButtonDisabled = false;
      });
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: MessageGlobal.loginSuccessful,
      );
      Navigator.pushReplacementNamed(context, '/');
    } else {
      setState(() {
        isButtonDisabled = false;
      });
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: MessageGlobal.loginFailed,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/welcome");
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 27,
                      ),
                    ),
                    const Text(
                      "Login",
                      style: TextStyle(
                        color: Color.fromARGB(255, 48, 48, 48),
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      "___ __",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  _buildTextField(emailController, 'Email'),
                  const SizedBox(height: 16),
                  _buildTextField(passwordController, 'Password',
                      obscureText: true),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isButtonDisabled
                            ? const Color.fromARGB(255, 200, 200, 200)
                            : const Color.fromARGB(255, 149, 33, 243),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onPressed: isButtonDisabled ? null : saveCredentials,
                      child: const Text(
                        'Masuk',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/register");
                },
                child: const Text('Lupa password?'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/register");
                },
                child: const Text('Belum memiliki akun? Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
        ),
        hintText: 'Enter your $label',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.blue, width: 0.5),
        ),
      ),
      onChanged: (_) => checkFormValidity(),
    );
  }
}
