// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/Inventory/NewItem.dart';

import 'Filtertransaction.dart';

class additem extends StatefulWidget {
  const additem({super.key});

  @override
  State<additem> createState() => _additemState();
}

class _additemState extends State<additem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        leading: BackButton(),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Add Item"),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const filtertransaction(),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                  size: 25,
                ),
              ),
            )
          ],
        ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              SizedBox(height: 40),
              Material(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                elevation: 5,
                child: InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const newitem())),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 70,
                    width: 500,
                    child: Row(
                      children: [
                        Text(
                          "product1",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
                        Text(
                          "0.00",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Material(
                borderRadius: BorderRadius.circular(8),
                elevation: 5,
                color: Colors.white,
                child: Container(
                  height: 70,
                  width: 500,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "product2",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Text(
                        "1.00",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
