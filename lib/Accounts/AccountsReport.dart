// ignore_for_file: unnecessary_new, prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, avoid_unnecessary_containers, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class accountsreport extends StatefulWidget {
  String userid;
  accountsreport({super.key, required this.userid});

  @override
  State<accountsreport> createState() => _accountsreportState();
}

class _accountsreportState extends State<accountsreport> {
  DateTime dateTime = DateTime.now();
  TextEditingController _textControllerdate1 = new TextEditingController();
  TextEditingController _textControllerdate2 = new TextEditingController();
  String choosedoption = "";

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

  _selectDate2() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1850),
        lastDate: DateTime(2101));
    if (picked != null) {
      dateTime = picked;
      //assign the chosen date to the controller
      _textControllerdate2.text = DateFormat.yMd().format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    _textControllerdate1.text = "From";
    _textControllerdate2.text = "To";
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
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
        // leading: IconButton(
        //   onPressed: () {
        //     // Navigator.push(context,
        //     //     MaterialPageRoute(builder: (context) => LandloardDashBord()));
        //   },
        //   icon: Icon(Icons.arrow_back),
        //   color: Colors.black,
        // ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () {
                print("Icon 1 pressed");
              }),
        ],
        title: Text('Accounts ', style: TextStyle(color: Colors.white)),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Property/Unit", style: TextStyle(color: Colors.grey)),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.home),
                  ),
                  hint: Text('All Properties'),
                  items: <String>['A', 'B', 'C', 'D'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Select Period", style: TextStyle(color: Colors.grey)),
                DropdownButtonFormField<String>(
                  // decoration: InputDecoration(
                  //   prefixIcon: Icon(Icons.home),
                  // ),
                  hint: Text('Select Period'),
                  items: <String>[
                    'This month',
                    'Last month',
                    'Custom date',
                    '2023'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (v) {
                    setState(() {
                      choosedoption = v.toString();
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                choosedoption == "Custom date"
                    ? Container(
                        height: 70,
                        color: Colors.grey[50],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 50,
                                width: 80,
                                child: TextFormField(
                                  readOnly: true, //this is important
                                  onTap:
                                      _selectDate, //the method for opening data picker
                                  controller:
                                      _textControllerdate1, //the controller
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 80,
                                child: TextFormField(
                                  readOnly: true, //this is important
                                  onTap:
                                      _selectDate2, //the method for opening data picker
                                  controller:
                                      _textControllerdate2, //the controller
                                ),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.grey)),
                                onPressed: () {},
                                // style: TextButton.styleFrom(
                                //   foregroundColor: Colors.black,
                                // ),
                                child: Text(
                                  'Filter',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 2,
                      ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  color: Colors.lightBlue[100],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total"),
                        Text("Income 0.0"),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  //color: Colors.lightBlue[100],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Revenue",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Total rent collected",
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Text("0.00")
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  //color: Colors.lightBlue[100],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Expenses",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Total expenses paid",
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Text("0.00")
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.lightBlue[100],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Revenue detailed"), Text("Total 0.0")],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "No Payments",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500),
                      )),
                ),
                Container(
                  height: 50,
                  color: Colors.lightBlue[100],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Expenses detailed"), Text("Total 0.0")],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "No Expenses",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
