// ignore_for_file: constant_identifier_names, prefer_interpolation_to_compose_strings, use_build_context_synchronously, avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, curly_braces_in_flow_control_structures, use_super_parameters, unused_element, unused_field

import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pinput/pinput.dart';
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Wellcome/LoginPage.dart';
import '../model/userModel.dart';
import 'AddPropertyLanlord.dart';
import 'LandloardDashBord.dart';

class LanlordRegister extends StatefulWidget {
  const LanlordRegister({Key? key}) : super(key: key);

  @override
  State<LanlordRegister> createState() => _LanlordRegisterState();
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

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _LanlordRegisterState extends State<LanlordRegister> {
  TextEditingController landlordName = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  String phoneNumber = "";
  String countryCode = '+91';
  String currency = "INR";
  bool isLoading = false;
  String otprecieved = "";
  String _password = '';
  String _confirmPassword = '';

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

  var otp;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String verificationId;
  bool showLoading = false;
  MobileVerificationState currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final _formKey = GlobalKey<FormState>();

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
      // _scaffoldKey.currentState!
      //     .showSnackBar(SnackBar(content: Text(e.message)));
    }
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
                  return 'Please enter email id!';
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
                  return 'Please enter address!';
                }
                return null;
              },
            ),
            // TextFormField(
            //   controller: districtController,
            //   decoration: const InputDecoration(
            //     icon: Icon(Icons.area_chart),
            //     hintText: 'Enter your District',
            //     labelText: 'District *',
            //   ),
            // ),
            // TextFormField(
            //   controller: blockController,
            //   decoration: const InputDecoration(
            //     icon: Icon(Icons.add_business),
            //     hintText: 'Enter your Block',
            //     labelText: 'Block *',
            //   ),
            // ),
            // TextFormField(
            //   controller: pincodeController,
            //   keyboardType: TextInputType.number,
            //   decoration: const InputDecoration(
            //     icon: Icon(Icons.pin),
            //     hintText: 'Enter your Pincode',
            //     labelText: 'Pincode *',
            //   ),
            // ),
            TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscured,
                focusNode: textFieldFocusNode,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
                  icon: const Icon(Icons.lock, size: 25),
                  hintText: 'Enter your Password',
                  labelText: 'Password', // Needed for adding a fill color
                  isDense: true, // Reduces height a bit
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
                onChanged: (value) {
                  _password = value;
                },
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Password is required please enter';
                  }
                  // you can check password length and specifications

                  return null;
                }),
            TextFormField(
                controller: confirmPassword,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscuredconfirm,
                focusNode: textFieldFocusNodeconfirm,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
                  icon: const Icon(Icons.lock, size: 25),
                  hintText: 'Enter your Confirm-Password',
                  labelText: 'Confirm-Password',
                  isDense: true, // Reduces height a bit
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
                    // do the API call here

                    print("sssss===" + phoneNumber);

                    if (phoneNumber.length == 13) {
                      setState(() {
                        showLoading = true;
                      });
                      await _auth.verifyPhoneNumber(
                        phoneNumber: phoneNumber.trim(),
                        verificationCompleted: (phoneAuthCredential) async {
                          setState(() {
                            showLoading = false;
                          });
                        },
                        verificationFailed: (verificationFailed) async {
                          setState(() {
                            showLoading = false;
                          });
                          if (kDebugMode) {
                            print("verificationFailed message" + verificationFailed.message.toString());
                          }
                        },
                        codeSent: (verificationId, resendingToken) async {
                          setState(() {
                            showLoading = false;
                            currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                            this.verificationId = verificationId;
                          });
                        },
                        codeAutoRetrievalTimeout: (verificationId) async {},
                      );
                    }
                    // loadRegister(
                    //     landlordName.text,
                    //     emailController.text,
                    //     phoneNumber,
                    //     addressController.text,
                    //     passwordController.text,
                    //     confirmPassword.text,
                    //     currency);
                  }
                },
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const Text(
                        'Register',
                        style: TextStyle(
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
              onTap: () => {Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LandlordLogin()))},
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

  getOtpFormWidget(context) {
    return Column(
      children: [
        // Spacer(),
        //    getloginotpwidget(context),
        // Spacer(),
        const Text(
          'ENTER OTP.',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
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
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
            onPressed: () async {
              log("inside onpress" + otp.toString());
              PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp.toString());

              signInWithPhoneAuthCredential(phoneAuthCredential);

              //    Navigator.pushReplacement(
              // context, MaterialPageRoute(builder: (context) => dashboard()));
            },
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.black38,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(borderRadius: BorderRadius.zero, side: BorderSide(color: Color.fromARGB(255, 0, 0, 0))))),
            child: const Text(
              "VERIFY",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
        // Spacer(
        //   flex: 2,
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('RENTTAS'),
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
      body: Container(
        child: SingleChildScrollView(
            // physics: const BouncingScrollPhysics(),
            child: Container(
          width: double.infinity,
          color: Colors.white,
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          //       Color.fromARGB(255, 192, 222, 227),
          //       Color.fromARGB(255, 235, 230, 230),
          //       Color.fromARGB(255, 242, 241, 239)
          //     ])),
          child: showLoading
              ? const Center(child: CircularProgressIndicator())
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        )),
      ),
    );
  }

  getloginotpwidget(context) {
    return Container(
      height: 400,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //   children: [Icon(size: 100, Icons.lock_person_sharp)],
      ),
      //color: Color.fromARGB(255, 184, 9, 9),
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
    final datas = {"name": name, "mobileNo": mobi, "currency": currencyCode, "email": emails, "address": address, "password": pass, "role": "admin"};

    final response = await http.post(url, headers: headers, body: jsonEncode(datas));

    Map<String, dynamic> data = jsonDecode(response.body);
    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    UserModel user = UserModel.fromJson(jsonData);

    print("resp ion reggg====" + response.body + "Stcode===" + response.statusCode.toString());
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      if (data["msg"] == "You are already registered.") {
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
        prefs.setBool("login", false);
        prefs.setString("sw", "1");

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddPropertyLanlord(type: "0", userid: userId)));

        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (context) => const LandloardDashBord()));
        // otprecieved = data['emial_otp'] == null
        //     ? ""
        //     : otprecieved = data['emial_otp'].toString();
        // // successDilog(data['msg']);
        // _showImageAlertDialog(context, otprecieved, name, emails, mobi);
      }
    } else {
      faliedDilog(data['msg']);
    }
  }

  Future<void> shareData(String userId, String name, String email, String phone, String currency, String roleId) async {
    print("inshared");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    preferences.setBool("login", false);
    await preferences.setString('userId', userId);
    await preferences.setString('name', name);
    await preferences.setString('email', email);
    await preferences.setString('phone', phone);
    await preferences.setString('currency', currency);
    await preferences.setString('roleId', roleId);
  }

  void faliedDilog(String respMsg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Register  Failed'),
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
          title: const Text('Register  Failed'),
          content: Text(respMsg),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LandlordLogin()));
              },
            ),
          ],
        );
      },
    );
  }
}

void _showImageAlertDialog(BuildContext context, String otp, String name, String email, String phoneno) {
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
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),
              onPressed: () async {
                if (pinnumer.toString() == otp) {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString("email", email);
                  prefs.setString("mbno", phoneno);
                  prefs.setString("name", name);
                  prefs.setBool("login", false);
                  prefs.setString("storeid", "1");

                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LandloardDashBord()));
                } else {
                  snack("Enterd otp is incorrect", context);
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
