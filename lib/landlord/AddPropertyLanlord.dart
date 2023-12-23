// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, duplicate_ignore, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:renttas_flutter_app/Common/RentalCustomAlert.dart';
import 'package:renttas_flutter_app/Const/Const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/custom_ modal_progress_hud.dart';
import '../widgets/custom_text_field.dart';
import 'LandloardDashBord.dart';

class AddPropertyLanlord extends StatefulWidget {
  final String type, userid;
  const AddPropertyLanlord({
    super.key,
    required this.type,
    required this.userid,
  });

  @override
  State<AddPropertyLanlord> createState() => _AddPropertyLanlordState();
}

class _AddPropertyLanlordState extends State<AddPropertyLanlord> {
  final TextEditingController landlordIdController = TextEditingController();
  final TextEditingController propertyNameController = TextEditingController();
  final TextEditingController subpropertyNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String landlordId = '';
  bool isloading = false;

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // ignore: prefer_interpolation_to_compose_strings
    if (kDebugMode) {
      print("ppppp------" + prefs.getString('userId').toString());
    }
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
    setState(() => isloading = true);

    const String apiUrl = ApiUrl.createProperties; // Replace with your API endpoint

    final Map<String, dynamic> requestData = {
      "landlordId": landlordId,
      "propertyName": propertyNameController.text,
      "location": locationController.text,
    };
    print("resp in  --------" + requestData.toString());
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(requestData),
    );

    print("resp in add proper --------" + response.body);
    if (response.statusCode == 200) {
      setState(() => isloading = false);

      snack("Succefully added", context);

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LandloardDashBord()));
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        leading: widget.type != "0" ? const BackButton() : const SizedBox(),
        title: Text(
          widget.type == "0" ? 'Add your first property' : 'Add Property',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
                  child: Text(
                    'Add new property :-',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // const SizedBox(height: 50),
                CustomTextField(
                  controller: propertyNameController,
                  iconData: Icons.margin,
                  hintText: 'Property Name',
                ),
                CustomTextField(
                  controller: subpropertyNameController,
                  iconData: Icons.subject_rounded,
                  hintText: 'Sub Property Name',
                ),
                CustomTextField(
                  controller: locationController,
                  iconData: Icons.place,
                  hintText: 'Location',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: SizedBox(
                    width: 250,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff54854C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        addProperty();
                      },
                      child: const Text(
                        'Sumbit',
                        // widget.type == "0" ? 'Sumbit' : 'Add Property',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                // TextField(
                //   controller: propertyNameController,
                //   decoration: const InputDecoration(labelText: 'Property Name'),
                // ),
                // const SizedBox(height: 10),
                // TextField(
                //   controller: locationController,
                //   decoration: const InputDecoration(labelText: 'Location'),
                // ),
                // const SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () {
                //     addProperty();
                //   },
                //   child: isloading == false ? Text(widget.type == "0" ? 'Add your first property' : 'Add Property') : const CircularProgressIndicator(color: Color(0xff54854C),),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
