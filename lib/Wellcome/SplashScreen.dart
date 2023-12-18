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
    super.initState();
    checkIfAlreadyLogin();
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

    bool newuser = (prefs.getBool('login') ?? true);
    String sw = (prefs.getString("sw") ?? "0");
    // prefs.clear();
    log(sw.toString());
    log(newuser.toString());

    newuser == false
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
            MaterialPageRoute(builder: (context) => const landingpage()),
          );

    if (kDebugMode) {
      print("newwwww----$newuser");
    }

    // setState(() {
    //   newuser = (prefs.getBool('login') ?? true);
    //   sw = (prefs.getString("sw") ?? "3");
    // });
  }
}
