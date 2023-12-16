import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CommertialDashboard.dart';

class newcontactadd extends StatefulWidget {
  const newcontactadd({super.key});

  @override
  State<newcontactadd> createState() => _newcontactaddState();
}

class _newcontactaddState extends State<newcontactadd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                            builder: (context) => commerialdashboard())),
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
                        Text("New Contact "),
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
                  //   child: Icon(
                  //     Icons.search,
                  //     size: 24,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //       padding: EdgeInsets.all(10),
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(40)),
                  //       //alignment: Alignment.center,
                  //       child: Icon(
                  //         Icons.qr_code_scanner_outlined,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Enter Contact number"),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: TextField(
                            decoration: new InputDecoration.collapsed(
                                hintText: 'Enter Contact number'),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Enter Email"),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: TextField(
                            decoration: new InputDecoration.collapsed(
                                hintText: 'Enter Email'),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                  height: 50,
                  width: 400,
                  child: Center(
                    child: TextButton(
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.blue),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
