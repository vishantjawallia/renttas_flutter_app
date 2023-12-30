// ignore_for_file: constant_identifier_names, prefer_interpolation_to_compose_strings, use_build_context_synchronously, avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, curly_braces_in_flow_control_structures, use_super_parameters, unused_element, unused_field, void_checks, prefer_final_fields

import 'dart:async';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pinput/pinput.dart';
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:renttas_flutter_app/widgets/global_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Wellcome/LoginPageNew.dart';

import '../model/userModel.dart';
import '../widgets/custom_text_field.dart';
import 'AddPropertyLanlord.dart';
import 'LandloardDashBord.dart';

class LanlordRegisterNew extends StatefulWidget {
  const LanlordRegisterNew({Key? key}) : super(key: key);

  @override
  State<LanlordRegisterNew> createState() => _LanlordRegisterState();
}

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

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

class _LanlordRegisterState extends State<LanlordRegisterNew> {
  TextEditingController otpcontroller = TextEditingController();
  TextEditingController landlordName = TextEditingController();
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  String phoneNumber = "";
  String countryCode = '+91';
  String currency = "INR";
  bool isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String verificationId;

  MobileVerificationState currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final _otpTimerBloc = OtpTimerBloc();

  @override
  void dispose() {
    _otpTimerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            const Image(
              height: 230,
              image: AssetImage('assets/images/login_bg.png'),
              fit: BoxFit.fill,
            ),
            !(currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE) ? _otpRegisterForm() : _createAccountForm(),
            SizedBox(
              width: 250,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff54854C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: isLoading ? null : () => !(currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE) ? verifyHandler() : createAccountHandler(),
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Color(0xff54854C),
                      )
                    : Text(
                        !(currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE) ? 'verify'.tr() : 'create_account'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 0.0, height: 55),
            !(currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE)
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "already_have".tr(),
                        // "Already Have a Account?",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 4, height: 0.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(builder: (context) => const LandlordLoginNew()),
                          // ),
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "login".tr(),
                            style: const TextStyle(
                              color: Color(0xff894747),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            const SizedBox(width: 0.0, height: 80),
          ],
        ),
      ),
    );
  }

  Column _createAccountForm() {
    return Column(
      children: [
        SizedBox(height: !(currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE) ? 20 : 30),
        Text(
          'signin'.tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: !(currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE) ? 30 : 30),
        Row(
          children: [
            Flexible(
              flex: 6,
              child: CustomTextField(
                enabled: (currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE),
                controller: fName,
                iconData: Icons.person,
                hintText: 'fname'.tr() + " *",
                margin: const EdgeInsets.fromLTRB(20, 6, 5, 6),
              ),
            ),
            Flexible(
              flex: 6,
              child: CustomTextField(
                enabled: (currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE),
                controller: lName,
                iconData: Icons.person,
                hintText: 'lname'.tr(),
                margin: const EdgeInsets.fromLTRB(5, 6, 20, 6),
              ),
            ),
          ],
        ),
        CustomTextField(
          enabled: (currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE),
          controller: emailController,
          hintText: 'email'.tr() + " *",
          iconData: Icons.email,
        ),
        Container(
          // height: 70,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          margin: const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xffEFE3E3),
          ),
          child: IntlPhoneField(
              disableLengthCheck: true,
              flagsButtonMargin: EdgeInsets.zero,
              flagsButtonPadding: EdgeInsets.zero,
              dropdownIconPosition: IconPosition.trailing,
              decoration: InputDecoration(
                enabled: !(currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE),
                hintText: 'mobile_number'.tr() + " *",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintStyle: const TextStyle(color: Colors.black38),
                filled: true,
                fillColor: Colors.transparent,
                isDense: true,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
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
              }),
        ),
        CustomTextField(
          enabled: (currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE), controller: passwordController, obscureText: true, hintText: ("password".tr() + " *"),
          // 'Password *',
        ),
        CustomTextField(
          enabled: (currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE),
          controller: confirmPassword,
          obscureText: true,
          hintText: "confirm_password".tr() + " *",
          //  'Confirm password *',
        ),
        const SizedBox(width: 0.0, height: 40)
      ],
    );
  }

  Future<void> loadRegister(
    String name,
    String emails,
    String mobi,
    String address,
    String pass,
    String confirmPass,
    String currencyCode,
  ) async {
    setState(() => isLoading = true);
    final url = Uri.parse(ApiUrl.register);
    final headers = {'Content-Type': 'application/json'};
    final datas = {
      "name": name,
      "mobileNo": mobi,
      "currency": currencyCode,
      "email": emails,
      "address": address,
      "password": pass,
      "role": "admin",
    };
    log(datas.toString());

    final response = await http.post(url, headers: headers, body: jsonEncode(datas));

    Map<String, dynamic> data = jsonDecode(response.body);
    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    UserModel user = UserModel.fromJson(jsonData);

    print("resp ion reggg====" + response.body + "Stcode===" + response.statusCode.toString());
    if (response.statusCode == 200) {
      setState(() => isLoading = false);
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

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AddPropertyLanlord(type: "0", userid: userId),
          ),
        );
      }
    } else {
      faliedDilog(data['msg']);
    }
  }

  Future<void> shareData(
    String userId,
    String name,
    String email,
    String phone,
    String currency,
    String roleId,
  ) async {
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LandlordLoginNew()));
              },
            ),
          ],
        );
      },
    );
  }

  void createAccountHandler() async {
    if (fName.text.isEmpty) return GlobalWidgets.toast('Invalid name !');
    if (emailController.text.isEmpty) return GlobalWidgets.toast('Invalid email !');
    if (passwordController.text.isEmpty) return GlobalWidgets.toast('Invalid phone number !');
    if (passwordController.text.isEmpty) return GlobalWidgets.toast('Invalid password !');
    if (passwordController.text != confirmPassword.text) return GlobalWidgets.toast("Password doesn't match !");
    if (phoneNumber.length == 13) {
      setState(() => isLoading = true);

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber.trim(),
        verificationCompleted: (phoneAuthCredential) async {
          setState(() {
            isLoading = false;
            otpcontroller.text = phoneAuthCredential.smsCode.toString();
          });
        },
        verificationFailed: (verificationFailed) async {
          setState(() => isLoading = false);
          if (kDebugMode) {
            print("verificationFailed message" + verificationFailed.message.toString());
          }
        },
        codeSent: (verificationId, resendingToken) async {
          setState(() {
            isLoading = false;
            currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
            this.verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {},
      );
    }
  }

  void verifyHandler() async {
    if (otpcontroller.text.isEmpty) return GlobalWidgets.toast('Invalid OTP !');
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpcontroller.text);
    setState(() => isLoading = true);
    try {
      final authCredential = await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        loadRegister(
          "${fName.text} ${lName.text}",
          emailController.text,
          phoneNumber,
          addressController.text,
          passwordController.text,
          confirmPassword.text,
          currency,
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() => isLoading = false);
      // snack(e.message.toString(), context);
      return GlobalWidgets.toast('${e.message}');
    }
  }

  Column _otpRegisterForm() {
    return Column(
      children: [
        const SizedBox(height: 30),
        const Text(
          'Sigin',
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 0.0, height: 50),
              const Text(
                'Enter Verification Code',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 0.0, height: 20),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Pinput(
                    submittedPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        color: const Color(0xffEFE3E3),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        color: const Color(0xffEFE3E3),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    followingPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        color: const Color(0xffEFE3E3),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        color: const Color(0xffEFE3E3),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    pinAnimationType: PinAnimationType.fade,
                    length: 6,
                    controller: otpcontroller,
                    // onChanged: (val) {
                    // },
                  ),
                ),
              ),
              const SizedBox(width: 0.0, height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "I haven't get the code:",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 4, height: 0.0),
                  GestureDetector(
                    onTap: () => {},
                    child: StreamBuilder<int>(
                      stream: _otpTimerBloc.timerStream,
                      builder: (context, snapshot) {
                        // if (snapshot.hasData) {
                        return RichText(
                          text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (snapshot.data == 0) {
                                  _otpTimerBloc.resetTimer();
                                  resendOtpHanlder();
                                }
                              },
                            text: (snapshot.data ?? 0) > 0 ? "${snapshot.data}s" : "RESEND",
                            style: const TextStyle(
                              color: Color(0xff894747),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 0.0, height: 30),
            ],
          ),
        ),
      ],
    );
  }

  void resendOtpHanlder() {}
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

class OtpTimerBloc {
  final _timerController = StreamController<int>();
  late Timer _timer;
  int _countdown = 60;

  Stream<int> get timerStream => _timerController.stream;

  OtpTimerBloc() {
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        _countdown--;
        _timerController.add(_countdown);
      } else {
        _timer.cancel();
        _timerController.close();
      }
    });
  }

  void resetTimer() {
    _countdown = 60;
    _timerController.add(_countdown);
    startTimer();
  }

  void dispose() {
    _timer.cancel();
    _timerController.close();
  }
}
