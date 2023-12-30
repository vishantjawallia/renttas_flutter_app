// ignore_for_file: sort_child_properties_last, camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/Inventory/JoinBuisness.dart';

class ViewAllBuisness extends StatefulWidget {
  const ViewAllBuisness({super.key});

  @override
  State<ViewAllBuisness> createState() => _ViewAllBuisnessState();
}

class _ViewAllBuisnessState extends State<ViewAllBuisness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        leading: const BackButton(),
        centerTitle: false,
        title: const Text("My Buisness"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Your buisness ",
                            style: TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xff54854C),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const JoinBuisnessPage(),
          ),
        ),
      ),
    );
  }
}
