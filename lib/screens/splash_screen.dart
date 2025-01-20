import 'package:flutter/material.dart';
import 'package:moneymanager/services/auth/login_service.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService authService = AuthService();
  String _permissionStatus = "Unknown";

  @override
  void initState() {
    super.initState();
    _checkPermission(); // Memeriksa izin saat aplikasi dimulai

    // Simulasi pengecekan autentikasi setelah 2 detik
    Future.delayed(Duration(seconds: 2), () async {
      bool isAuthenticated = await authService.isAuthenticated();
      print("is auth $isAuthenticated ");
      if (isAuthenticated) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/welcome');
      }
    });
  }

  Future<void> _checkPermission() async {
    PermissionStatus status = await Permission.storage.status;

    if (!status.isGranted) {
      PermissionStatus newStatus = await Permission.storage.request();
      setState(() {
        _permissionStatus = newStatus.toString();
      });

      if (newStatus.isDenied) {
        _showPermissionDeniedDialog();
      }
    } else {
      setState(() {
        _permissionStatus = status.toString();
      });
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Denied'),
          content:
              Text('The app needs storage permission to function properly.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () async {
                await openAppSettings(); // Arahkan pengguna ke pengaturan aplikasi untuk memberikan izin
                Navigator.of(context).pop();
              },
              child: Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 149, 33, 243),
          ),
          child: Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                strokeWidth: 6.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                backgroundColor: Colors.white30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
