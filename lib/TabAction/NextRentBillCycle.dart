// ignore_for_file:  avoid_unnecessary_containers, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings, sort_child_properties_last, use_build_context_synchronously, avoid_print, must_be_immutable, prefer_const_constructors

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
        backgroundColor: const Color(0xff54854C),
        leading: const BackButton(),
        title: const Text('Bill Detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 22),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16, left: 5),
                      padding: const EdgeInsets.only(left: 15),
                      height: 20,
                      width: double.infinity,
                      child: const Text(
                        'Next rent bill cycle:-',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Rent Cycle',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            widget.rentCycle,
                            style: const TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Rent Start Date ',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            widget.rentStartData,
                            style: const TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Rent End Date',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            widget.rentEndDate,
                            style: const TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Collect Rent By',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            widget.collectdBy,
                            style: const TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 5, bottom: 10),
                      padding: const EdgeInsets.only(left: 15),
                      height: 20,
                      width: double.infinity,
                      child: const Text(
                        'Monthly Fixed Charges:-',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Previous Balance',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.perviousBalance.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Rent',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            widget.rentAmount.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Maintenance',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            widget.maintenanceAmount.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total', style: TextStyle(fontSize: 16)),
                          Text(
                            widget.totalAmount.toString(),
                            style: const TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 5),
                      padding: const EdgeInsets.only(left: 15),
                      height: 20,
                      width: double.infinity,
                      child: const Text(
                        'Bills:-',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Electric Bill',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.electricityType,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 4, right: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Electric Charges',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            widget.electricCharge.toString(),
                            style: const TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Water Bills',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.waterBillType,
                            style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 4, right: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Water Charges',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            widget.waterBillCharge.toString(),
                            style: const TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: const Text(
                              'Gas Bill',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            widget.gasBillType.toString(),
                            style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 4, right: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Gas Charge',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            widget.gasBillCharge.toString(),
                            style: const TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:- ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.totalAmount.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    height: 55,
                    width: double.infinity,
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: const Color(0xff54854C),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              setState(() => isLoading = true);
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
                            child: const Text(
                              'Save',
                              style: TextStyle(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff54854C),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LandloardDashBord()));
      } else {
        snack("Something went wrong, please try again", context);
        print("Failed to send data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }
}
