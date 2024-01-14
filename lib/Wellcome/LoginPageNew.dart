// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:renttas_flutter_app/widgets/global_widget.dart';
// import 'package:renttas_flutter_app/Common/ApiUrl.dart';
// import 'package:renttas_flutter_app/Common/RentalCustomAlert.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Common/RentalCustomAlert.dart';
import '../ForgotPaswd/ForgotPaswdScreen.dart';
import '../landlord/LandloardDashBord.dart';
import '../model/userModel.dart';
import '../tandent/Tenantdashbord.dart';
import 'TypeUser.dart';

class LandlordLoginNew extends StatefulWidget {
  const LandlordLoginNew({super.key});

  @override
  State<LandlordLoginNew> createState() => _LandlordLoginNewState();
}

class _LandlordLoginNewState extends State<LandlordLoginNew> {
  TextEditingController landlordEmail = TextEditingController();
  TextEditingController landlordPassword = TextEditingController();
  bool isLoading = false;
  // final storage = FlutterSecureStorage();
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false; // Prevents focus if tap on eye
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void snack(String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.black,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //   backgroundColor: Color(0xff54854C),
      //   elevation: 0,
      //   // title: ,
      // ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        height: 230,
                        image: AssetImage('assets/images/login_bg.png'),
                        fit: BoxFit.fill,
                      ),
                      const Image(
                        height: 150,
                        image: AssetImage('assets/images/user_profile.png'),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "sign_in".tr(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xffF8F3E7),
                        ),
                        child: TextField(
                          controller: landlordEmail,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(top: 14),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Color(0xff54854C),
                            ),
                            hintText: 'email'.tr(),
                            hintStyle: const TextStyle(color: Colors.black38),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xffEFE3E3),
                        ),
                        child: TextField(
                          controller: landlordPassword,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscured,
                          focusNode: textFieldFocusNode,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          style: const TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintText: 'password'.tr(),
                            hintStyle: const TextStyle(color: Colors.black38),
                            filled: true,
                            fillColor: Colors.transparent,
                            isDense: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_rounded,
                              size: 24,
                              color: Color(0xff54854C),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                              child: GestureDetector(
                                onTap: _toggleObscured,
                                child: Icon(
                                  _obscured ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                  size: 24,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 0.0, height: 10),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ResetPasswordScreen())),
                          child: Text(
                            "forget_pass".tr(),
                            // "Forget Your Password ?",
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
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
                          onPressed: isLoading ? null : () => LandlordLoginNewAuth(),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Color(0xff54854C),
                                )
                              : Text(
                                  "login".tr(),
                                  // 'Login',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 0.0, height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "dont_have_account".tr(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 4, height: 0.0),
                          GestureDetector(
                            onTap: () => {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const TypeUser()),
                              ),
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "sign_up".tr(),
                                // "Sign Up",
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
                      const SizedBox(width: 0.0, height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> LandlordLoginNewAuth() async {
    if (landlordEmail.text.isEmpty) return GlobalWidgets.toast('Invalid Email !');
    if (landlordPassword.text.isEmpty) return GlobalWidgets.toast('Invalid Password !');
    setState(() => isLoading = true);
    final url = Uri.parse(ApiUrl.Login);
    final Map<String, dynamic> requestData = {
      "email": landlordEmail.text.trim(),
      "password": landlordPassword.text.trim(),
    };

    final headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(requestData),
    );

    print("responsedooo===" + response.body);
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    log("url===" + url.toString());
    log("data===" + jsonData.toString());

    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(jsonData);
      if (user.overallStatus == "notok") {
        snack("Entered username or password is incorrect");
      }
      String userId = user.id;

      String name = user.name;
      String email = user.email;
      String phone = user.mobileNo;
      String roleId = user.role;
      String currency = user.currency;
      print("user in shared data-" + user.mobileNo);

      SharedPreferences prefs = await SharedPreferences.getInstance();

      // _storeEmailAndPassword(email,landlordPassword.text);
      await shareData(userId, name, email, phone, currency, roleId);
      if (roleId == "admin") {
        await prefs.setString("sw", "1");
        await prefs.setString("storeid", "1");

        navigateToLanlord();
      } else if (roleId == "user") {
        await prefs.setString("sw", "0");
        navigateToTandent();
      }
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Bill()));
    } else {
      RentalCustomAlert.showErrorsAlert(context, "Error", "InvallidCradencial");
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> navigateToLanlord() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LandloardDashBord()),
    );
  }

  Future<void> navigateToTandent() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Tenantdashbord()),
    );
  }

  void faliedDilog(String respMsg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Failed'),
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
}
