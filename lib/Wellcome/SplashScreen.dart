// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../LandingPages/LandingPage.dart';
import '../landlord/LandloardDashBord.dart';
import '../tandent/Tenantdashbord.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  // late bool newuser = true;
  // late String sw;

  @override
  void initState() {
    checkIfAlreadyLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'logo',
          child: Container(
            margin: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/splash_logo.png",
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkIfAlreadyLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.clear();

    bool login = prefs.getBool('login') ?? false;
    String sw = prefs.getString("sw") ?? "0";
    log(sw.toString());
    log(login.toString());

    login == true
        ? sw == "1"
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LandloardDashBord()),
              )
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Tenantdashbord()),
              )
        : Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LandingPage()),
          );

    if (kDebugMode) {
      print("newwwww----$login");
    }

    // setState(() {
    //   newuser = (prefs.getBool('login') ?? true);
    //   sw = (prefs.getString("sw") ?? "3");
    // });
  }
}
