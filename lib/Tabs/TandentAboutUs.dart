// ignore_for_file:  unused_local_variable, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, avoid_print, use_super_parameters

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Common/ApiUrl.dart';
import '../widgets/global_widget.dart';

class TandentAboutUs extends StatefulWidget {
  const TandentAboutUs({Key? key}) : super(key: key);

  @override
  State<TandentAboutUs> createState() => _TandentAboutUsState();
}

class _TandentAboutUsState extends State<TandentAboutUs> {
  String userId = '';
  String name = '';
  String mobile = '';
  String host = '';
  String stcode = "";
  bool isLoading = false;
  bool isDocTheir = false;
  String proprname = "";

  String address = "";
  String ownername = "";
  String ownerdocname = "";
  String image = "";
  String rent = "";
  String maintanance = "";
  String electricy = "";

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ?? '';
      name = prefs.getString('name') ?? '';
      mobile = prefs.getString('phone') ?? '';
    });
    // await Future.delayed(Duration(seconds: 2));
    loadDoc(mobile);
  }

  Future<void> loadDoc(String mobile) async {
    setState(() => isLoading = true);
    SharedPreferences logindata = await SharedPreferences.getInstance();
    String? userid = logindata.getString("userId");

    Map data = {"mobileNumber": mobile};

    final headerss = {'Content-Type': 'application/json'};

    print(data.toString());
    final response = await http.post(
      Uri.parse(ApiUrl.getDocComplteByMobile),
      headers: headerss,
      body: jsonEncode(data),
    );
    setState(() => isLoading = false);
    print("get Doccompletemobile ===" + response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);

      if (resposne['statuscode'].toString().contains("200")) {
        setState(() {
          proprname = resposne['propertyname'].toString();
          address = resposne['address'].toString();
          ownername = resposne['ownername'].toString();
          ownerdocname = resposne['ownerdocname'].toString();
          image = resposne['ownerdocimage'].toString();
          rent = resposne['rent'].toString();
          maintanance = resposne['maintenance'].toString();
          electricy = resposne['electricitytype'].toString();

          // pincode=resposne['pincode'].toString();
        });
        // No response code here
        //String id,address,picode;
        //  Navigator.pop(context);
        ///  getdatas();

        print("Login Successfully Completed !!!!!!!!!!!!!!!!");
      } else {
        setState(() => stcode = 201.toString());
      }
    } else {
      setState(() => stcode = 201.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading == true
          ? GlobalWidgets.loading()
          : stcode == "201"
              ? GlobalWidgets.notFound('About')
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Property Details :-',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Divider(),
                        Row(
                          children: [
                            Text(
                              "Property Name :",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              proprname,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Text(
                              "Address :",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              address,
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        const Divider(),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Property Owner Details :-", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(height: 18),
                        const Divider(),
                        Row(
                          children: [
                            Text(
                              "Owner Name :",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              ownername,
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Text(
                              "DOC NAME :",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              ownerdocname,
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        const Divider(),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Rent Details :-", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(height: 18),
                        const Divider(),
                        Row(
                          children: [
                            Text(
                              "Rent :",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              rent,
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Text(
                              "Maintenance :",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              maintanance,
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Text(
                              "Rent Cycle",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Electricity:-", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(height: 18),
                        const Divider(),
                        Row(
                          children: [
                            Text(
                              "Electricity Type :",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              electricy,
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
    );
  }
}
