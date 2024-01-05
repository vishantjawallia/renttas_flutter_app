// ignore_for_file:  sized_box_for_whitespace, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/Wellcome/LoginPageNew.dart';
import 'package:renttas_flutter_app/landlord/LanlordProfile.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Common/AboutUs.dart';
import '../Common/PrivacyPolicy.dart';
import '../Common/TermCondition.dart';
import '../chat_module/chat_screen.dart';

class TendentProfile extends StatefulWidget {
  const TendentProfile({super.key});

  @override
  State<TendentProfile> createState() => _TendentProfileState();
}

class _TendentProfileState extends State<TendentProfile> {
  String selectedPropertyId = '';
  String selectedSubPropertyId = '';
  String userId = '';
  String currency = '';
  String name = '';
  String email = '';
  String phone = '';

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ?? '';
      email = prefs.getString('email') ?? 'vishant@gmail.com';
      phone = prefs.getString('phone') ?? '+918054738366';
      name = prefs.getString('name') ?? 'vishant jawallia';
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        leading: const BackButton(),
        backgroundColor: const Color(0xff54854C),

        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => Tenantdashbord()));
        //   },
        //   icon: Icon(Icons.arrow_back),
        //   color: Colors.black,
        // ),
        title: Text(
          'My Account ',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Column(
          children: [
            const SizedBox(width: 0.0, height: 20),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 5),
              padding: const EdgeInsets.only(left: 15),
              height: 20,
              width: double.infinity,
              // color: Colors.grey,
              child: Text(
                'User Profile',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 0.0, height: 10),
            Container(
              margin: const EdgeInsets.only(right: 5, left: 5),
              //    alignment: Alignment.center,

              width: double.infinity,
              child: Card(
                // color: Colors.white70,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 8, left: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: const Icon(Icons.verified_user),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                name.capitalizeFirstWord(),
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: const Icon(Icons.email),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                email,
                                style: const TextStyle(fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: const Icon(Icons.phone),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                phone,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 0.0, height: 10),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 5, bottom: 4),
              padding: const EdgeInsets.only(left: 15),
              height: 20,
              width: double.infinity,
              child: Text(
                'Others',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 5, left: 5, top: 5),
              height: 350,
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ChatScreen(),
                        ));
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 12, left: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: const Icon(Icons.chat),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Live Chat',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 5),
                      child: const Divider(
                        color: Colors.grey,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Share.share('hey! check out this new app https://play.google.com/store/search?com.ganlaxmine.renttas');
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 8, left: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: const Icon(Icons.share),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Share App ',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 5),
                      child: const Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 5, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const TermCondition()));
                        },
                        child: Row(
                          children: [
                            Container(height: 30, width: 30, child: const Icon(Icons.note_alt_rounded)),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Terms & Conditions ',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 5),
                      child: const Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 5, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUs()));
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: const Icon(Icons.add_business_outlined),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'About Us',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 5),
                      child: const Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 5, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicy()));
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: const Icon(Icons.note_alt_outlined),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Privacy Policy ',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 5),
                      child: const Divider(
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showAlertDialog(context);
                        // showLogoutConfirmation(context);
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 5, left: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: const Icon(Icons.power_settings_new_outlined),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Logout',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: const TextStyle(color: Color(0xff54854C)),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Continue",
        style: const TextStyle(color: Color(0xff54854C)),
      ),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setBool("login", false);

        // prefs.setString('userId', "");
        // prefs.setString('email', "");
        // prefs.setString('phone', "");
        // prefs.setString('name', "");
        // prefs.setString('mbno', "");
        await prefs.clear();
        // prefs.setString("sw", "0");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LandlordLoginNew(),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Are you sure want to logout ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
