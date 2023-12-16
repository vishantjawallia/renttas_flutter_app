import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddQutation.dart';

class addclient extends StatefulWidget {
  const addclient({super.key});

  @override
  State<addclient> createState() => _addclientState();
}

class _addclientState extends State<addclient> {
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
                            builder: (context) => const qutationview())),
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
                        Text("Add Client"),
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
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
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

      body:

      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(

            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 80,
                  //color: Colors.red,
                  child: Row(
                    children: [
                      Text(
                        ' Client Name * ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
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
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Enter Client name'),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
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
                        'Address',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 180,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: TextField(
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Enter Address'),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                      )
                    ],
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
