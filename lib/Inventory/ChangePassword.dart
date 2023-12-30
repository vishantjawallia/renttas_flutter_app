// ignore_for_file: sort_child_properties_last, camel_case_types, unused_import, curly_braces_in_flow_control_structures

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';

import 'MyBuisness.dart';
import 'Setting.dart';

class ChnagePassword extends StatefulWidget {
  const ChnagePassword({super.key});

  @override
  State<ChnagePassword> createState() => _ChnagePasswordState();
}

String selectedcurrency = "Select Currency";

class _ChnagePasswordState extends State<ChnagePassword> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return;
      textFieldFocusNode.canRequestFocus = false;
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
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MyBusinessPage())),
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                "Password ",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscured,
                    focusNode: textFieldFocusNode,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: "Enter Password",
                      hintStyle: const TextStyle(color: Colors.black38),
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
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
              const SizedBox(height: 18),
              Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscured,
                    focusNode: textFieldFocusNode,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: "Enter confirm Password",
                      hintStyle: const TextStyle(color: Colors.black38),
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
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
                  color: const Color(0xff54854C),
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
