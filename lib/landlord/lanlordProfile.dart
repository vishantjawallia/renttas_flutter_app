// ignore_for_file: unused_local_variable, avoid_print, use_build_context_synchronously, camel_case_types, unused_element, prefer_interpolation_to_compose_strings, use_super_parameters

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:renttas_flutter_app/landlord/LanguageSwitchScreen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Common/PrivacyPolicy.dart';
import '../Common/TermCondition.dart';
import '../LiveChat/AuthGate.dart';
import '../MergeProperty/MergeProperty.dart';
import '../Wellcome/LoginPage.dart';

import 'LandloardDashBord.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:store_redirect/store_redirect.dart';

class lanlordProfile extends StatefulWidget {
  const lanlordProfile({Key? key}) : super(key: key);

  @override
  State<lanlordProfile> createState() => _lanlordProfileState();
}

class _lanlordProfileState extends State<lanlordProfile> {
  String selectedPropertyId = '';
  String selectedSubProptyId = '';
  String userId = '';
  String currency = '';
  String name = '';
  String email = '';
  String phone = '';

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      selectedPropertyId = prefs.getString('selectedPropertyId') ?? '';
      selectedSubProptyId = prefs.getString('selectedSubProptyId') ?? '';
      userId = prefs.getString('userId') ?? '';
      email = prefs.getString('email') ?? '';
      phone = prefs.getString('phone') ?? '';
      name = prefs.getString('name') ?? '';
      phone = prefs.getString('phone') ?? '';
    });
  }

  _launchWhatsapp(String phoneno) async {
    var whatsapp = "+91" + phoneno;
    var whatsappAndroid = Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  final _dialog = RatingDialog(
    // your app's name?
    title: const Text(
      '',
      style: TextStyle(fontSize: 14),
    ),
    // encourage your user to leave a high rating?
    message: const Text(''),
    // your app's logo?
    image: Image.asset(
      "assets/images/renttas.png",
      height: 30,
      width: 30,
    ),
    submitButtonText: 'Submit',
    onCancelled: () => print('cancelled'),
    onSubmitted: (response) {
      print('rating: ${response.rating}, comment: ${response.comment}');
      if (response.rating < 1.0) {
        // send their comments to your email or anywhere you wish
        // ask the user to contact you instead of leaving a bad review
      } else {
        //go to app store
        //https://play.google.com/store/apps/details?id=com.ganlaxmine.renttas
        StoreRedirect.redirect(androidAppId: 'com.ganlaxmine.renttas', iOSAppId: 'com.ganlaxmine.renttas');
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.green,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            // Navigator.push(context, MaterialPageRoute(builder: (context) => const LandloardDashBord()));
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: const Text('My Account ', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        color: const Color(0xB7B0B0FF),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, right: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10, left: 5),
                  padding: const EdgeInsets.only(left: 15),
                  height: 20,
                  width: double.infinity,
                  // color: Colors.grey,
                  child: const Text(
                    'User Detail:',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 20, right: 4, left: 4),
                      child: Column(children: <Widget>[
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 5, left: 10, bottom: 8),
                          child: Row(
                            children: [
                              const SizedBox(
                                // height: 30,
                                // width: 30,
                                child: Icon(Icons.verified_user),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    // fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 0.0, height: 5),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 5, left: 10, bottom: 8),
                          child: Row(
                            children: [
                              const SizedBox(
                                // height: 30,
                                // width: 30,
                                child: Icon(Icons.email),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  email,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    // fontWeight: FontWeight.w600,
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
                              const SizedBox(
                                // height: 30,
                                // width: 30,
                                child: Icon(Icons.phone),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  phone,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    // fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 5),
                  padding: const EdgeInsets.only(left: 15),
                  height: 20,
                  width: double.infinity,
                  // color: Colors.grey,
                  child: const Text(
                    'Help & Support',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 5, left: 5, top: 5),
                  height: 178,
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 12, left: 10),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const languageswitchscreen())),
                            child: Row(
                              children: [
                                const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Icon(Icons.language),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: const Text(
                                    'Choose language ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        // Container(
                        //   margin: EdgeInsets.only(left: 8, right: 8, top: 5),
                        //   child: Divider(
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        //
                        // Container(
                        //   width: double.infinity,
                        //   margin: EdgeInsets.only(top: 12, left: 10),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       // Navigator.of(context).push(MaterialPageRoute(
                        //       //      builder: (context) =>
                        //       //          PropertyPage(userId: userId)));
                        //     },
                        //     child: Row(
                        //       children: [
                        //         Container(
                        //           height: 30,
                        //           width: 30,
                        //           child: Icon(Icons.manage_history_outlined),
                        //         ),
                        //         Container(
                        //           padding: EdgeInsets.only(left: 10),
                        //           child: Text(
                        //             'Manage Properties ',
                        //             style: TextStyle(fontSize: 16),
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Container(
                          margin: const EdgeInsets.only(left: 8, right: 8, top: 5),
                          child: const Divider(
                            color: Colors.grey,
                          ),
                        ),
                        // InkWell(
                        //   onTap: (){
                        //     /// chat whats app
                        //     _launchWhatsapp("8139084095");
                        //   },
                        //   child: Container(
                        //     width: double.infinity,
                        //     margin: EdgeInsets.only(top: 5, left: 10),
                        //     child: Row(
                        //       children: [
                        //         Container(
                        //           height: 30,
                        //           width: 30,
                        //           child: Icon(Icons.whatshot),
                        //         ),
                        //         Container(
                        //           padding: EdgeInsets.only(left: 15),
                        //           child: Text(
                        //             'Chat on Whatsapp ',
                        //             style: TextStyle(
                        //               fontSize: 16,
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 8, right: 8, top: 5),
                        //   child: Divider(
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        // InkWell(
                        //   onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (context) =>
                        //           accountsreport(userid: userId))),
                        //   child: Container(
                        //     width: double.infinity,
                        //     margin: EdgeInsets.only(top: 5, left: 10),
                        //     child: Row(
                        //       children: [
                        //         Container(
                        //           height: 30,
                        //           width: 30,
                        //           child: Icon(Icons.report),
                        //         ),
                        //         Container(
                        //           padding: EdgeInsets.only(left: 15),
                        //           child: Text(
                        //             'Accounts Report ',
                        //             style: TextStyle(
                        //               fontSize: 16,
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        //
                        // Container(
                        //   margin: EdgeInsets.only(left: 8, right: 8, top: 5),
                        //   child: Divider(
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const MergeProperty()));

                            /// chat whats app
                            // _launchWhatsapp("8139084095");
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 5, left: 10),
                            child: Row(
                              children: [
                                const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Icon(Icons.merge),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: const Text(
                                    'Merge Properties ',
                                    style: TextStyle(
                                      fontSize: 16,
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
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthGate()));

                            /// chat whats app
                            // _launchWhatsapp("8139084095");
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 5, left: 10),
                            child: Row(
                              children: [
                                const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Icon(Icons.chat),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: const Text(
                                    'Live chat',
                                    style: TextStyle(
                                      fontSize: 16,
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
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 5),
                  padding: const EdgeInsets.only(left: 15),
                  height: 20,
                  width: double.infinity,
                  // color: Colors.grey,
                  child: const Text(
                    'Others',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(right: 5, left: 5, top: 5),
                    //    alignment: Alignment.center,
                    height: 300,

                    width: double.infinity,
                    child: Card(
                      // color: Colors.white70,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(children: <Widget>[
                        InkWell(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) => _dialog,
                            );
                            // final InAppReview inAppReview = InAppReview.instance;
                            //
                            // if (await inAppReview.isAvailable()) {
                            //   inAppReview.requestReview();
                            // }
                            if (kDebugMode) {
                              print("Object clickeddd");
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 12, left: 10),
                            child: Row(
                              children: [
                                const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Icon(Icons.reviews_outlined),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: const Text(
                                    'Rate this app ',
                                    style: TextStyle(fontSize: 16),
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
                            // width: double.infinity,
                            margin: const EdgeInsets.only(top: 5, left: 10),
                            child: Row(
                              children: [
                                const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Icon(Icons.share),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: const Text(
                                    'Share App ',
                                    style: TextStyle(fontSize: 16),
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
                                const SizedBox(height: 30, width: 30, child: Icon(Icons.note_alt_rounded)),
                                Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: const Text(
                                    'Terms & Conditions ',
                                    style: TextStyle(
                                      fontSize: 16,
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
                                const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Icon(Icons.note_alt_outlined),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: const Text(
                                    'Privacy Policy ',
                                    style: TextStyle(
                                      fontSize: 16,
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
                          onTap: () => showAlertDialog(context),
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 5, left: 10),
                            child: Row(
                              children: [
                                const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Icon(Icons.power_settings_new_outlined),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Edit Profile',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Settings',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.blue,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
      // Navigator.pop(context);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => const productview()));
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Continue"),
    onPressed: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("login", false);

      await prefs.setString('userId', "");
      await prefs.setString('email', "");
      await prefs.setString('phone', "");
      await prefs.setString('name', "");
      await prefs.setString('mbno', "");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LandlordLogin(),
          ),
          (route) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Confirmation"),
    content: const Text("Are you sure want to logout ?"),
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
