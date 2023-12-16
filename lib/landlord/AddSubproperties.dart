import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/Common/ApiUrl.dart';

import 'LandloardDashBord.dart';

class AddSubproperties extends StatefulWidget {
  final selectedId;
  AddSubproperties({required this.selectedId});

  @override
  State<AddSubproperties> createState() => _AddSubpropertiesState();
}

class _AddSubpropertiesState extends State<AddSubproperties> {
  TextEditingController subPropertyController = TextEditingController();
  bool isLoading = false;
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.001, top: screenHeight * 0.1),
                    child: Text(
                      'Add \n Property',
                      style: GoogleFonts.kanit(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  SizedBox(
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.26,
                    child: Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.05),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: subPropertyController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.home),
                              hintText: 'Enter your Address details',
                              labelText: 'Property *',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your property name!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: screenHeight * 0.060,
                          ),
                          SizedBox(
                            width: screenWidth * 0.8,
                            height: screenHeight * 0.06,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      final isValid = _formKey.currentState!.validate();
                                      if (!isValid) {
                                        return;
                                      }
                                      _formKey.currentState!.save();

                                      addSubProperty(widget.selectedId, subPropertyController.text);
                                    },
                              child: isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Add Proprety',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addSubProperty(String propertyId, String subProperty) async {
    log("sssss====" + propertyId + " suvvvvv==" + subProperty);

    setState(() {
      isLoading = true;
    });
    final Map<String, dynamic> requestData = {"propertyId": propertyId, "subPropertyName": subProperty};
    // Replace with your actual API URL

    final response = await http.post(
      Uri.parse(ApiUrl.createSubProperties),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );
    log("sssss====" + response.body);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      successDilog("SubProperty Added Successfully");
    } else {
      faliedDilog("Something Went Wring");
    }
  }

  void faliedDilog(String respMsg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Failed'),
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
          title: const Text('Success'),
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
