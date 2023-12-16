// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, use_build_context_synchronously, use_super_parameters, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../Common/ApiUrl.dart';
import '../Const/Const.dart';

import 'package:http/http.dart' as http;

import 'RestenewPassScreen.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset_password';
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(height: 70),
                    const Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Enter the mail address with your account and we will send an email with confirmation to reset your'
                      ' password',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // const Text(
                    //   'Email address',
                    //   style: TextStyle(
                    //     fontSize: 15,
                    //     color: Colors.black,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      //obscureText: obscureText,
                      controller: _emailController,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,

                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                      decoration: InputDecoration(
                        hintText: "abc@example.com",
                        labelText: "Email",
                        hintStyle: const TextStyle(
                            color: Color(0xFF666666), fontSize: 13),
                        filled: true,
                        fillColor: const Color(0x99E4E4E4),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                color: Color(0xFFE4E4E4), width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                color: Color(0xFFE4E4E4), width: 1)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Expanded(child: SizedBox()),
                    CustomButton(
                      label: isLoading == false ? 'Send Code' : 'Please wait',
                      color: Colors.black,
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          loadRegister(_emailController.text);
                        }
                      },
                      size: size,
                      textColor: Colors.white,
                      borderSide: BorderSide.none,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loadRegister(
    String email,
  ) async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(ApiUrl.forgetPassword);
    final headers = {'Content-Type': 'application/json'};
    final datas = {
      "email": email.trim(),
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(datas));

    Map<String, dynamic> data = jsonDecode(response.body);

    print("response forget ==="+data.toString());
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      print("resp in forget paswd===" + response.body);
      if (data["msg"] == "email is invalid") {
        snack(data["msg"], context);
      } else {
        snack("OTP sent to your email", context);
        String otp = data["otp"].toString();

        print("otp=====" + otp);

        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ResetPasswordOTPScreen(otp:otp,email:email)));

        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => const LandloardDashBord()));
        // otprecieved = data['emial_otp'] == null
        //     ? ""
        //     : otprecieved = data['emial_otp'].toString();
        // // successDilog(data['msg']);
        _showImageAlertDialog(context, otp, email);
      }
    } else {
      //  faliedDilog(data['msg']);
    }
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
        //  title: Text('Image Alert Dialog'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/images/renttas.png', // Replace with your image path
              width: 150, // Adjust image width as needed
            ),
            //   SizedBox(height: 2), // Adjust spacing as needed
            const Text('Enter 4 digit OTP here'),
          ],
        ),
        actions: <Widget>[
          OTPTextField(
              //   controller: otpcontroller,
              length: 4,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldWidth: 45,
              fieldStyle: FieldStyle.box,
              //     outlineBorderRadius: 15,
              style: const TextStyle(fontSize: 17),
              onChanged: (pin) {
                //  print("Changed: " + pin);
              },
              onCompleted: (pin) {
                pinnumer = pin;
                //   print("Completed: " + pinnumer);
              }),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange)),
              onPressed: () async {
                if (pinnumer.toString() == otp) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetNewpassScreen(
                                emil: email,
                              )));
                  //    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ResetPasswordOTPScreen(otp:otp,email:email)));
                } else {
                  snack("Enterd otp is incorrect,please try again", context);
                  Navigator.of(context).pop();
                }

                // Close the AlertDialog
              },
              child: const Text('Verify OTP'),
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
