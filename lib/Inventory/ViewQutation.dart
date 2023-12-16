import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddQutation.dart';
import 'Dashboard.dart';

class viewqutationmain extends StatefulWidget {
  const viewqutationmain({super.key});

  @override
  State<viewqutationmain> createState() => _viewqutationmainState();
}

class _viewqutationmainState extends State<viewqutationmain> {
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
                        Text("Qutation"),
                        // Text(
                        //   "ab@gmail.com",
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // )
                      ],
                    ),
                  ),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        height: 100,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "hhhh",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "PID- 101",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Email : abcd@gmail.com",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            Flexible(fit: FlexFit.tight, child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "30/10/2023",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "0.01",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Q NO:!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const qutationview()));
        },
      ),
    );
  }
}
