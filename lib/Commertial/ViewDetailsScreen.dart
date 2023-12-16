import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CommertialDashboard.dart';

class viewdetailscreen extends StatefulWidget {
  const viewdetailscreen({super.key});

  @override
  State<viewdetailscreen> createState() => _viewdetailscreenState();
}

class _viewdetailscreenState extends State<viewdetailscreen> {
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
                        Text("View Details"),
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
      body: InkWell(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => viewdetailscreen())),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "Company name 1",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "ABCD line \n 123 flat \n snjhkhkjhk     ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),



              Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(25)),
                //    color: Colors.white,
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Company name 1",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "ABCD line \n 123 flat \n snjhkhkjhk     ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(40)),
                            //alignment: Alignment.center,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )
                            // Text(
                            //   'Premium',
                            //   style: TextStyle(
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            //   textAlign: TextAlign.center,
                            // ),
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
    );
  }
}
