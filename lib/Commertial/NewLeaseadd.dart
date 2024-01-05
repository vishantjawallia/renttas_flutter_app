// ignore_for_file: camel_case_types, must_be_immutable, unnecessary_this, prefer_interpolation_to_compose_strings, avoid_print, sort_child_properties_last, use_build_context_synchronously, unnecessary_brace_in_string_interps, unnecessary_new, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/Const/Const.dart';
// import 'package:renttas_flutter_app/Const/Const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Common/ApiUrl.dart';
import 'ViewCompanyDetails.dart';

class NewLeaseAdd extends StatefulWidget {
  String companyid, name, address;
  NewLeaseAdd({super.key, required this.companyid, required this.name, required this.address});

  @override
  State<NewLeaseAdd> createState() => _NewLeaseAddState();
}

class _NewLeaseAddState extends State<NewLeaseAdd> {
  int _groupValue1 = -1;
  int _groupValue2 = -1;
  bool valuefirst = false;
  bool valueseco = false;
  bool valuethurd = false;
  bool valuefour = false;
  DateTime dateTime = DateTime.now();
  bool isloading = false;

  String seletedcharges = "", spaceuse = "";
  List<ViewBloodHospitalModel> selectedItems = [];

  TextEditingController _textControllerdate1 = new TextEditingController();
  TextEditingController sqft1controller = new TextEditingController();
  TextEditingController sqft2controller = new TextEditingController();
  TextEditingController askrentmincontroller = new TextEditingController();
  TextEditingController askrentmaxcontroller = new TextEditingController();
  TextEditingController timeperiodcontroller = new TextEditingController();

