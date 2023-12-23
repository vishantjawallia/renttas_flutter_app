// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables, void_checks

import 'dart:developer';

import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:renttas_flutter_app/widgets/custom_text_field.dart';
import 'package:renttas_flutter_app/widgets/global_widget.dart';

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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        title: const Text('Add Room'),
        // backgroundColor: Colors.white,
        // elevation: 0,
        // leading: IconButton(
        //   onPressed: () => Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const LandloardDashBord()),
        //   ),
        //   icon: const Icon(
        //     Icons.arrow_back,
        //     color: Colors.black,
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Add Room:-',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Column(
              children: [
                CustomTextField(
                  hintText: 'Add Room *',
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
                          : const Text(
                              'Sumbit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                // SizedBox(
                //   width: double.infinity,
                //   height: screenHeight * 0.06,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: const Color.fromARGB(255, 76, 16, 181),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(9.0),
                //       ),
                //     ),
                //     onPressed: isLoading
                //         ? null
                //         : () {
                //             final isValid = _formKey.currentState!.validate();
                //             if (!isValid) {
                //               return;
                //             }
                //             _formKey.currentState!.save();

                //             addSubProperty(widget.selectedId, subPropertyController.text);
                //           },
                //     child: isLoading
                //         ? const CircularProgressIndicator(
                //             color: Color(0xff54854C),
                //           )
                //         : const Text(
                //             'ADD PROPERTY',
                //             style: TextStyle(
                //               fontSize: 18,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //   ),
                // ),
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
