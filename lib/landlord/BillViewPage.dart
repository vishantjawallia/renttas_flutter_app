// ignore_for_file: prefer_const_literals_to_create_immutables,  prefer_interpolation_to_compose_strings, use_build_context_synchronously, unused_element, avoid_print, prefer_final_fields, unnecessary_import, must_be_immutable, non_constant_identifier_names

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
        backgroundColor: const Color(0xff54854C),
        title: const Text(
          "Bill & Payment details",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
          child: Column(
            children: [
              const Divider(
                color: Colors.black,
                thickness: 2,
              ),
              SizedBox(width: 0.0, height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rent bill no",
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Rent bill date",
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              const SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    Text(
                      widget.Data.rentStartDate,
                      style: const TextStyle(color: Colors.black54, fontSize: 16),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  children: [
                    Divider(color: Colors.grey.shade300, thickness: 1),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tenant",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "Name",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        )
                      ],
                    ),
                    Divider(color: Colors.grey.shade300, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Rent ",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "₹ " + widget.Data.rentAmount,
                          style: const TextStyle(color: Colors.black54, fontSize: 16),
                        )
                      ],
                    ),
                    Divider(color: Colors.grey.shade300, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Rent Period",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          widget.Data.rentStartDate,
                          style: const TextStyle(color: Colors.black54, fontSize: 16),
                        )
                      ],
                    ),
                    Divider(color: Colors.grey.shade300, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Rent Due date",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          widget.Data.rentEndDate,
                          style: const TextStyle(color: Colors.black54, fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey.shade300, thickness: 1),
              Container(
                padding: const EdgeInsets.only(top: 10),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Rent & Maintanances :-",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  children: [
                    Divider(color: Colors.grey.shade300, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Rent",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "₹ " + widget.Data.rentAmount,
                          style: const TextStyle(color: Colors.black54, fontSize: 16),
                        )
                      ],
                    ),
                    Divider(color: Colors.grey.shade300, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Maintanace",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "₹ " + widget.Data.maintenanceAmount,
                          style: const TextStyle(color: Colors.black54, fontSize: 16),
                        )
                      ],
                    ),
                    Divider(color: Colors.grey.shade300, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Previous balance",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "₹ " + widget.Data.previousBalance,
                          style: const TextStyle(color: Colors.black54, fontSize: 16),
                        )
                      ],
                    ),
                    Divider(color: Colors.grey.shade300, thickness: 1),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Adjustment",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "₹ 0",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        )
                      ],
                    ),
                    Divider(color: Colors.grey.shade300, thickness: 1),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Adjustment remark",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "₹ 0",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        )
                      ],
                    ),
                    Divider(color: Colors.grey.shade300, thickness: 1),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Electricity :-",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  children: [
                    Divider(color: Colors.grey.shade300, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Electricity type",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          widget.Data.electricityType,
                          style: const TextStyle(color: Colors.black54, fontSize: 16),
                        )
                      ],
                    ),
                    Divider(color: Colors.grey.shade300, thickness: 1),
                    const SizedBox(height: 20),
                  ],
                ),
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
                          style: const TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
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
                        child: const Center(
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
              title: const Text("Confirmation"),
              content: Text(contentText),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LandloardDashBord()));
                      }
                      if (widget.type == "0") {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Tenantdashbord()));
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
      const DataColumn(
        label: Text(
          'Paid Date',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(label: _verticalDivider),

      const DataColumn(
        label: Text(
          'Paid by Name',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(label: _verticalDivider),
      const DataColumn(
        label: Text(
          'Rent paid',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(label: _verticalDivider),
      const DataColumn(
        label: Text(
          'Balance',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(label: _verticalDivider),
      const DataColumn(label: SizedBox()),
      // Add more columns as needed
    ];
  }

  List<DataRow> _buildRows() {
    return [
      DataRow(
        cells: [
          const DataCell(Text('04- dec-2023')),
          DataCell(_verticalDivider),
          const DataCell(Text('John')),
          DataCell(_verticalDivider),
          const DataCell(Text('500')),
          DataCell(_verticalDivider),
          const DataCell(Text('-300')),
          DataCell(_verticalDivider),
          const DataCell(Icon(Icons.navigate_next_outlined)),
        ],
      ),
      DataRow(
        cells: [
          const DataCell(Text('24-10-23')),
          DataCell(_verticalDivider),
          const DataCell(Text('Jane')),
          DataCell(_verticalDivider),
          const DataCell(Text('300')),
          DataCell(_verticalDivider),
          const DataCell(Text('2500')),
          DataCell(_verticalDivider),
          const DataCell(Icon(Icons.navigate_next_outlined)),
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
