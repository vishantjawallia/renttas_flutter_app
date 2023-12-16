// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_interpolation_to_compose_strings, sort_child_properties_last, sized_box_for_whitespace, avoid_unnecessary_containers, unnecessary_new, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, empty_catches, prefer_final_fields, avoid_init_to_null, non_constant_identifier_names, unnecessary_late, avoid_print, camel_case_types, must_be_immutable

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Common/ApiUrl.dart';
import '../Const/Const.dart';
import 'Dashboard.dart';
import 'Model/GetProductViewModel.dart';
import 'Model/GetStoreModel.dart';
import 'Scanner/Scanner.dart';

class productinout extends StatefulWidget {
  String type;
  productinout({super.key, required this.type});

  @override
  State<productinout> createState() => _productinoutState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();
bool isloading = false;
List<GetProduct> productlist = [];
List<GetStore> storelist = [];

late dynamic dropdownValue = null;
late dynamic dropdownValue2 = null;
String Productid = "", Storeid = "", Rate = "";

class _productinoutState extends State<productinout> {
  DateTime dateTime = DateTime.now();
  String productid = "";
  TextEditingController _textControllerdate1 = new TextEditingController();
  TextEditingController _textControllerrate = new TextEditingController();
  TextEditingController _textControllerqty = new TextEditingController();
  TextEditingController _textControllerremark = new TextEditingController();

