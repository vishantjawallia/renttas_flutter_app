// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_build_context_synchronously

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
  const TendentProfile({Key? key}) : super(key: key);

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
        leading: BackButton(),
        backgroundColor: Color(0xff54854C),

        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => Tenantdashbord()));
        //   },
        //   icon: Icon(Icons.arrow_back),
        //   color: Colors.black,
        // ),
        title: Text(
          'My Account ',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Column(
          children: [
            SizedBox(width: 0.0, height: 20),
            Container(
              margin: EdgeInsets.only(top: 10, left: 5),
              padding: EdgeInsets.only(left: 15),
              height: 20,
              width: double.infinity,
              // color: Colors.grey,
              child: Text(
                'User Profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 0.0, height: 10),
            Container(
              margin: EdgeInsets.only(right: 5, left: 5),
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
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 8, left: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: Icon(Icons.verified_user),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                name.capitalizeFirstWord(),
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: Icon(Icons.email),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                email,
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: Icon(Icons.phone),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                phone,
                                style: TextStyle(
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
            SizedBox(width: 0.0, height: 10),
            Container(
              margin: EdgeInsets.only(top: 10, left: 5, bottom: 4),
              padding: EdgeInsets.only(left: 15),
              height: 20,
              width: double.infinity,
              child: Text(
                'Others',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 5, left: 5, top: 5),
              height: 350,
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatScreen(),
                        ));
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 12, left: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: Icon(Icons.chat),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Live Chat',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8, right: 8, top: 5),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Share.share('hey! check out this new app https://play.google.com/store/search?com.ganlaxmine.renttas');
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 8, left: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: Icon(Icons.share),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Share App ',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8, right: 8, top: 5),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 5, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TermCondition()));
                        },
                        child: Row(
                          children: [
                            Container(height: 30, width: 30, child: Icon(Icons.note_alt_rounded)),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Terms & Conditions ',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8, right: 8, top: 5),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 5, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: Icon(Icons.add_business_outlined),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'About Us',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8, right: 8, top: 5),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 5, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: Icon(Icons.note_alt_outlined),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Privacy Policy ',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8, right: 8, top: 5),
                      child: Divider(
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
                        margin: EdgeInsets.only(top: 5, left: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: Icon(Icons.power_settings_new_outlined),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Logout',
                                style: TextStyle(
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
        style: TextStyle(color: Color(0xff54854C)),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Continue",
        style: TextStyle(color: Color(0xff54854C)),
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
            builder: (context) => LandlordLoginNew(),
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
