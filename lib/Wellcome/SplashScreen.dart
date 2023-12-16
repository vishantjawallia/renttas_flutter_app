// ignore_for_file: prefer_interpolation_to_compose_strings, non_constant_identifier_names, unnecessary_overrides, prefer_const_constructors, unused_import


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../LandingPages/LandingPage.dart';
import '../landlord/LandloardDashBord.dart';
import '../tandent/Tenantdashbord.dart';

import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late bool newuser = true;
  late String sw;

  @override
  void initState() {
    super.initState();
    check_if_already_login();
    Future.delayed(Duration(seconds: 3), () {
      newuser == false
          ? sw=="1"?Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                return LandloardDashBord();
                //  LandlordLogin();
              }),
            ):Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return Tenantdashbord();
          //  LandlordLogin();
        }),
      )
          : Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
              return landingpage();
              //  LandlordLogin();
            }));
    });
  }

  // Navigate to the home screen after the splash animation completes

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'logo', // unique tag for the Hero animation
          child: Container(
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/renttas.png"),
              fit: BoxFit.cover,
            )),
          ),
        ),
      ),
    );
  }

  void check_if_already_login() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    newuser = (prefs.getBool('login') ?? true);
    sw=(prefs.getString("sw")?? "0");
    print("newwwww----" + newuser.toString());

    setState(() {
      newuser = (prefs.getBool('login') ?? true);
      sw=(prefs.getString("sw")?? "3");
    });

    // if (newuser == false) {
    //   ///String? name= pref.getString("userid");
    //   Navigator.pushReplacement(
    //       context,
    //       new MaterialPageRoute(
    //           builder: (context) => BottomNavigationScreen()));
    // }
  }
}
