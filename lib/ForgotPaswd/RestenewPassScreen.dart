// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, use_super_parameters, must_be_immutable, use_build_context_synchronously, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/Wellcome/LoginPage.dart';

import '../Common/ApiUrl.dart';
import '../Const/Const.dart';

class ResetNewpassScreen extends StatefulWidget {
  String emil;
  static const String id = 'reset_password@gmail.com';
  ResetNewpassScreen({Key? key, required this.emil}) : super(key: key);

  @override
  State<ResetNewpassScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetNewpassScreen> {
  final _key = GlobalKey<FormState>();
  bool isLoading = false;
  final _emailController = TextEditingController();
  final String email = "abced@gmail.com";
  final TextEditingController controller = TextEditingController();
  final TextEditingController confirmcontroller = TextEditingController();
  bool success = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false; // Prevents focus if tap on eye
    });
  }

  final textFieldFocusNodeconfirm = FocusNode();
  bool _obscuredconfirm = true;

  void _toggleObscuredconfirm() {
    setState(() {
      _obscuredconfirm = !_obscuredconfirm;
      if (textFieldFocusNodeconfirm.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNodeconfirm.canRequestFocus = false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                width: size.width,
                //height: size.height,
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
                    child: Form(
                        key: _key,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.arrow_back),
                          ),
                          const SizedBox(height: 70),
                          const Text(
                            "Create a new password",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'The password shoud be diffrent from the previous password',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                              // height: 350,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2.0),
                              child: TextField(
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: _obscuredconfirm,
                                  controller: controller,
                                  decoration: InputDecoration(
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: GestureDetector(
                                          onTap: _toggleObscuredconfirm,
                                          child: Icon(
                                            _obscuredconfirm ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color.fromARGB(255, 207, 207, 207), width: 2), borderRadius: BorderRadius.circular(5)),
                                      // floatingLabelStyle: GoogleFonts.mPlus1(
                                      //   color: Colors.black,
                                      //   fontSize: 18,
                                      // ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: success ? Colors.green : Colors.red, width: 2),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      hintText: "New Password",
                                      labelText: "New Password",
                                      // hintStyle:
                                      // GoogleFonts.mPlus1(color: Colors.black),
                                      border: const OutlineInputBorder(borderSide: BorderSide()))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2.0),
                              child: TextField(
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: _obscured,
                                  controller: confirmcontroller,
                                  decoration: InputDecoration(
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
                                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color.fromARGB(255, 207, 207, 207), width: 2), borderRadius: BorderRadius.circular(5)),
                                      // floatingLabelStyle: GoogleFonts.mPlus1(
                                      //   color: Colors.black,
                                      //   fontSize: 18,
                                      // ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: success ? Colors.green : Colors.red, width: 2),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      hintText: "Confirm Password",
                                      labelText: "Confirm Password",
                                      // hintStyle:
                                      // GoogleFonts.mPlus1(color: Colors.black),
                                      border: const OutlineInputBorder(borderSide: BorderSide()))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FlutterPwValidator(
                              defaultColor: Colors.grey.shade300,
                              controller: confirmcontroller,
                              successColor: Colors.green.shade700,
                              minLength: 8,
                              uppercaseCharCount: 1,
                              numericCharCount: 3,
                              specialCharCount: 1,
                              normalCharCount: 3,
                              width: 400,
                              height: 200,
                              onSuccess: () {
                                setState(() {
                                  success = true;
                                });
                              },
                              onFail: () {
                                setState(() {
                                  success = false;
                                });
                              },
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                label: isLoading == false ? 'Reset Password' : 'Please wait',
                                color: Colors.black,
                                onPressed: () async {
                                  loadRegister(widget.emil, confirmcontroller.text);
                                  // if (_key.currentState!.validate()) {}
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             const ResetPasswordOTPScreen()));
                                },
                                size: size,
                                textColor: Colors.white,
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ]))
                        ]))))));
  }

  Future<void> loadRegister(String email, String newpaswd) async {
    print("Emial----" + email + "  ssss ===" + newpaswd);
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(ApiUrl.restepaswd);
    final headers = {'Content-Type': 'application/json'};
    final datas = {"Email": email, "newpassword": newpaswd};

    final response = await http.post(url, headers: headers, body: jsonEncode(datas));

    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      print("resp in forget paswd===" + response.body);
      if (data["msg"] == "success") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandlordLogin()));
      } else {
        snack("Something went wrong", context);
        // String otp=data["otp"].toString();

        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => const LandloardDashBord()));
        // otprecieved = data['emial_otp'] == null
        //     ? ""
        //     : otprecieved = data['emial_otp'].toString();
        // // successDilog(data['msg']);
        // _showImageAlertDialog(context, otprecieved, name, emails, mobi);
      }
    } else {
      //  faliedDilog(data['msg']);
    }
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  final Color textColor;
  final BorderSide borderSide;
  final Size size;
  const CustomButton({
    Key? key,
    required this.label,
    required this.color,
    required this.onPressed,
    required this.size,
    required this.textColor,
    required this.borderSide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
            backgroundColor: color,
            side: borderSide,
            // elevation: 1.5,
            shadowColor: const Color(0xFF323247)),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
