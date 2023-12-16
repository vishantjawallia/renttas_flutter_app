import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ChangePassword.dart';
import 'Dashboard.dart';
import 'MyBuisness.dart';

class settingsview extends StatefulWidget {
  const settingsview({super.key});

  @override
  State<settingsview> createState() => _settingsviewState();
}

class _settingsviewState extends State<settingsview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //  color: grey[300],
        //   ),
        // ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Container(
            child: Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const inentorydashboard())),
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Settings"),
                        // Text(
                        //   "ab@gmail.com",
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // )
                      ],
                    ),
                  ),
                  // Flexible(fit: FlexFit.tight, child: SizedBox()),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //       padding: EdgeInsets.all(10),
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(40)),
                  //       //alignment: Alignment.center,
                  //       child: Icon(
                  //         Icons.mobile_screen_share_rounded,
                  //         size: 20,
                  //       )
                  //     // Text(
                  //     //   'Premium',
                  //     //   style: TextStyle(
                  //     //     fontSize: 18,
                  //     //     fontWeight: FontWeight.bold,
                  //     //   ),
                  //     //   textAlign: TextAlign.center,
                  //     // ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
      body:
      Container(
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const mybusinesspage())),
                child: Container(
                  height: 160,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(40)),
                          child: Icon(
                            Icons.holiday_village,
                            size: 30,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "My Businesss",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Center(
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const chnagepassword())),
                child: Container(
                  height: 160,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(40)),
                          child: Icon(
                            Icons.password_sharp,
                            size: 30,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Center(
              child: InkWell(
                onTap: () => showAlertDialog(context),
                child: Container(
                  height: 160,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(40)),
                          child: Icon(
                            Icons.delete,
                            size: 30,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Delete My Account",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
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
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirmation"),
    content: Text("Are you sure want to delete ?"),
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