  _selectDate() async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: dateTime, initialDatePickerMode: DatePickerMode.day, firstDate: DateTime(1850), lastDate: DateTime(2101));
    if (picked != null) {
      dateTime = picked;
      //assign the chosen date to the controller
      _textControllerdate1.text = DateFormat.yMd().format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: false,
        actions: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 10),
                const InkWell(
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
                      Text("Add Leases"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Space use"),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    RadioListTile(
                      value: 0,
                      groupValue: _groupValue1,
                      title: Text("Office"),
                      onChanged: (newValue) {
                        setState(() {
                          spaceuse = "Office";
                          _groupValue1 = newValue as int;
                        });
                      },
                      activeColor: Colors.blue,
                      selected: false,
                    ),
                    RadioListTile(
                      value: 1,
                      groupValue: _groupValue1,
                      title: Text("Indastrial"),
                      onChanged: (newValue) => setState(() {
                        spaceuse = "Indastrial";
                        _groupValue1 = newValue as int;
                      }),
                      activeColor: Colors.blue,
                      selected: false,
                    ),
                    RadioListTile(
                      value: 2,
                      groupValue: _groupValue1,
                      title: Text("building"),
                      onChanged: (newValue) => setState(() {
                        spaceuse = "building";
                        _groupValue1 = newValue as int;
                      }),
                      activeColor: Colors.blue,
                      selected: false,
                    ),
                  ],
                ),
                Text("Available space"),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextFormField(
                              controller: sqft1controller,
                              decoration: const InputDecoration.collapsed(hintText: 'Enter Sqft'),
                              style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Sqft!';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text("to"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextFormField(
                              controller: sqft2controller,
                              decoration: const InputDecoration.collapsed(hintText: 'Enter Sqft'),
                              style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Sqft!';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Container(
                  height: 300,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              children: [
                                Text("Cotiogus in buildig"),
                                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.black,
                                  value: valuefirst,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      valuefirst = value!;
                                      if (value) {
                                        selectedItems.add(ViewBloodHospitalModel(id: "1", name: "Cotiogus in buildig"));
                                      } else {
                                        selectedItems.remove(ViewBloodHospitalModel(id: "1", name: "Cotiogus in buildig"));
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              children: [
                                Text("Cotinogus in floor"),
                                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.black,
                                  value: this.valueseco,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      this.valueseco = value!;
                                      if (value) {
                                        selectedItems.add(ViewBloodHospitalModel(id: "2", name: "Cotinogus in floor"));
                                      } else {
                                        selectedItems.remove(ViewBloodHospitalModel(id: "2", name: "Cotinogus in floor"));
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              children: [
                                Text("in one suit"),
                                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.black,
                                  value: this.valuethurd,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      this.valuethurd = value!;
                                      if (value) {
                                        selectedItems.add(ViewBloodHospitalModel(id: "3", name: "in one suit"));
                                      } else {
                                        selectedItems.remove(ViewBloodHospitalModel(id: "3", name: "in one suit"));
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              children: [
                                Text("Total in buildig"),
                                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.black,
                                  value: this.valuefour,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      this.valuefour = value!;
                                      if (value) {
                                        selectedItems.add(ViewBloodHospitalModel(id: "4", name: "Total in buildig"));
                                      } else {
                                        selectedItems.remove(ViewBloodHospitalModel(id: "4", name: "Total in buildig"));
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text("Asking Rent"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextFormField(
                              controller: askrentmincontroller,
                              decoration: const InputDecoration.collapsed(hintText: 'Min'),
                              style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Min rent!';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text("to"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: TextFormField(
                                controller: askrentmaxcontroller,
                                decoration: const InputDecoration.collapsed(hintText: 'Max'),
                                style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your Max rent!';
                                  }
                                  return null;
                                },
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text("Payment date"),
                const SizedBox(height: 5),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      readOnly: true, //this is important
                      onTap: _selectDate, //the method for opening data picker
                      controller: _textControllerdate1,
                      decoration: const InputDecoration.collapsed(hintText: 'enter payment date'),
                      style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text("Time period"),
                const SizedBox(height: 5),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      controller: timeperiodcontroller,
                      decoration: const InputDecoration.collapsed(hintText: 'enter period'),
                      style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your rent period!';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text("Charges"),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      RadioListTile(
                        value: 0,
                        groupValue: _groupValue2,
                        title: Text("Yearly"),
                        onChanged: (newValue) => setState(() {
                          seletedcharges = "Yearly";
                          print("rrrrr==" + newValue.toString());
                          _groupValue2 = newValue as int;
                        }),
                        activeColor: Colors.blue,
                        selected: false,
                      ),
                      RadioListTile(
                        value: 1,
                        groupValue: _groupValue2,
                        title: Text("Quterly"),
                        onChanged: (newValue) => setState(() {
                          seletedcharges = "Quterly";
                          print("rrrrr==" + newValue.toString());
                          _groupValue2 = newValue as int;
                        }),
                        activeColor: Colors.blue,
                        selected: false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                  height: 50,
                  width: 400,
                  child: Center(
                    child: TextButton(
                      child: isloading == false
                          ? Text(
                              'Save',
                              style: const TextStyle(color: Colors.white),
                            )
                          : const CircularProgressIndicator(
                              color: Color(0xff54854C),
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

                        String spaceused = spaceuse;
                        String availablespacemin = sqft1controller.text;
                        String availablespacemax = sqft2controller.text;
                        String askingrentmin = askrentmincontroller.text;
                        String askingrentmax = askrentmaxcontroller.text;
                        String paymentdate = _textControllerdate1.text;
                        String timeperiod = timeperiodcontroller.text;
                        String charge = seletedcharges;

                        print("spaceused===" + spaceused);

                        print("availablespacemin===" + availablespacemin);
                        print("availablespacemax===" + availablespacemax);
                        print("askingrentmin===" + askingrentmin);
                        print("askingrentmax===" + askingrentmax);
                        print("paymentdate===" + paymentdate);
                        print("timeperiod===" + timeperiod);
                        print("charge===" + charge);

                        _submit(selectedItems, spaceused, availablespacemin, availablespacemax, askingrentmin, askingrentmax, paymentdate, timeperiod, charge);
                      },
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

  Future<void> _submit(List<ViewBloodHospitalModel> selectedItems, String spaceused, String availablespacemin, String availablespacemax, String askingrentmin, String askingrentmax, String paymentdate,
      String timeperiod, String charge) async {
    SharedPreferences logindata = await SharedPreferences.getInstance();
    String? userid = logindata.getString("userId");

    setState(() => isloading = true);
    String jsondata = jsonEncode(selectedItems);
    print('jsondata =${jsondata}');

    Map data = {
      "userid": userid,
      "companyid": widget.companyid,
      "categoryid": "1",
      'spaceuse': spaceused,
      'floortype': jsondata,
      'availablespacemin': availablespacemin,
      'availablespacemax': availablespacemax,
      'askingrentmin': askingrentmin,
      'askingrentmax': askingrentmax,
      'status': "lease",
    };
    final headerss = {
      'Content-Type': 'application/json',
    };
    print(data.toString());
    final response = await http.post(
      Uri.parse(ApiUrl.addlease),
      headers: headerss,
      body: jsonEncode(data),
    );

    print("new lease add" + response.body);
    setState(() => isloading = false);
    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);

      if (resposne['msg'].toString().contains("success")) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewCompanyDetails(
              id: widget.companyid,
              name: widget.name,
              address: widget.address,
            ),
          ),
        );

        print("Login Successfully Completed !!!!!!!!!!!!!!!!");
      } else {
        snack("Something went wrong", context);
      }
    } else {
      print("Please try again!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
  }
}

class ViewBloodHospitalModel {
  ViewBloodHospitalModel({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory ViewBloodHospitalModel.fromJson(Map<String, dynamic> json) => ViewBloodHospitalModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
