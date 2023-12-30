// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables, void_checks, prefer_const_constructors_in_immutables

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:renttas_flutter_app/widgets/custom_text_field.dart';
import 'package:renttas_flutter_app/widgets/global_widget.dart';

import 'LandloardDashBord.dart';

class AddSubproperties extends StatefulWidget {
  final selectedId;
  AddSubproperties({super.key, required this.selectedId});

  @override
  State<AddSubproperties> createState() => _AddSubpropertiesState();
}

class _AddSubpropertiesState extends State<AddSubproperties> {
  TextEditingController subPropertyController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        title: Text(
          "add_room".tr(),
          // 'Add Room',
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "add_room".tr() + ":-",
                // 'Add Room:-',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Column(
              children: [
                CustomTextField(
                  hintText: '${"add_room".tr()} *',
                  iconData: Icons.meeting_room_outlined,
                  controller: subPropertyController,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff54854C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () {
                              if (subPropertyController.text.isEmpty) return GlobalWidgets.toast('Please enter your room name !');
                              addSubProperty(widget.selectedId, subPropertyController.text);
                            },
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Color(0xff54854C),
                            )
                          : Text(
                              "sumbit".tr(),
                              // 'Sumbit',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
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
