// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings, sort_child_properties_last, use_build_context_synchronously, avoid_print, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:renttas_flutter_app/Const/Const.dart';
import 'package:renttas_flutter_app/TabAction/BillTabAction.dart';

import '../landlord/LandloardDashBord.dart';

class NextRentBillCycle extends StatefulWidget {
  final String landlordId;
  final String rentCycle;
  final String rentStartData;
  final String rentEndDate;
  final String collectdBy;
  final double perviousBalance;
  final double rentAmount;
  final double maintenanceAmount;
  final double totalAmount;
  final String electricityType;
  final String waterBillType;
  final String gasBillType;
  final String propertyId;
  final String subpropertyId;
  final double electricCharge;
  final double waterBillCharge;
  final double gasBillCharge;
  List<ViewBloodHospitalModel> selectedItems;

  NextRentBillCycle({
    required this.landlordId,
    required this.rentCycle,
    required this.rentStartData,
    required this.collectdBy,
    required this.rentEndDate,
    required this.perviousBalance,
    required this.rentAmount,
    required this.maintenanceAmount,
    required this.totalAmount,
    required this.electricityType,
    required this.waterBillType,
    required this.gasBillType,
    required this.propertyId,
    required this.subpropertyId,
    required this.electricCharge,
    required this.waterBillCharge,
    required this.gasBillCharge,
    required this.selectedItems,
  });

  @override
  State<NextRentBillCycle> createState() => _NextRentBillCycleState();
}

class _NextRentBillCycleState extends State<NextRentBillCycle> {
  bool isLoading = false;
  String rentStartDate = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.green,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: Text('RENTTAS', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 5),
                        padding: EdgeInsets.only(left: 15),
                        height: 20,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Text(
                          'Next Rent Bill Cycle',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 50, left: 10),
                              child: Text(
                                'Rent Cycle',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 50),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.rentCycle,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 50, left: 10),
                              child: Text(
                                'Rent Start Date ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.rentStartData,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 50, left: 10),
                              child: Text(
                                'Rent End Date',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.rentEndDate,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 50, left: 10),
                              child: Text(
                                'Collect Rent By',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.collectdBy,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ), //Monthly Fixed Charge
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 5),
                        padding: EdgeInsets.only(left: 15),
                        height: 20,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Text(
                          'Monthly Fixed  Charges ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 50, left: 10),
                              child: Text(
                                'Previous Balance ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.perviousBalance.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 50, left: 10),
                              child: Text(
                                'Rent',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 110),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.rentAmount.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 50, left: 10),
                              child: Text(
                                'Maintenance',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 45),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.maintenanceAmount.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 50, left: 10),
                              child: Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 95),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.totalAmount.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 5),
                        padding: EdgeInsets.only(left: 15),
                        height: 20,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Text(
                          'BillS',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 50, left: 10),
                              child: Text(
                                'Electric Bill',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.electricityType,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 50, left: 10),
                              child: Text(
                                'Electric Charges',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.electricCharge.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 50, left: 10),
                              child: Text(
                                'Water Bills',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.waterBillType,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 50, left: 10),
                              child: Text(
                                'Water Charges',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.waterBillCharge.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 50, left: 10),
                              child: Text(
                                'Gas Bill',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 30),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.gasBillType.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 50, left: 10),
                              child: Text(
                                'Gas Charge',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.gasBillCharge.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isLoading)
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 70,
                  width: 170,
                  padding: EdgeInsets.all(10),
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text("Total:-" + widget.totalAmount.toString()),
                    style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Container(
                  height: 70,
                  width: 180,
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      sendRentData(
                          widget.landlordId,
                          widget.propertyId,
                          widget.subpropertyId,
                          widget.rentCycle,
                          widget.rentStartData,
                          widget.rentEndDate,
                          widget.collectdBy,
                          widget.perviousBalance,
                          widget.rentAmount,
                          widget.maintenanceAmount,
                          widget.totalAmount,
                          widget.electricityType,
                          widget.electricCharge,
                          widget.waterBillType,
                          widget.waterBillCharge,
                          widget.gasBillType,
                          widget.gasBillCharge,
                          widget.selectedItems);
                    },
                    child: isLoading == true
                        ? CircularProgressIndicator(
                            color: Color(0xff54854C),
                          )
                        : Text('Save'),
                    style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  ),
                )
              ],
            ),
          if (isLoading)
            CircularProgressIndicator(
              color: Color(0xff54854C),
            ),
        ],
      ),
    );
  }

  Future<void> sendRentData(
      String landlordId,
      String propertyId,
      String subproperty,
      String rentCycle,
      String rentStartData,
      String rentEndDate,
      String collectdBy,
      double perviousBalance,
      double rentAmount,
      double maintenanceAmount,
      double totalAmount,
      String electricityType,
      double electridCharge,
      String waterBillType,
      double waterBillCharge,
      String gasBillType,
      double gasBillCharge,
      List<ViewBloodHospitalModel> selectedItems) async {
    String jsondata = jsonEncode(selectedItems);
    final Map<String, dynamic> requestData = {
      "landlordId": landlordId,
      "propertyId": propertyId,
      "subpropertyId": subproperty,
      "rentCycle": rentCycle,
      "rentStartData": rentStartData,
      "rentEndDate": rentEndDate,
      "collectRentDate": collectdBy, //collectdBy
      "previousBalance": perviousBalance,
      "rentAmount": rentAmount,
      "maintenanceAmount": maintenanceAmount,
      "totalAmount": totalAmount,

      "electricityType": electricityType,

      "electricCharge": electridCharge,
      "waterBillType": waterBillType,
      "waterBillCharge": waterBillCharge,
      "gasBillType": gasBillType,
      "gasBillCharge": gasBillCharge,
      "extraCharge": jsondata,
    };

    try {
      final response = await http.post(Uri.parse(ApiUrl.saveBill), headers: {"Content-Type": "application/json"}, body: jsonEncode(requestData));

      setState(() {
        isLoading = false;
      });

      print("Cycle----" + response.body);
      if (response.statusCode == 200) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandloardDashBord()));
      } else {
        snack("Something went wrong, please try again", context);
        print("Failed to send data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }
}
