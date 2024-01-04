// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously, unused_element, avoid_print, prefer_final_fields, unnecessary_import, must_be_immutable, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:renttas_flutter_app/model/BillModel.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import '../Common/ApiUrl.dart';
import '../Const/Const.dart';
import '../tandent/Tenantdashbord.dart';
import 'LandloardDashBord.dart';

class BillViewPage extends StatefulWidget {
  BIllModel Data;
  String type;
  BillViewPage({super.key, required this.Data, required this.type});

  @override
  State<BillViewPage> createState() => _BillViewPageState();
}

bool isloading = false;

class _BillViewPageState extends State<BillViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill & Payment details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rent billno",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Rent billdate",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    widget.Data.rentStartDate,
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Tenant",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "Name",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Total Rent ",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "₹ " + widget.Data.rentAmount,
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Rent Period",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    widget.Data.rentStartDate,
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Rent Due date",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    widget.Data.rentEndDate,
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Center(
                child: Text(
                  "Rent & Maintanance",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Rent",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "₹ " + widget.Data.rentAmount,
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Maintanace",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "₹ " + widget.Data.maintenanceAmount,
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Previous balance",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "₹ " + widget.Data.previousBalance,
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Adjustment",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "₹ 0",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Adjustment remark",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "₹ 0",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Center(
                child: Text(
                  "Electricity",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Electricity type",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    widget.Data.electricityType,
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      showAlertDialogdelete(context, widget.Data.id);
                    },
                    child: Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.white,
                        ),
                        child: Center(
                            child: Text(
                          isloading == false ? "Delete" : "Please wait",
                          style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
                        ))),
                  ),
                  InkWell(
                    onTap: () {
                      Share.share('Check');
                    },
                    child: Container(
                        height: 30,
                        width: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.white,
                        ),
                        child: Center(
                            child: Text(
                          "Share",
                          style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
                        ))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialogdelete(BuildContext context, String billid) {
    showDialog(
      context: context,
      builder: (context) {
        String contentText = "Are you sure want to delete ?";
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Confirmation"),
              content: Text(contentText),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    setState(() {
                      isloading = true;
                    });

                    final Map<String, dynamic> requestBody = {
                      "billid": billid,
                    };

                    final response = await http.post(
                      Uri.parse(ApiUrl.deletebill),
                      body: jsonEncode(requestBody),
                      headers: {
                        'Content-Type': 'application/json', // Set the content type header
                      },
                    );
                    print("expesss--" + response.body);
                    setState(() {
                      isloading = false; // Set loading state to false after the data is loaded
                    });
                    if (response.statusCode == 200) {
                      if (widget.type == "1") {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandloardDashBord()));
                      }
                      if (widget.type == "0") {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Tenantdashbord()));
                      }
                    } else {
                      snack("Something went wrong", context);
                    }
                  },
                  child: Text(isloading == false ? "Continue" : "Please wait"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  List<DataColumn> _buildColumns() {
    return [
      DataColumn(
        label: Text(
          'Paid Date',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(label: _verticalDivider),

      DataColumn(
        label: Text(
          'Paid by Name',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(label: _verticalDivider),
      DataColumn(
        label: Text(
          'Rent paid',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(label: _verticalDivider),
      DataColumn(
        label: Text(
          'Balance',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(label: _verticalDivider),
      DataColumn(label: SizedBox()),
      // Add more columns as needed
    ];
  }

  List<DataRow> _buildRows() {
    return [
      DataRow(
        cells: [
          DataCell(Text('04- dec-2023')),
          DataCell(_verticalDivider),
          DataCell(Text('John')),
          DataCell(_verticalDivider),
          DataCell(Text('500')),
          DataCell(_verticalDivider),
          DataCell(Text('-300')),
          DataCell(_verticalDivider),
          DataCell(Icon(Icons.navigate_next_outlined)),
        ],
      ),
      DataRow(
        cells: [
          DataCell(Text('24-10-23')),
          DataCell(_verticalDivider),
          DataCell(Text('Jane')),
          DataCell(_verticalDivider),
          DataCell(Text('300')),
          DataCell(_verticalDivider),
          DataCell(Text('2500')),
          DataCell(_verticalDivider),
          DataCell(Icon(Icons.navigate_next_outlined)),
          // Add more cells as needed
        ],
      ),
    ];
  }

  Widget _verticalDivider = const VerticalDivider(
    width: 1,
    color: Colors.black,
    thickness: 1,
  );
}
