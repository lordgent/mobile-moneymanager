import 'package:flutter/material.dart';
import 'package:moneymanager/services/auth/register_service.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:moneymanager/utils/message_global.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final RegisterService service = RegisterService();

  final List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());

  Future<void> sendOtp() async {
    String code = controllers.map((controller) => controller.text).join();

    bool success = await service.verificationOtp(code);

    if (success) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: MessageGlobal.registerSuccessful,
        );
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, '/home');
        });
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "otp failed. Please try again.",
        );
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, '/verification');
        });
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/register");
                  },
                  child: const Icon(
                    color: Colors.black,
                    Icons.arrow_back,
                    size: 26,
                  ),
                ),
                const Text(
                  "Verification",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 30),
            const Text(
              "Enter your Verification Code",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Text(
              "We send verification code to your email",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 65,
                  child: TextField(
                    controller: controllers[index],
                    obscureText: true,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                );
              }),
            ),
           const SizedBox(height: 20),
           Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: sendOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 149, 33, 243),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                child: const Text('Verify',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
            ),
           const SizedBox(height: 20),
            const Center(
              child: Text(
                "I didn’t receive the code? Send again",
                style: TextStyle(
                  color: Color.fromARGB(255, 149, 33, 243),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
