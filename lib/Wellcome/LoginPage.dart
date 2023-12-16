// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
// import 'package:renttas_flutter_app/Common/ApiUrl.dart';
// import 'package:renttas_flutter_app/Common/RentalCustomAlert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Common/RentalCustomAlert.dart';
import '../ForgotPaswd/ForgotPaswdScreen.dart';
import '../landlord/LandloardDashBord.dart';
import '../model/userModel.dart';
import '../tandent/Tenantdashbord.dart';
import 'TypeUser.dart';

class LandlordLogin extends StatefulWidget {
  const LandlordLogin({Key? key}) : super(key: key);

  @override
  State<LandlordLogin> createState() => _LandlordLoginState();
}

class _LandlordLoginState extends State<LandlordLogin> {
  TextEditingController landlordEmail = TextEditingController();
  TextEditingController landlordPassword = TextEditingController();
  bool isLoading = false;
  final storage = FlutterSecureStorage();
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
      margin: EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black,
                      Colors.yellow,
                      Colors.green,
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 140,
                      ),
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            height: 60,
                            child: TextField(
                              controller: landlordEmail,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.black87),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Color(0xff5ac18e),
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.black38),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              height: 60,
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
                                  floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.black38),
                                  filled: true, // Needed for adding a fill color
                                  fillColor: Colors.white,
                                  isDense: true, // Reduces height a bit
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none, // No border
                                    borderRadius: BorderRadius.circular(12), // Apply corner radius
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock_rounded,
                                    size: 24,
                                    color: Color(0xff5ac18e),
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
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ResetPasswordScreen())),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            // color: Colors.white,
                            child: Text(
                              " Forget Password ?",
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
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
                          onPressed: isLoading ? null : () => landlordLoginAuth(),
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Color(0xff5ac18e),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 40,
                          ),
                          const Text(
                            "Don't Have An Account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const TypeUser()),
                              ),
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: "Register",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Future<void> landlordLoginAuth() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(ApiUrl.Login);
    final Map<String, dynamic> requestData = {
      "email": landlordEmail.text.trim(),
      "password": landlordPassword.text.trim(),
    };

    final headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(url, headers: headers, body: jsonEncode(requestData));

    // final request = await http.Request('GET', Uri.parse(ApiUrl.Login));
    // request.body = jsonEncode({
    //   "email": ,
    //   "password":
    // });
    //
    // // Send the request.
    // final response = await request.send();
    //
    // // Get the response body.
    // final stream = response.stream;
    // final body = await stream.bytesToString();
    // print(body);

    print("responsedooo===" + response.body);
    final Map<String, dynamic> jsonData = jsonDecode(response.body);

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
        prefs.setString("sw", "1");
        prefs.setString("storeid", "1");

        navigateToLanlord();
      } else if (roleId == "user") {
        prefs.setString("sw", "0");
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
          title: const Text('Login Failed'),
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

// Future<void> _storeEmailAndPassword(String email, String password) async {
//   await storage.write(key: "emailKey", value: email);
//   await storage.write(key: "passwordKey", value: password);
// }
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
}
