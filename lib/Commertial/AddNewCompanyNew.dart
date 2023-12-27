// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, unnecessary_new, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Common/ApiUrl.dart';
import 'CommertialDashboard.dart';

class addnewcompanynew extends StatefulWidget {
  String type, comapnyid, name;
  addnewcompanynew({super.key, required this.type, required this.comapnyid, this.name = ""});

  @override
  State<addnewcompanynew> createState() => _addnewcompanynewState();
}

var _formKey = GlobalKey<FormState>();
TextEditingController companynamecontroller = new TextEditingController();
TextEditingController companyaddresscontroller = new TextEditingController();
bool isloading = false;

class _addnewcompanynewState extends State<addnewcompanynew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        leading: const BackButton(),
        title: Text(
          "Add ${widget.name}",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      // appBar: AppBar(
      //   backgroundColor: Colors.grey[300],

      //   automaticallyImplyLeading: false,
      //   actions: <Widget>[
      //     Container(
      //       child: Expanded(
      //         child: Row(
      //           children: [
      //             SizedBox(
      //               width: 10,
      //             ),
      //             InkWell(
      //               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => commerialdashboard())),
      //               child: Icon(
      //                 Icons.arrow_back,
      //                 size: 30,
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   widget.type == "0" ? Text("Add New company") : Text("Edit company")
      //                   // Text(
      //                   //   "ab@gmail.com",
      //                   //   style: TextStyle(fontWeight: FontWeight.bold),
      //                   // )
      //                 ],
      //               ),
      //             ),
      //             // Flexible(fit: FlexFit.tight, child: SizedBox()),
      //             // Padding(
      //             //   padding: const EdgeInsets.all(8.0),
      //             //   child: Icon(
      //             //     Icons.search,
      //             //     size: 24,
      //             //   ),
      //             // ),
      //             // Padding(
      //             //   padding: const EdgeInsets.all(8.0),
      //             //   child: Container(
      //             //       padding: EdgeInsets.all(10),
      //             //       decoration: BoxDecoration(
      //             //           color: Colors.white,
      //             //           borderRadius: BorderRadius.circular(40)),
      //             //       //alignment: Alignment.center,
      //             //       child: Icon(
      //             //         Icons.qr_code_scanner_outlined,
      //             //         size: 20,
      //             //       )
      //             //     // Text(
      //             //     //   'Premium',
      //             //     //   style: TextStyle(
      //             //     //     fontSize: 18,
      //             //     //     fontWeight: FontWeight.bold,
      //             //     //   ),
      //             //     //   textAlign: TextAlign.center,
      //             //     // ),
      //             //   ),
      //             // ),
      //             // Padding(
      //             //   padding: const EdgeInsets.all(8.0),
      //             //   child: Container(
      //             //       padding: EdgeInsets.all(10),
      //             //       decoration: BoxDecoration(
      //             //           color: Colors.white,
      //             //           borderRadius: BorderRadius.circular(40)),
      //             //       //alignment: Alignment.center,
      //             //       child: Icon(
      //             //         Icons.mobile_screen_share_rounded,
      //             //         size: 20,
      //             //       )
      //             //     // Text(
      //             //     //   'Premium',
      //             //     //   style: TextStyle(
      //             //     //     fontSize: 18,
      //             //     //     fontWeight: FontWeight.bold,
      //             //     //   ),
      //             //     //   textAlign: TextAlign.center,
      //             //     // ),
      //             //   ),
      //             // ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enter Company name"),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 400,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextFormField(
                              controller: companynamecontroller,
                              decoration: new InputDecoration.collapsed(hintText: 'Enter company name'),
                              style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your company name!';
                                }
                                return null;
                              },
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Enter company address"),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 400,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextFormField(
                              controller: companyaddresscontroller,
                              decoration: new InputDecoration.collapsed(hintText: 'Enter company address'),
                              style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your company address!';
                                }
                                return null;
                              },
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    height: 50,
                    width: 400,
                    child: Center(
                      child: TextButton(
                        child: isloading == true
                            ? CircularProgressIndicator(
                                color: Color(0xff54854C),
                              )
                            : widget.type == "0"
                                ? Text(
                                    'Save',
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Text(
                                    'Update',
                                    style: TextStyle(color: Colors.white),
                                  ),
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.blue),
                        ),
                        onPressed: () {
                          if (widget.type == "0") {
                            _submit(companynamecontroller.text, companyaddresscontroller.text);
                          } else {
                            update(companynamecontroller.text, companyaddresscontroller.text);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit(String companyname, String address) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      isloading = true;
    });
    SharedPreferences logindata = await SharedPreferences.getInstance();
    String? userid = logindata.getString("userId");
    log("userid in add compnay===" + userid.toString());

    Map data = {
      'userid': userid,
      'address': address,
      'companyname': companyname,
    };
    final headerss = {
      'Content-Type': 'application/json',
    };
    print(data.toString());
    final response = await http.post(
      Uri.parse(ApiUrl.addcompany),
      headers: headerss,
      body: jsonEncode(data),
    );
    setState(() {
      isloading = false;
    });
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);

      if (resposne['respCode'].toString().contains("200")) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => commerialdashboard()));

        print("Login Successfully Completed !!!!!!!!!!!!!!!!");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Added failed.........'),
          backgroundColor: Colors.green,
        ));
      }
    } else {
      print("Please try again!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
  }

  Future<void> update(String companyname, String address) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      isloading = true;
    });
    SharedPreferences logindata = await SharedPreferences.getInstance();
    String? userid = logindata.getString("userId");

    Map data = {
      'userid': userid,
      'companyid': widget.comapnyid,
      'address': address,
      'companyname': companyname,
    };
    final headerss = {
      'Content-Type': 'application/json',
    };
    print(data.toString());
    final response = await http.post(
      Uri.parse(ApiUrl.editcompany),
      headers: headerss,
      body: jsonEncode(data),
    );
    setState(() {
      isloading = false;
    });
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);

      if (resposne['respCode'].toString().contains("200")) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => commerialdashboard()));

        print("Login Successfully Completed !!!!!!!!!!!!!!!!");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Added failed.........'),
          backgroundColor: Colors.green,
        ));
      }
    } else {
      print("Please try again!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
  }
}
