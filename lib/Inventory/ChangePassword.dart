// ignore_for_file: sort_child_properties_last, camel_case_types, unused_import, curly_braces_in_flow_control_structures

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';

import 'MyBuisness.dart';
import 'Setting.dart';

class chnagepassword extends StatefulWidget {
  const chnagepassword({super.key});

  @override
  State<chnagepassword> createState() => _mybusinesspageState();
}

String selectedcurrency = "Select Currency";

class _mybusinesspageState extends State<chnagepassword> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: const Color(0xff54854C),
        automaticallyImplyLeading: false,
        title: const Text('Change Password'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const mybusinesspage())),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(60)),
                          child: const Icon(
                            Icons.change_circle,
                            size: 50,
                          )),
                      const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          "Change Password",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(2.0),
                      //   child: Text(
                      //     "Email: ab@gmail.com  ",
                      //     style: TextStyle(color: Colors.blue, fontSize: 13),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Password ",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: Colors.black,
                    //     blurRadius: 6,
                    //     offset: Offset(0, 2),
                    //   ),
                    // ],
                  ),
                  height: 60,
                  child: TextField(
                    //  controller: landlordPassword,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscured,
                    focusNode: textFieldFocusNode,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
                      hintText: "Enter Password",
                      hintStyle: const TextStyle(color: Colors.black38),
                      filled: true, // Needed for adding a fill color
                      fillColor: Colors.white,
                      isDense: true, // Reduces height a bit
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none, // No border
                        borderRadius: BorderRadius.circular(12), // Apply corner radius
                      ),
                      // prefixIcon: Icon(
                      //   Icons.lock_rounded,
                      //   size: 24,
                      //   color: Color(0xff5ac18e),
                      // ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: GestureDetector(
                          onTap: _toggleObscured,
                          child: Icon(
                            _obscured ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 18,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: Colors.black,
                    //     blurRadius: 6,
                    //     offset: Offset(0, 2),
                    //   ),
                    // ],
                  ),
                  height: 60,
                  child: TextField(
                    //  controller: landlordPassword,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscured,
                    focusNode: textFieldFocusNode,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
                      hintText: "Enter confirm Password",
                      hintStyle: const TextStyle(color: Colors.black38),
                      filled: true, // Needed for adding a fill color
                      fillColor: Colors.white,
                      isDense: true, // Reduces height a bit
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none, // No border
                        borderRadius: BorderRadius.circular(12), // Apply corner radius
                      ),
                      // prefixIcon: Icon(
                      //   Icons.lock_rounded,
                      //   size: 24,
                      //   color: Color(0xff5ac18e),
                      // ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: GestureDetector(
                          onTap: _toggleObscured,
                          child: Icon(
                            _obscured ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff54854C),
                ),
                height: 50,
                width: 400,
                child: Center(
                  child: TextButton(
                    child: const Text(
                      'Change Password',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Color(0xff54854C)),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
