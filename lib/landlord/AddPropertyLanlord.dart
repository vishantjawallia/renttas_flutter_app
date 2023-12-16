import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:renttas_flutter_app/Common/RentalCustomAlert.dart';
import 'package:renttas_flutter_app/Const/Const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LandloardDashBord.dart';

class AddPropertyLanlord extends StatefulWidget {
  final String type, userid;
  const AddPropertyLanlord({Key? key, required this.type, required this.userid}) : super(key: key);

  @override
  State<AddPropertyLanlord> createState() => _AddPropertyLanlordState();
}

class _AddPropertyLanlordState extends State<AddPropertyLanlord> {
  final TextEditingController landlordIdController = TextEditingController();
  final TextEditingController propertyNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String landlordId = '';
  bool isloading = false;

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("ppppp------" + prefs.getString('userId').toString());
    if (widget.type == "1") {
      setState(() {});
    }

    setState(() {
      if (widget.type == "1") {
        landlordId = prefs.getString('userId') ?? '';
      }
      if (widget.type == "0") {
        landlordId = widget.userid;
      }

      //   landlordId =widget.userid=="0"?widget.userid: prefs.getString('userId') ?? '';
    });
  }

  Future<void> addProperty() async {
    setState(() {
      isloading = true;
    });

    const String apiUrl = ApiUrl.createProperties; // Replace with your API endpoint

    final Map<String, dynamic> requestData = {
      "landlordId": landlordId,
      "propertyName": propertyNameController.text,
      "location": locationController.text,
    };
    print("resp in  --------" + requestData.toString());
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );
    print("resp in add proper --------" + response.body);
    if (response.statusCode == 200) {
      setState(() {
        isloading = false;
      });

      snack("Succefully added", context);

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LandloardDashBord()));

      // RentalCustomAlert.showSuccessAlert(context, "Success", "Property Added Successfull");
    } else {
      RentalCustomAlert.showErrorAlert(context);
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          title: Text(widget.type == "0" ? 'Add your first property' : 'Add Property'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
              TextField(
                controller: propertyNameController,
                decoration: InputDecoration(labelText: 'Property Name'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    addProperty();
                  },
                  child: isloading == false ? Text(widget.type == "0" ? 'Add your first property' : 'Add Property') : CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
