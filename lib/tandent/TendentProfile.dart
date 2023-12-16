// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Common/AboutUs.dart';
import '../Common/PrivacyPolicy.dart';
import '../Common/TermCondition.dart';
import '../Wellcome/LoginPage.dart';
import 'Tenantdashbord.dart';

class TendentProfile extends StatefulWidget {
  const TendentProfile({Key? key}) : super(key: key);

  @override
  State<TendentProfile> createState() => _TendentProfileState();
}

class _TendentProfileState extends State<TendentProfile> {
  String selectedPropertyId = '';
  String selectedSubProptyId = '';
  String userId = '';
  String currency = '';
  String name = '';
  String email = '';
  String phone = '';

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ?? '';
      email = prefs.getString('email') ?? '';
      phone = prefs.getString('phone') ?? '';
      name = prefs.getString('name') ?? '';
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Tenantdashbord()));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: Text('My Account ', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xB7B0B0FF),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 5, left: 5),
                //    alignment: Alignment.center,

                width: double.infinity,
                child: Card(
                  // color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(children: <Widget>[
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 5, left: 10),
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
                              name,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 5, left: 10),
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
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
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
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              phone,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 10, left: 5),
              //   padding: EdgeInsets.only(left: 15),
              //   height: 20,
              //   width: double.infinity,
              //   // color: Colors.grey,
              //   child: Text(
              //     'Help & Support',
              //     style: TextStyle(
              //       fontSize: 16,
              //     ),
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.only(right: 5, left: 5, top: 5),
              //   //    alignment: Alignment.center,
              //   height: 70,
              //
              //   width: double.infinity,
              //   child: Card(
              //     // color: Colors.white70,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20.0),
              //     ),
              //     child: Column(children: <Widget>[
              //       Container(
              //         width: double.infinity,
              //         margin: EdgeInsets.only(top: 12, left: 10),
              //         child: GestureDetector(
              //           onTap: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => MergeProperty()));
              //             /* Navigator.of(context).push(MaterialPageRoute(
              //                 builder: (context) =>
              //                     PropertyPage(userId: userId)));*/
              //           },
              //           child: Row(
              //             children: [
              //               Container(
              //                 height: 30,
              //                 width: 30,
              //                 child: Icon(Icons.manage_history_outlined),
              //               ),
              //               Container(
              //                 padding: EdgeInsets.only(left: 10),
              //                 child: Text(
              //                   'Manage Properties ',
              //                   style: TextStyle(fontSize: 16),
              //                 ),
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //       // Container(
              //       //   margin: EdgeInsets.only(left: 8, right: 8, top: 5),
              //       //   child: Divider(
              //       //     color: Colors.grey,
              //       //   ),
              //       // ),
              //       // InkWell(
              //       //   onTap: () {
              //       //     Navigator.of(context).push(MaterialPageRoute(
              //       //         builder: (context) => LandloardDashBord()));
              //       //   },
              //       //   child: Container(
              //       //     width: double.infinity,
              //       //     margin: EdgeInsets.only(top: 5, left: 10),
              //       //     child: Row(
              //       //       children: [
              //       //         Container(
              //       //           height: 30,
              //       //           width: 30,
              //       //           child: Icon(Icons.switch_access_shortcut),
              //       //         ),
              //       //         Container(
              //       //           padding: EdgeInsets.only(left: 15),
              //       //           child: Text(
              //       //             'Switch Owner View ',
              //       //             style: TextStyle(
              //       //               fontSize: 16,
              //       //             ),
              //       //           ),
              //       //         ),
              //       //       ],
              //       //     ),
              //       //   ),
              //       // ),
              //     ]),
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 5),
                padding: EdgeInsets.only(left: 15),
                height: 20,
                width: double.infinity,
                // color: Colors.grey,
                child: Text(
                  'Others',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 5, left: 5, top: 5),
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
                      onTap: () {
                        Share.share(
                            'hey! check out this new app https://play.google.com/store/search?com.ganlaxmine.renttas');
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 12, left: 10),
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
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 5, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TermCondition()));
                        },
                        child: Row(
                          children: [
                            Container(
                                height: 30,
                                width: 30,
                                child: Icon(Icons.note_alt_rounded)),
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PrivacyPolicy()));
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: Icon(Icons.add_business_outlined),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'About Us',
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
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 5, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutUs()));
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: Icon(Icons.note_alt_outlined),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
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
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
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
              // Container(
              //   margin: EdgeInsets.only(top: 15),
              //   height: 60,
              //   width: double.infinity,
              //   color: Colors.white,
              //   child: Row(
              //     children: [
              //       Column(
              //         children: [
              //           GestureDetector(
              //               onTap: () {
              //                 Navigator.of(context).push(MaterialPageRoute(
              //                     builder: (context) => SettingsPage()));
              //               },
              //               child: Container(
              //                   margin: EdgeInsets.only(top: 10, left: 30),
              //                   height: 20,
              //                   child: Image.asset('assets/images/setting.png'))),
              //           SizedBox(
              //             height: 4,
              //           ),
              //           Container(
              //               margin: EdgeInsets.only(left: 30),
              //               child: Text('Settings'))
              //         ],
              //       ),
              //       Column(
              //         children: [
              //           GestureDetector(
              //               onTap: () {
              //                 Navigator.of(context).push(MaterialPageRoute(
              //                     builder: (context) => typeUser()));
              //               },
              //               child: Container(
              //                   margin: EdgeInsets.only(top: 10, left: 75),
              //                   height: 20,
              //                   child: Image.asset('assets/images/home.png'))),
              //           SizedBox(
              //             height: 4,
              //           ),
              //           Container(
              //               margin: EdgeInsets.only(left: 75),
              //               child: Text('Home'))
              //         ],
              //       ),
              //       Column(
              //         children: [
              //           Container(
              //               margin: EdgeInsets.only(top: 10, left: 85),
              //               height: 20,
              //               child: Image.asset('assets/images/edit.png')),
              //           SizedBox(
              //             height: 4,
              //           ),
              //           Container(
              //               margin: EdgeInsets.only(left: 85),
              //               child: Text('Profile'))
              //         ],
              //       ),
              //     ],
              //   ),
              // )
            ],
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

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
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
      child: Text("Continue"),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("login", true);

        prefs.setString('userId', "");
        prefs.setString('email', "");
        prefs.setString('phone', "");
        prefs.setString('name', "");
        prefs.setString('mbno', "");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LandlordLogin(),
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
