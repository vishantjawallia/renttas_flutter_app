// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:renttas_flutter_app/Inventory/AddQutation.dart';
import 'package:renttas_flutter_app/Inventory/NewItem.dart';

class additem extends StatefulWidget {
  const additem({super.key});

  @override
  State<additem> createState() => _additemState();
}

class _additemState extends State<additem> {
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
                        Text("Add Item"),
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
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.search,
                          size: 25,
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            child: Column(
              children: [
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const newitem())),
                  child: Container(
                    height: 70,

                    width: 500,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Text(
                          "product1",
                          style: TextStyle(color: Colors.black),
                        ),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
                        Text(
                          "0.00",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  height: 70,
                  width: 500,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Text(
                        "product2",
                        style: TextStyle(color: Colors.black),
                      ),
                      Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Text(
                        "1.00",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
