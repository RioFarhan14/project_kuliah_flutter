import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_pi/pages/login.dart';
import 'package:project_pi/pages/home.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), navigateToNextScreen);
  }

  void navigateToNextScreen() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // Pengguna belum login, arahkan ke halaman login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        // Pengguna sudah login, arahkan ke halaman home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/GastricCare.png',
          width: 500,
          height: 500,
        ),
      ),
    );
  }
}
