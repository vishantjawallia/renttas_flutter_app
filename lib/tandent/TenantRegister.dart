// ignore_for_file: use_super_parameters, constant_identifier_names,  use_build_context_synchronously, prefer_interpolation_to_compose_strings, sort_child_properties_last, sized_box_for_whitespace, unused_element, avoid_print, prefer_final_fields, prefer_typing_uninitialized_variables, curly_braces_in_flow_control_structures, unused_field

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pinput/pinput.dart';

import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Wellcome/LoginPageNew.dart';
import '../model/userModel.dart';
import 'Tenantdashbord.dart';

class TenantRegister extends StatefulWidget {
  const TenantRegister({Key? key}) : super(key: key);

  @override
  State<TenantRegister> createState() => _TenantRegisterState();
}

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

TextEditingController otpcontroller = TextEditingController();
void snack(String msg, BuildContext context) {
  final snackBar = SnackBar(
    content: Text(msg),
    backgroundColor: Colors.black,
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(5),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class _TenantRegisterState extends State<TenantRegister> {
  TextEditingController landlordName = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var otp;
  FirebaseAuth _auth = FirebaseAuth.instance;
  late String verificationId;
  bool showLoading = false;
  MobileVerificationState currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  String phoneNumber = "";
  String _password = '';
  String _confirmPassword = '';
  String countryCode = '+91';
  String currency = "INR";
  bool isLoading = false;
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  String otprecieved = "";
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return;
      textFieldFocusNode.canRequestFocus = false;
    });
  }

  final textFieldFocusNodeconfirm = FocusNode();
  bool _obscuredconfirm = true;

  void _toggleObscuredconfirm() {
    setState(() {
      _obscuredconfirm = !_obscuredconfirm;
      if (textFieldFocusNodeconfirm.hasPrimaryFocus) return;
      textFieldFocusNodeconfirm.canRequestFocus = false;
    });
  }

  getMobileFormWidget(context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            TextFormField(
              controller: landlordName,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'What do people call you?',
                labelText: 'Name *',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name!';
                }
                return null;
              },
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: IntlPhoneField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your mobile number',
                        labelText: 'Mobile Number *',
                      ),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        _onPhoneNumberChanged(phone.completeNumber);
                        setState(() {
                          phoneNumber = phone.completeNumber;
                          countryCode = phone.countryCode;
                          if (countryCode == "+91") {
                            currency = "INR";
                          } else if (countryCode == "+44") {
                            currency = "GBP";
                          } else {
                            currency = "USD";
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'Enter your mail id',
                labelText: 'Email *',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your mail!';
                }
                return null;
              },
            ),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(
                icon: Icon(Icons.home),
                hintText: 'Enter your Address details',
                labelText: 'Address *',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Address!';
                }
                return null;
              },
            ),
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obscured,
              focusNode: textFieldFocusNode,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                icon: const Icon(Icons.lock, size: 25),
                hintText: 'Enter your Password',
                labelText: 'Password',
                isDense: true,
                suffixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: GestureDetector(
                    onTap: _toggleObscured,
                    child: Icon(
                      _obscured ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      size: 24,
                    ),
                  ),
                ),
              ),
              onChanged: (value) => _password = value,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Password is required please enter';
                }
                return null;
              },
            ),
            TextFormField(
                controller: confirmPassword,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscuredconfirm,
                focusNode: textFieldFocusNodeconfirm,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  icon: const Icon(Icons.lock, size: 25),
                  hintText: 'Enter your Confirm-Password',
                  labelText: 'Confirm-Password',
                  isDense: true,
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
                ),
                onChanged: (value) {
                  _confirmPassword = value;
                },
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Conform password is required please enter';
                  }
                  if (value != _password) {
                    return 'Confirm password not matching';
                  }
                  return null;
                }),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 250,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    loadRegister(landlordName.text, emailController.text, phoneNumber, addressController.text, passwordController.text, confirmPassword.text, currency);
                  }
                },
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Color(0xff54854C),
                      )
                    : Text(
                        'Register',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () => {Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LandlordLoginNew()))},
              child: RichText(
                text: const TextSpan(
                  text: "Already have a Account?Login",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential = await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        loadRegister(landlordName.text, emailController.text, phoneNumber, addressController.text, passwordController.text, confirmPassword.text, currency);
        log("success");
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      print("message======" + e.message.toString());
      snack(e.message.toString(), context);
    }
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        Text(
          'ENTER OTP.',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Center(
          child: Pinput(
            length: 6,
            onChanged: (val) {
              if (val.length == 6) {
                log(val);
                otp = val;
                log('assigned otp' + otp.toString());
              }
            },
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            log("inside onpress" + otp.toString());
            PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: otp.toString(),
            );
            signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          child: Text(
            "VERIFY",
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.black38,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                side: BorderSide(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  getloginotpwidget(context) {
    return Container(
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //   children: [Icon(size: 100, Icons.lock_person_sharp)],
      ),
      height: 400,
      //color: Color.fromARGB(255, 184, 9, 9),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RENTTAS'),
        centerTitle: true,
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
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: showLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Color(0xff54854C),
                ))
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  void _onPhoneNumberChanged(String phone) {
    setState(() {
      phoneNumber = phone;
    });
  }

  Future<void> loadRegister(String name, String emails, String mobi, String address, String pass, String confirmPass, String currencyCode) async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(ApiUrl.register);
    final headers = {'Content-Type': 'application/json'};
    final datas = {"name": name, "mobileNo": mobi, "currency": currencyCode, "email": emails, "address": address, "password": pass, "role": "user"};

    final response = await http.post(url, headers: headers, body: jsonEncode(datas));

    if (kDebugMode) {
      print("respi n tenant==" + response.body);
    }

    Map<String, dynamic> data = jsonDecode(response.body);
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(jsonData);

      setState(() {
        isLoading = false;
      });
      if (data["loginstatus"] == "notok") {
        snack(data["msg"], context);
      } else {
        String userId = user.id;

        String name = user.name;
        String email = user.email;
        String phone = user.mobileNo;
        String roleId = user.role;
        String currency = user.currency;

        await shareData(userId, name, email, phone, currency, roleId);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("email", emails);
        prefs.setString("mbno", mobi);
        prefs.setString("name", name);
        prefs.setBool("login", true);
        prefs.setString("sw", "0");
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Tenantdashbord()));
      }
    } else {
      faliedDilog(data['message']);
    }
  }

  void faliedDilog(String respMsg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Register  Failed'),
          content: Text(respMsg),
          actions: [
            TextButton(
              child: Text('OK'),
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
          title: Text('Register  Failed'),
          content: Text(respMsg),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }
}

void _showImageAlertDialog(BuildContext context, String otp) {
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
              onCompleted: (pin) => pinnumer = pin),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),
              onPressed: () {
                if (pinnumer.toString() == otp) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Tenantdashbord()));
                } else {
                  snack("Enterd otp is incorrect", context);
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

Future<void> shareData(String userId, String name, String email, String phone, String currency, String roleId) async {
  print("inshared");
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  preferences.setBool("login", true);
  await preferences.setString('userId', userId);
  await preferences.setString('name', name);
  await preferences.setString('email', email);
  await preferences.setString('phone', phone);
  await preferences.setString('currency', currency);
  await preferences.setString('roleId', roleId);
}
