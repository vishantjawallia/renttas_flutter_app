// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, use_super_parameters, unused_field, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Tabs/TandentAboutUs.dart';
import '../Tabs/TandentBill.dart';
import '../Tabs/TandentDocument.dart';
import 'TendentProfile.dart';

class Tenantdashbord extends StatefulWidget {
  const Tenantdashbord({Key? key}) : super(key: key);

  @override
  State<Tenantdashbord> createState() => _TenantdashbordState();
}

class _TenantdashbordState extends State<Tenantdashbord> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  static String selectedPropertyId = '';
  static String selectedSubPropertyId = '';
  static String userId = '';
  static String name = '';

  bool loadTabbar = false;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedPropertyId = prefs.getString('selectedPropertyId') ?? '';
      selectedSubPropertyId = prefs.getString('selectedSubPropertyId') ?? '';
      userId = prefs.getString('userId') ?? '';
      name = prefs.getString('name') ?? '';
    });
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    bool shouldExit = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Exit'),
          content: Text('Are you sure you want to exit?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                shouldExit = false;
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Exit'),
              onPressed: () {
                shouldExit = true;
                exit(0);
                // Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );

    return shouldExit;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await _showExitConfirmationDialog(context),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 130),
          child: AppBar(
            automaticallyImplyLeading: false, // Remove the back button
            backgroundColor: Color(0xff54854C),
            title: Column(
              children: <Widget>[
                SizedBox(width: 0.0, height: 14),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TendentProfile(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: Text(
                              // 'A',
                              name.isEmpty ? "A" : name.substring(0, 1).toUpperCase(),
                              //  name.toUpperCase(),
                              style: TextStyle(
                                fontSize: 22,
                                color: Color(0xff54854C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Welcome ${name}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottom: TabBar(
              labelStyle: TextStyle(fontSize: 16),
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white, width: 4.0),
                ),
              ),
              // labelColor: const Color(0xff54854C),
              unselectedLabelColor: Colors.white,
              controller: _tabController,
              tabs: const [
                Tab(text: 'Bill'),
                Tab(text: 'Document'),
                Tab(text: 'About'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            TandentBill(),
            TandentDocument(),
            TandentAboutUs(),
          ],
        ),
      ),
    );
  }
}
