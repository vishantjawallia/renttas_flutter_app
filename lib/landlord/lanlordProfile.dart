// ignore_for_file: unused_local_variable, avoid_print, use_build_context_synchronously, camel_case_types, unused_element, prefer_interpolation_to_compose_strings, use_super_parameters, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/Wellcome/LoginPageNew.dart';

import 'package:renttas_flutter_app/landlord/LanguageSwitchScreen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Common/PrivacyPolicy.dart';
import '../Common/TermCondition.dart';

import 'package:rating_dialog/rating_dialog.dart';
import 'package:store_redirect/store_redirect.dart';

import '../MergeProperty/MergeProperty.dart';
import '../chat_module/chat_screen.dart';

class LanlordProfile extends StatefulWidget {
  const LanlordProfile({Key? key}) : super(key: key);

  @override
  State<LanlordProfile> createState() => _LanlordProfileState();
}

class _LanlordProfileState extends State<LanlordProfile> {
  String selectedPropertyId = '';
  String selectedSubPropertyId = '';
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
      selectedSubPropertyId = prefs.getString('selectedSubPropertyId') ?? '';
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
        SnackBar(
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
    title: Text(
      'Renttas',
    ),
    message: Text('Rate our App ?'),
    image: Image.asset(
      "assets/images/splash_logo.png",
      fit: BoxFit.fill,
    ),
    submitButtonText: 'Submit',
    onCancelled: () => print('cancelled'),
    onSubmitted: (response) {
      print('rating: ${response.rating}, comment: ${response.comment}');
      if (response.rating < 1.0) {
      } else {
        StoreRedirect.redirect(androidAppId: 'com.ganlaxmine.renttas', iOSAppId: 'com.ganlaxmine.renttas');
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff54854C),
        leading: BackButton(),
        title: Text(
          "my_account".tr(),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 40),
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 10,
                  left: 5,
                ),
                padding: EdgeInsets.only(left: 15),
                height: 20,
                width: double.infinity,
                child: Text(
                  "user_detail".tr(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 20, right: 4, left: 4),
                    child: Column(children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 5, left: 10, bottom: 8),
                        child: Row(
                          children: [
                            Icon(Icons.person),
                            Container(
                              padding: EdgeInsets.only(left: 14),
                              child: Text(
                                name.capitalizeFirstWord(),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 5, left: 10, bottom: 8),
                        child: Row(
                          children: [
                            Icon(Icons.email),
                            Container(
                              padding: EdgeInsets.only(left: 14),
                              child: Text(
                                email,
                                style: TextStyle(fontSize: 16),
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
                            Icon(Icons.phone),
                            Container(
                              padding: EdgeInsets.only(left: 14),
                              child: Text(
                                phone,
                                style: TextStyle(fontSize: 16),
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
                margin: EdgeInsets.only(top: 10, left: 5),
                padding: EdgeInsets.only(left: 15),
                height: 20,
                width: double.infinity,
                child: Text(
                  "help_support".tr(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 5, left: 5, top: 5),
                height: 178,
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 12, left: 10),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LanguageSwitchScreen())),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(Icons.language),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 14),
                                child: Text(
                                  'Choose language ',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8, right: 8, top: 5),
                        child: Divider(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MergeProperty())),
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 5, left: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(Icons.merge),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 14),
                                child: Text(
                                  "merge_properties".tr(),
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
                        margin: EdgeInsets.only(left: 8, right: 8, top: 5),
                        child: Divider(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen())),
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 5, left: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(Icons.chat),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 14),
                                child: Text(
                                  "live_chat".tr(),
                                  // 'Live chat',
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
                margin: EdgeInsets.only(top: 10, left: 5),
                padding: EdgeInsets.only(left: 15),
                height: 20,
                width: double.infinity,
                // color: Colors.grey.shade300,
                child: Text(
                  'others'.tr(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(
                    right: 5,
                    left: 5,
                  ),
                  width: double.infinity,
                  child: Card(
                    // color: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) => _dialog,
                              );
                              if (kDebugMode) {
                                print("Object clickeddd");
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(Icons.reviews_outlined),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 14),
                                    child: Text(
                                      "rate_this_app".tr(),
                                      // 'Rate this app ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8, right: 8, top: 5),
                            child: Divider(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          InkWell(
                            onTap: () => Share.share('hey! check out this new app https://play.google.com/store/search?com.ganlaxmine.renttas'),
                            child: Container(
                              margin: EdgeInsets.only(top: 5, left: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(Icons.share),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 14),
                                    child: Text(
                                      "share_app".tr(),
                                      // 'Share App ',

                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8, right: 8, top: 5),
                            child: Divider(
                              color: Colors.grey.shade300,
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
                                  SizedBox(height: 30, width: 30, child: Icon(Icons.note_alt_rounded)),
                                  Container(
                                    padding: EdgeInsets.only(left: 14),
                                    child: Text(
                                      "terms_condition".tr(),
                                      // 'Terms & Conditions ',
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
                            margin: EdgeInsets.only(left: 8, right: 8, top: 5),
                            child: Divider(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 5, left: 10),
                            child: GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy())),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(Icons.note_alt_outlined),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 14),
                                    child: Text(
                                      "privacy_policy".tr(),
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
                            margin: EdgeInsets.only(left: 8, right: 8, top: 5),
                            child: Divider(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => showAlertDialog(context),
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 5, left: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(Icons.power_settings_new_outlined),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 14),
                                    child: Text(
                                      "logout".tr(),
                                      // 'Logout',
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text(
      "cancel".tr(),
      style: TextStyle(color: Color(0xff54854C)),
    ),
    onPressed: () => Navigator.pop(context),
  );
  Widget continueButton = TextButton(
    child: Text(
      "continue".tr(),
      style: TextStyle(color: Color(0xff54854C)),
    ),
    onPressed: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LandlordLoginNew()), (route) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "confirmation".tr(),
    ),
    content: Text(
      "are_you_sure_logout".tr(),
    ),
    actions: [cancelButton, continueButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

extension CapitalizeFirstWordExtension on String {
  String capitalizeFirstWord() {
    if (isEmpty) {
      return this;
    }

    return this[0].toUpperCase() + substring(1);
  }
}
