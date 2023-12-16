import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/Inventory/ViewAllBusiness.dart';

class joinbuisnesspage extends StatefulWidget {
  const joinbuisnesspage({super.key});

  @override
  State<joinbuisnesspage> createState() => _joinbuisnesspageState();
}

class _joinbuisnesspageState extends State<joinbuisnesspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const viewallbuisness())),
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
                        Text("Join To Buisness"),
                        // Text(
                        //   "ab@gmail.com",
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // )
                      ],
                    ),
                  ),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  InkWell(
                    onTap: () => {},
                    //
                    // Navigator.push(
                    // context,
                    // MaterialPageRoute(
                    //     builder: (context) => const filtertransaction())),
                    child: Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Save",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            )),
                      ),
                    ),
                  ),
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
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  'To join buisness enter the buisness code',
                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  'or',
                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Scan QR code ',
                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 80,
                  //color: Colors.red,
                  child: Row(
                    children: [
                      Text(
                        ' Your Name',
                        style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 180,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: TextField(
                                  decoration: new InputDecoration.collapsed(hintText: 'Enter your name'),
                                  style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 80,
                  //color: Colors.red,
                  child: Row(
                    children: [
                      Text(
                        ' Your Name',
                        style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 145,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: TextField(
                                      decoration: new InputDecoration.collapsed(hintText: 'Enter your name'),
                                      style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ),
                            Container(
                                // decoration: BoxDecoration(
                                //   border: Border.all(color: Colors.grey),
                                //   borderRadius: BorderRadius.circular(20),
                                // ),
                                child: Icon(
                              Icons.qr_code_scanner_outlined,
                              size: 30,
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'You can get this code for newly buisness',
                  style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
