// ignore_for_file: prefer_const_literals_to_create_immutables,  unnecessary_new, avoid_unnecessary_containers, camel_case_types

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/Inventory/LowStock.dart';
import 'package:renttas_flutter_app/Inventory/ProductInOutNew.dart';
import 'package:renttas_flutter_app/Inventory/Transactions.dart';
import 'package:renttas_flutter_app/Inventory/Storeview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DrawerItems.dart';
import 'MyBuisness.dart';
import 'ProductViewNew.dart';
import 'ViewQutation.dart';

class InentoryDashboardNew extends StatefulWidget {
  const InentoryDashboardNew({super.key});

  @override
  State<InentoryDashboardNew> createState() => _InentoryDashboardNewState();
}

class _InentoryDashboardNewState extends State<InentoryDashboardNew> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String email = "", name = "";

  getshareddata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email')!;
      name = preferences.getString('name')!;
    });
  }

  @override
  void initState() {
    super.initState();
    getshareddata();
  }

  @override
  Widget build(BuildContext context) {
    log("dddddddd");
    return Scaffold(
        key: _scaffoldKey,
        drawer: new DrawerItems(),
        appBar: AppBar(
          backgroundColor: const Color(0xff54854C),
          title: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ],
              ),
              const Flexible(fit: FlexFit.tight, child: SizedBox()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MyBusinessPage())),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Icon(
                        Icons.business,
                        size: 20,
                        color: Color(0xff54854C),
                      )),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, right: 8, bottom: 8, left: 8),
            child: Container(
              color: Colors.white10,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Material(
                        elevation: 5,
                        color: const Color(0xff54854C),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        child: SizedBox(
                          height: 370,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
                            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                              Flexible(
                                child: Material(
                                  borderRadius: BorderRadius.circular(8),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductinOutNew(type: "1", name: "Product In"),
                                      ),
                                    ),
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.add_circle_outline),
                                          const SizedBox(width: 5),
                                          Text(
                                            "Product In",
                                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Flexible(
                                child: Material(
                                  borderRadius: BorderRadius.circular(8),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ProductinOutNew(type: "0", name: "Product Out")),
                                    ),
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.remove_circle_outline),
                                          const SizedBox(width: 5),
                                          Text(
                                            "Product Out",
                                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          ),
                        ),
                      ),
                      Material(
                        elevation: 2.5,
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 18),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Overview",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.download,
                                    color: Colors.greenAccent,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Total In",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                                  ),
                                  const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                  Text(
                                    '1.00',
                                    style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.upload,
                                    color: Colors.orangeAccent[200],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Total Out",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                                  ),
                                  const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                  Text(
                                    '0.00',
                                    style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.propane_sharp, color: Colors.deepPurple[200]),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Products",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                                  ),
                                  const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                  Text(
                                    '1.00',
                                    style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.low_priority, color: Colors.pink[200]),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Low Stocks",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                                  ),
                                  const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                  Text(
                                    '0.00',
                                    style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 9),
                              Row(
                                children: [
                                  const Icon(Icons.handshake, color: Colors.purpleAccent),
                                  const SizedBox(width: 10),
                                  Text(
                                    "In Hand",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                                  ),
                                  const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                  Text(
                                    '1.00',
                                    style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(8),
                        elevation: 5,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductViewNew(),
                            ),
                          ),
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.propane_sharp,
                                    color: Colors.deepPurple[200],
                                    size: 50,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Products",
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(8),
                        elevation: 5,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LowStock())),
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.low_priority,
                                    color: Colors.pink[200],
                                    size: 50,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Low Stocks",
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(8),
                        elevation: 5,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewTransactions())),
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.transcribe_sharp,
                                    color: Colors.orangeAccent,
                                    size: 50,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Transactions",
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(8),
                            elevation: 5,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StoreView())),
                              child: SizedBox(
                                height: 70,
                                width: 150,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.store,
                                        color: Colors.greenAccent,
                                        size: 38,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Stores",
                                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Material(
                            borderRadius: BorderRadius.circular(8),
                            elevation: 5,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ViewQutationMain(),
                                ),
                              ),
                              child: SizedBox(
                                height: 70,
                                width: 150,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.note_alt_rounded,
                                        color: Colors.indigoAccent,
                                        size: 38,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Qutation",
                                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
