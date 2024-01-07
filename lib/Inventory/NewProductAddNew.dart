// ignore_for_file: camel_case_types, unnecessary_new,  use_build_context_synchronously, avoid_print, sort_child_properties_last, avoid_unnecessary_containers, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers, unnecessary_this, must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Common/ApiUrl.dart';

import 'ProductViewNew.dart';

class NewProductAddNew extends StatefulWidget {
  String type, id, productname, descr, sku;
  NewProductAddNew({
    super.key,
    required this.type,
    required this.id,
    required this.productname,
    required this.descr,
    required this.sku,
  });

  @override
  State<NewProductAddNew> createState() => _NewProductAddNewState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();
TextEditingController productnamectr = new TextEditingController();
TextEditingController productuniqueid = new TextEditingController();
TextEditingController productdescription = new TextEditingController();
bool isloading = false;

class _NewProductAddNewState extends State<NewProductAddNew> {
  Future<void> _submit(String productname, String productid, String description) async {
    setState(() {
      isloading = true;
    });
    SharedPreferences logindata = await SharedPreferences.getInstance();
    String? userid = logindata.getString("userId");

    if (logindata.getString("storeid") != null) {
      String storeid = logindata.getString("storeid")!;

      if (storeid == "") {
        snack("Please select a store in store view");
      } else {
        Map data = {'userid': userid, 'storeid': storeid, 'productname': productname, "sku": productid, "description": description};
        final headerss = {
          'Content-Type': 'application/json',
        };
        print(data.toString());
        final response = await http.post(
          Uri.parse(ApiUrl.addproduct),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductViewNew()));

            print("Login Successfully Completed !!!!!!!!!!!!!!!!");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Added failed.........'),
              backgroundColor: Colors.green,
            ));
          }
        } else {
          print("Please try again!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        }
      }
    } else {
      snack("Please select a store in store view");
    }
  }

  Future<void> update(String productname, String productid, String description) async {
    setState(() {
      isloading = true;
    });
    SharedPreferences logindata = await SharedPreferences.getInstance();
    String? userid = logindata.getString("userId");

    if (logindata.getString("storeid") != null) {
      String storeid = logindata.getString("storeid")!;

      if (storeid == "") {
        snack("Please select a store in store view");
      } else {
        Map data = {"id": widget.id, 'userid': userid, 'storeid': storeid, 'productname': productname, "sku": productid, "description": description};
        final headerss = {
          'Content-Type': 'application/json',
        };
        print(data.toString());
        final response = await http.post(
          Uri.parse(ApiUrl.editproduct),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductViewNew()));

            print("Login Successfully Completed !!!!!!!!!!!!!!!!");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Added failed.........'),
              backgroundColor: Colors.green,
            ));
          }
        } else {
          print("Please try again!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        }
      }
    } else {
      snack("Please select a store in store view");
    }
  }

  void snack(String msg) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: const Color.fromARGB(55, 74, 20, 140),
      content: Text(
        msg,
        style: const TextStyle(color: Colors.black),
      ),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool valuefirst = false;
  bool valuesecond = false;

  @override
  Widget build(BuildContext context) {
    if (widget.type == "1") {
      productnamectr.text = widget.productname;
      productuniqueid.text = widget.sku;
      productdescription.text = widget.descr;
    }
    var _formKey = GlobalKey<FormState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.type == "1" ? const Text("Edit Product") : const Text("New Product"),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
                    child: const Icon(
                      Icons.qr_code_scanner_outlined,
                      size: 20,
                      color: Color(0xff54854C),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    child: isloading == true
                        ? const CircularProgressIndicator(color: Colors.white)
                        : widget.type == "1"
                            ? const Text(
                                'Update',
                                style: TextStyle(color: Color(0xff54854C), fontWeight: FontWeight.bold),
                              )
                            : const Text(
                                'Save',
                                style: TextStyle(color: Color(0xff54854C), fontWeight: FontWeight.bold),
                              ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(isloading == true ? Colors.transparent : Colors.white),
                    ),
                    onPressed: () {
                      final isValid = _formKey.currentState!.validate();
                      if (!isValid) {
                        return;
                      }
                      _formKey.currentState!.save();

                      if (widget.id == "1") {
                        update(productnamectr.text, productuniqueid.text, productdescription.text);
                      } else {
                        _submit(productnamectr.text, productuniqueid.text, productdescription.text);
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            child: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 80,
                    //color: Colors.red,
                    child: Row(
                      children: [
                        const Text(
                          'Product Name * ',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Flexible(fit: FlexFit.tight, child: SizedBox()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 180,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: TextFormField(
                                    controller: productnamectr,
                                    decoration: const InputDecoration.collapsed(hintText: 'Enter Product name'),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter product name!';
                                      }
                                      return null;
                                    },
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 80,
                    //color: Colors.red,
                    child: Row(
                      children: [
                        const Text(
                          'Product id * \n(unique) ',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Flexible(fit: FlexFit.tight, child: SizedBox()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 180,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: TextFormField(
                                    controller: productuniqueid,
                                    decoration: const InputDecoration.collapsed(hintText: 'Enter Product id'),
                                    style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter product id!';
                                      }
                                      return null;
                                    },
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 80,
                    //color: Colors.red,
                    child: Row(
                      children: [
                        const Text(
                          'Description',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Flexible(fit: FlexFit.tight, child: SizedBox()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 180,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: TextFormField(
                                    controller: productdescription,
                                    decoration: const InputDecoration.collapsed(hintText: 'Enter Product description'),
                                    style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter description!';
                                      }
                                      return null;
                                    },
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(20), color: Colors.grey[300]),
                    height: 70,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        const Text(
                          'Is Low Warning  ',
                          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const Flexible(fit: FlexFit.tight, child: SizedBox()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.black,
                                  value: this.valuefirst,
                                  onChanged: (bool? value) {
                                    setState(() => this.valuefirst = value!);
                                  },
                                ), //Checkbox
                              )),
                        )
                      ],
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
}
