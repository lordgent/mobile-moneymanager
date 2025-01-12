import 'package:flutter/material.dart';
import 'package:moneymanager/services/auth/register_service.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:moneymanager/utils/Message_global.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterService service = RegisterService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  bool isButtonDisabled = true;

  void checkFormValidity() {
    setState(() {
      isButtonDisabled = !(fullNameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          phoneNumberController.text.isNotEmpty &&
          passwordController.text.isNotEmpty);
    });
  }

  Future<void> saveRegister() async {
    String email = emailController.text;
    String password = passwordController.text;
    String fullName = fullNameController.text;
    String phoneNumber = phoneNumberController.text;

    setState(() {
      isButtonDisabled = true;
    });

    bool success =
        await service.register(email, password, fullName, phoneNumber);

    if (success) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: MessageGlobal.registerSuccessful,
      );
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/verification');
      });
      setState(() {
        isButtonDisabled = true;
      });
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Registration failed. Please try again.",
      );
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isButtonDisabled = false;
        });
        Navigator.pushReplacementNamed(context, '/register');
      });
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Register",
                style: TextStyle(
                  color: Color.fromARGB(255, 149, 33, 243),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(fullNameController, 'Fullname'),
              const SizedBox(height: 10),
              _buildTextField(emailController, 'Email'),
              const SizedBox(height: 10),
              _buildTextField(phoneNumberController, 'Phone Number'),
              const SizedBox(height: 10),
              _buildTextField(passwordController, 'Password',
                  obscureText: true),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isButtonDisabled
                        ? const Color.fromARGB(255, 200, 200, 200)
                        : const Color.fromARGB(255, 149, 33, 243),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: isButtonDisabled ? null : saveRegister,
                  child: const Text(
                    'Daftar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/login");
                },
                child: Text('Sudah memiliki akun? Masuk'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membangun TextField dengan label dan border
  Widget _buildTextField(TextEditingController controller, String label,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.blue, width: 1),
        ),
      ),
      onChanged: (_) =>
          checkFormValidity(), // Mengecek setiap kali ada perubahan input
    );
  }
}