  _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1850),
        lastDate: DateTime(2101));
    if (picked != null) {
      dateTime = picked;
      //assign the chosen date to the controller
      _textControllerdate1.text = DateFormat.yMd().format(dateTime);
    }
  }

  Future<void> _submit(String productid, String storeid2, String qty,
      String remark, String date, String rate) async {
    setState(() {
      isloading = true;
    });
    SharedPreferences logindata = await SharedPreferences.getInstance();
    String? userid = logindata.getString("userId");

    if (logindata.getString("storeid") != null) {
      String storeid = logindata.getString("storeid")!;

      if (storeid == "") {
        snack("Please select a store in store view", context);
      } else {
        Map data = {
          'userid': userid,
          'storeid': storeid2,
          'productid': productid,
          "quantity": qty,
          "rate": rate,
          "remark": remark,
          "date": date
        };

        final headerss = {
          'Content-Type': 'application/json',
        };
        print(data.toString());
        final response = await http.post(
          Uri.parse(widget.type == "0" ? ApiUrl.productout : ApiUrl.productin),
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => inentorydashboard()));

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
    } else {
      snack("Please select a store in store view", context);
    }
  }

  //get produt
  // get store
  @override
  void initState() {
    super.initState();
    getproduct();
    getstores();
    setState(() {
      isloading = true;
    });
  }

  getproduct() async {
    productlist = await getpr();
    setState(() {});
  }

  Future<List<GetProduct>> getpr() async {
    try {
      SharedPreferences logindata = await SharedPreferences.getInstance();
      String? userid = logindata.getString("userId");

      if (logindata.getString("storeid") != null) {
        String storeid = logindata.getString("storeid")!;

        if (storeid == "") {
          snack("Please select a store in store view", context);
        } else {
          Map data = {'userid': userid, "storeid": storeid};
          final headerss = {
            'Content-Type': 'application/json',
          };
          final response = await http.post(
            Uri.parse(ApiUrl.getproduct),
            headers: headerss,
            body: jsonEncode(data),
          );

          setState(() {
            isloading = false;
          });
          if (response.statusCode == 200) {
            final Map<String, dynamic> jsonData = jsonDecode(response.body);
            List res = jsonData["data"];

            return res.map((e) => GetProduct.fromJson(e)).toList();
          }
        }
      }
    } catch (e) {}
    return productlist;
  }

  getstores() async {
    storelist = await gestt();
    setState(() {});
  }

  Future<List<GetStore>> gestt() async {
    try {
      SharedPreferences logindata = await SharedPreferences.getInstance();
      String? userid = logindata.getString("userId");
      log("userid in add compnay===" + userid.toString());

      if (logindata.getString("storeid") != null) {
        String storeid = logindata.getString("storeid")!;

        if (storeid == "") {
          snack("Please select a store in store view", context);
        } else {
          Map data = {
            'userid': userid,
          };
          final headerss = {
            'Content-Type': 'application/json',
          };
          final response = await http.post(
            Uri.parse(ApiUrl.getstore),
            headers: headerss,
            body: jsonEncode(data),
          );

          setState(() {
            isloading = false;
          });
          if (response.statusCode == 200) {
            final Map<String, dynamic> jsonData = jsonDecode(response.body);
            List res = jsonData["data"];

            return res.map((e) => GetStore.fromJson(e)).toList();
          }
        }
      }
    } catch (e) {}
    return storelist;
  }

  @override
  Widget build(BuildContext context) {
    _textControllerdate1.text = "10/01/2023";

    var _formKey = GlobalKey<FormState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //  color: grey[300],
        //   ),
        // ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Container(
            child: Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const inentorydashboard())),
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("New Transaction"),
                        // Text(
                        //   "ab@gmail.com",
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // )
                      ],
                    ),
                  ),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  ProductScanner()));

                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)),
                          //alignment: Alignment.center,
                          child: Icon(
                            Icons.qr_code_scanner_outlined,
                            size: 20,
                          )
                          // Text(
                          //   'Premium',
                          //   style: TextStyle(
                          //     fontSize: 18,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          //   textAlign: TextAlign.center,
                          // ),
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      child:
                      isloading==true?CircularProgressIndicator():
                      Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.blue),
                      ),
                      onPressed: () {
                        final isValid = _formKey.currentState!.validate();
                        if (!isValid) {
                          return;
                        }
                        _formKey.currentState!.save();

                        if (Storeid == "" && Productid == "") {
                          snack("Select Store and product", context);
                        } else {
                          _submit(
                              Productid,
                              Storeid,
                              _textControllerqty.text,
                              _textControllerremark.text,
                              _textControllerdate1.text,
                              _textControllerrate.text);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: 80,
                    //color: Colors.red,
                    child: Row(
                      children: [
                        Text(
                          ' Date ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
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
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    child: TextFormField(
                                      readOnly: true, //this is important
                                      onTap:
                                          _selectDate, //the method for opening data picker
                                      controller: _textControllerdate1,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      decoration: new InputDecoration.collapsed(
                                          hintText: _textControllerdate1.text),
                                    ),
                                    //     TextFormField(
                                    //     //  "26/10/2023",
                                    // decration:      InputDecoration(
                                    //         border: InputBorder.none,
                                    //         hintText: 'Username',
                                    //       ),
                                    //       style: TextStyle(
                                    //           fontSize: 15,
                                    //           color: Colors.black,
                                    //           fontWeight: FontWeight.bold),
                                    //     ),
                                  ),
                                  Flexible(
                                      fit: FlexFit.tight, child: SizedBox()),
                                  InkWell(
                                      onTap: _selectDate,
                                      child: Icon(Icons.calendar_month))
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 80,
                    //color: Colors.red,
                    child: Row(
                      children: [
                        Text(
                          ' Product * ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 180,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: isloading == true
                                ? Center(
                                    child: const CircularProgressIndicator())
                                : productlist.isEmpty
                                    ? Center(child: Text("No Product"))
                                    : Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              18), // <= No more error here :)
                                          color: Colors.white,
                                        ),
                                        width: 200,
                                        height: 60,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              // Icon(Icons.bloodtype),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child:
                                                    DropdownButton<GetProduct>(
                                                  hint: const Text(
                                                      "Select Product"),
                                                  underline: SizedBox(),
                                                  value: dropdownValue,
                                                  icon: const Icon(
                                                      Icons.arrow_drop_down),
                                                  iconSize: 24,
                                                  elevation: 16,
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                  // underline: Container(
                                                  //  height: 2,
                                                  //  color: Colors.deepPurpleAccent,
                                                  // ),
                                                  onChanged:
                                                      (GetProduct? data) {
                                                    setState(() {
                                                      dropdownValue = data!;

                                                      Productid = data.id;

                                                      //                              Dis = data.name;
                                                      //                           d_id=   int.parse(data.id);

                                                      // print(dropdownValue.name +
                                                      //     " " +
                                                      //     dropdownValue.id.toString());
                                                      // log("id : ${dropdownValue.id}");
                                                      // FplaceValue = null;
                                                      // TplaceValue = null;

                                                      // getPlaces();
                                                    });
                                                  },
                                                  items: productlist.map<
                                                          DropdownMenuItem<
                                                              GetProduct>>(
                                                      (GetProduct value) {
                                                    return DropdownMenuItem<
                                                        GetProduct>(
                                                      value: value,
                                                      child: Text(
                                                          value.productname),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                            // Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Center(
                            //       child: TextFormField(
                            //         decoration: new InputDecoration.collapsed(
                            //             hintText: 'Enter Product name'),
                            //         style: TextStyle(
                            //             fontSize: 14,
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.bold),
                            //         validator: (value) {
                            //           if (value!.isEmpty) {
                            //             return 'Please enter product name!';
                            //           }
                            //           return null;
                            //         },
                            //       ),
                            //     )),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 80,
                    //color: Colors.red,
                    child: Row(
                      children: [
                        Text(
                          ' Store * ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 180,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: storelist.isEmpty
                                ? Center(
                                    child: const CircularProgressIndicator())
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          18), // <= No more error here :)
                                      color: Colors.white,
                                    ),
                                    width: 200,
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          //Icon(Icons.bloodtype),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: DropdownButton<GetStore>(
                                              hint: const Text("Select Store"),
                                              underline: SizedBox(),
                                              value: dropdownValue2,
                                              icon: const Icon(
                                                  Icons.arrow_drop_down),
                                              iconSize: 24,
                                              elevation: 16,
                                              borderRadius: BorderRadius.zero,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                              // underline: Container(
                                              //  height: 2,
                                              //  color: Colors.deepPurpleAccent,
                                              // ),
                                              onChanged: (GetStore? data) {
                                                setState(() {
                                                  dropdownValue2 = data!;

                                                  Storeid = data.id;

                                                  //                              Dis = data.name;
                                                  //                           d_id=   int.parse(data.id);

                                                  // print(dropdownValue.name +
                                                  //     " " +
                                                  //     dropdownValue.id.toString());
                                                  // log("id : ${dropdownValue.id}");
                                                  // FplaceValue = null;
                                                  // TplaceValue = null;

                                                  // getPlaces();
                                                });
                                              },
                                              items: storelist.map<
                                                      DropdownMenuItem<
                                                          GetStore>>(
                                                  (GetStore value) {
                                                return DropdownMenuItem<
                                                    GetStore>(
                                                  value: value,
                                                  child: Text(value.storename),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            // Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Center(
                            //       child: TextFormField(
                            //         decoration: new InputDecoration.collapsed(
                            //             hintText: 'Enter Store name'),
                            //         style: TextStyle(
                            //             fontSize: 14,
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.bold),
                            //         validator: (value) {
                            //           if (value!.isEmpty) {
                            //             return 'Please enter store name!';
                            //           }
                            //           return null;
                            //         },
                            //       ),
                            //     )),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 80,
                    //color: Colors.red,
                    child: Row(
                      children: [
                        Text(
                          ' Quantity * ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
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
                                    controller: _textControllerqty,
                                    decoration: new InputDecoration.collapsed(
                                        hintText: 'Enter Quantity'),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter product qty!';
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
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 80,
                    //color: Colors.red,
                    child: Row(
                      children: [
                        Text(
                          ' Rate  ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
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
                                    controller: _textControllerrate,
                                    decoration: new InputDecoration.collapsed(
                                        hintText: 'Enter Price'),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter price!';
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
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 80,
                    //color: Colors.red,
                    child: Row(
                      children: [
                        Text(
                          ' Remark  ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
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
                                    controller: _textControllerremark,
                                    decoration: new InputDecoration.collapsed(
                                        hintText: 'Enter Remark'),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter remark!';
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
                  SizedBox(
                    height: 15,
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
