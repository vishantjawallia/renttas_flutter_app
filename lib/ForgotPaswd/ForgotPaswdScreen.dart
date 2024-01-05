// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, use_build_context_synchronously, use_super_parameters, prefer_final_fields

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../Common/ApiUrl.dart';
import '../Const/Const.dart';

import 'package:http/http.dart' as http;

import '../widgets/custom_text_field.dart';
import 'RestenewPassScreen.dart';

class ResetPasswordScreen extends StatefulWidget {
  static String id = 'reset_password';
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        leading: const BackButton(),
        title: Text(
          "forget_password".tr(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          width: size.width,
          color: Colors.white,
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 80),
                      Text(
                        "forget_password".tr(),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "forget_password_dsc".tr(),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(30),
                  ],
                  hintText: 'email'.tr(),
                ),
                const SizedBox(height: 40),
                Center(
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
                        if (_key.currentState!.validate()) {
                          loadRegister(_emailController.text);
                        }
                      },
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Color(0xff54854C),
                            )
                          : Text(
                              "sumbit".tr(),
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
          ),
        ),
      ),
    );
  }

  Future<void> loadRegister(
    String email,
  ) async {
    setState(() => isLoading = true);
    final url = Uri.parse(ApiUrl.forgetPassword);
    final headers = {'Content-Type': 'application/json'};
    final datas = {
      "email": email.trim(),
    };

    final response = await http.post(url, headers: headers, body: jsonEncode(datas));

    Map<String, dynamic> data = jsonDecode(response.body);

    print("response forget ===" + data.toString());
    if (response.statusCode == 200) {
      setState(() => isLoading = false);
      print("resp in forget paswd===" + response.body);
      if (data["msg"] == "email is invalid") {
        snack(data["msg"], context);
      } else {
        snack("OTP sent to your email", context);
        String otp = data["otp"].toString();

        print("otp=====" + otp);

        _showImageAlertDialog(context, otp, email);
      }
    } else {}
  }
}

void _showImageAlertDialog(
  BuildContext context,
  String otp,
  String email,
) {
  String pinnumer = "";
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/renttas.png',
              width: 150,
            ),
            Text('Enter 4 digit OTP here'),
          ],
        ),
        actions: [
          OTPTextField(
            length: 4,
            width: MediaQuery.of(context).size.width,
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldWidth: 45,
            fieldStyle: FieldStyle.box,
            style: const TextStyle(fontSize: 17),
            onChanged: (pin) {},
            onCompleted: (pin) => pinnumer = pin,
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),
              onPressed: () async {
                if (pinnumer.toString() == otp) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResetNewpassScreen(
                        emil: email,
                      ),
                    ),
                  );
                } else {
                  snack("Enterd otp is incorrect,please try again", context);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Verify OTP'),
            ),
          ),
        ],
      );
    },
  );
}

class CustomButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  final Color textColor;
  final BorderSide borderSide;
  final Size size;
  const CustomButton({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
    required this.size,
    required this.textColor,
    required this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17), backgroundColor: color, side: borderSide, shadowColor: const Color(0xFF323247)),
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
