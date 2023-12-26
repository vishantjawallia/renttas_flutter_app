// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, prefer_const_constructors, use_build_context_synchronously, unused_element

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:renttas_flutter_app/Common/RentalCustomAlert.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Common/ApiUrl.dart';
import '../landlord/LandloardDashBord.dart';

class AddTendent extends StatefulWidget {
  const AddTendent({super.key});

  @override
  State<AddTendent> createState() => _AddTendentState();
}

class _AddTendentState extends State<AddTendent> {
  String? selectedOption;
  static String selectedPropertyId = '';
  static String selectedSubProptyId = '';
  bool isLoading = false;

  // List<String> options = [
  //   'VISA',
  //   'MASTER',
  //   'PAYPAL',
  // ];
  final TextEditingController _tenantName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _advanceAmount = TextEditingController();
  String phoneNumber = '';
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedPropertyId = prefs.getString('selectedPropertyId') ?? '';
      selectedSubProptyId = prefs.getString('selectedSubProptyId') ?? '';
    });
    print("selectedPropertyId->" + selectedPropertyId);
    print("selectedSubProptyId->" + selectedSubProptyId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void _onPhoneNumberChanged(String phone) {
    setState(() {
      phoneNumber = phone;
    });
    print(phone);
  }

  Future<void> _selectDatee(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff54854C),
        title: Text(
          "add_tenant".tr(),
          // 'Add Tenant',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              // Container(
              //   height: 50,
              //   margin: EdgeInsets.only(top: 30, left: 10, right: 10),
              //   child: Text(
              //     'Add Tenant',
              //     style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
              //   ),
              // ),
              SizedBox(height: 10),

              Container(
                margin: EdgeInsets.only(top: 10, left: 8),
                child: TextFormField(
                  controller: _tenantName,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    //  hintText: 'Make Payment?',
                    labelText: 'tenant_name'.tr(),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: IntlPhoneField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.phone_android),
                          hintText: 'enter_your_mobile'.tr(),
                          labelText: '${"mobile_number".tr()} *',
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          _onPhoneNumberChanged(phone.completeNumber);
                          print(phone.completeNumber);
                          print(phone.countryCode);
                          print(phone.countryISOCode);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 8),
                child: TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    //  hintText: 'Make Payment?',
                    labelText: 'email_id_optional'.tr(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 8),
                child: TextFormField(
                  controller: _advanceAmount,
                  decoration: InputDecoration(
                    icon: Icon(Icons.currency_rupee),
                    //  hintText: 'Make Payment?',
                    labelText: 'advance_amount'.tr(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${"start_date".tr()}:',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextField(
                      controller: _startDateController,
                      decoration: InputDecoration(
                        labelText: 'start_date'.tr(),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate(context, _startDateController);
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      '${"end_date".tr()}:',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextField(
                      controller: _endDateController,
                      decoration: InputDecoration(
                        labelText: 'end_date'.tr(),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate(context, _endDateController);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: 350,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 8,
                  ),
                  onPressed: isLoading ? null : () => saveTenant(_tenantName.text, phoneNumber, _email.text, _advanceAmount.text, _startDateController.text, _endDateController.text),
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Color(0xff54854C),
                        )
                      : Text(
                          "save".tr(),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveTenant(
    String name,
    String phoneNumber,
    String email,
    String advanceAmount,
    String startdate,
    String enddate,
  ) async {
    // Replace with your server URL

    final Map<String, dynamic> data = {
      "propertyId": selectedPropertyId,
      "subPropertyId": selectedSubProptyId,
      "tenantName": name,
      "phone": phoneNumber,
      "email": email,
      "advanceAmount": advanceAmount,
      "startdate": startdate,
      "enddate": enddate
    };

    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(Uri.parse(ApiUrl.saveTenant), headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        RentalCustomAlert.showSuccessAlert(context, "Added", "Tendent Added Successfully");
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LandloardDashBord()));
      } else {
        RentalCustomAlert.showErrorAlert(context);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LandloardDashBord()));
      }
    } catch (error) {
      print('Error sending data: $error');
    }
  }

  void faliedDilog(String respMsg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Register  Failed'),
          content: Text(respMsg),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void successDilog(String respMsg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Register  Failed'),
          content: Text(respMsg),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LandloardDashBord()));
              },
            ),
          ],
        );
      },
    );
  }
}
