import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:renttas_flutter_app/Common/RentalCustomAlert.dart';
import 'package:renttas_flutter_app/model/TendentModel.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Common/ApiUrl.dart';
import '../landlord/LandloardDashBord.dart';

class EditMergeProperty extends StatefulWidget {
  final TendentModel data;
  const EditMergeProperty({Key? key, required this.data}) : super(key: key);

  @override
  State<EditMergeProperty> createState() => _AddTendentState();
}

class _AddTendentState extends State<EditMergeProperty> {
  String? selectedOption;
  static String selectedPropertyId = '';
  static String selectedSubProptyId = '';
  bool isLoading = false;

  // List<String> options = [
  //   'VISA',
  //   'MASTER',
  //   'PAYPAL',
  // ];
  TextEditingController _tenantName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _advanceAmount = TextEditingController();
  String phoneNumber = '';

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
    _tenantName.text = widget.data.tenantName;
    _email.text = widget.data.email;
    _advanceAmount.text = widget.data.advanceAmount;
    phoneNumber = widget.data.phone;
  }

  void _onPhoneNumberChanged(String phone) {
    setState(() {
      phoneNumber = phone;
    });
    print(phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Text(
                'Edit Tenant',
                style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 8),
              child: TextFormField(
                controller: _tenantName,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  //  hintText: 'Make Payment?',
                  labelText: 'Tenant Name',
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
                      decoration: const InputDecoration(
                        icon: Icon(Icons.phone_android),
                        hintText: 'Enter your mobile number',
                        labelText: 'Mobile Number *',
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
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  //  hintText: 'Make Payment?',
                  labelText: 'Email Id (Optional)',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 8),
              child: TextFormField(
                controller: _advanceAmount,
                decoration: const InputDecoration(
                  icon: Icon(Icons.currency_rupee),
                  //  hintText: 'Make Payment?',
                  labelText: 'AdvanceAmount',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Start Date:',
                  //   style: TextStyle(fontSize: 16),
                  // ),
                  // TextField(
                  //   controller: _startDateController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Start Date',
                  //   ),
                  //   readOnly: true,
                  //   onTap: () {
                  //     _selectDate(context, _startDateController);
                  //   },
                  // ),
                  // SizedBox(height: 16),
                  // Text(
                  //   'End Date:',
                  //   style: TextStyle(fontSize: 16),
                  // ),
                  // TextField(
                  //   controller: _endDateController,
                  //   decoration: InputDecoration(
                  //     labelText: 'End Date',
                  //   ),
                  //   readOnly: true,
                  //   onTap: () {
                  //     _selectDate(context, _endDateController);
                  //   },
                  // ),
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
                onPressed: isLoading ? null : () => saveTenant(widget.data.id, _tenantName.text, phoneNumber, _email.text, _advanceAmount.text),
                child: isLoading
                    ? CircularProgressIndicator(
                        color: Color(0xff54854C),
                      )
                    : Text("Edit"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveTenant(String tenantid, String name, String phoneNumber, String email, String advanceAmount) async {
    // Replace with your server URL

    final Map<String, dynamic> data = {
      "tenantid": tenantid,
      // "propertyId": selectedPropertyId,
      // "subPropertyId": selectedSubProptyId,
      "tenantName": name,
      "phone": phoneNumber,
      "email": email,
      "advanceAmount": advanceAmount
    };

    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(Uri.parse(ApiUrl.updatetenant), headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        RentalCustomAlert.showSuccessAlert(context, "Updated", "Tendent Updated Successfully");
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
