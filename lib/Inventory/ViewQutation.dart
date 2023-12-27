import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/Inventory/DashboardNew.dart';

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
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        leading: const BackButton(),
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Text("Qutation"),
            Flexible(fit: FlexFit.tight, child: SizedBox()),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.search,
                size: 24,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Material(
              borderRadius: BorderRadius.circular(8),
              elevation: 5,
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "hhhh",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "PID- 101",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Email : abcd@gmail.com",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Flexible(fit: FlexFit.tight, child: SizedBox()),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "30/10/2023",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "0.01",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Q NO:!",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        backgroundColor: const Color(0xff54854C),
        // backgroundColor: Colors.blue,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const qutationview(),
          ),
        ),
        // isExtended: true,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
