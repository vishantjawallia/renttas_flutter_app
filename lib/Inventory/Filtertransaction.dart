import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Transactions.dart';

class filtertransaction extends StatefulWidget {
  const filtertransaction({super.key});

  @override
  State<filtertransaction> createState() => _filtertransactionState();
}

class _filtertransactionState extends State<filtertransaction> {
  String choosedoption = "";
  DateTime dateTime = DateTime.now();
  TextEditingController _textControllerdate1 = new TextEditingController();
  TextEditingController _textControllerdate2 = new TextEditingController();

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
      backgroundColor: Colors.grey[300],
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
                            builder: (context) => const viewtransactions())),
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
                        Text("Filter"),
                        // Text(
                        //   "ab@gmail.com",
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // )
                      ],
                    ),
                  ),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const filtertransaction())),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Reste",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 80,
                  //color: Colors.red,
                  child: Row(
                    children: [
                      Text(
                        ' Product ',
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
                                child: TextField(
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Enter Product name'),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
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
                        'Store ',
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
                                child: TextField(
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Enter Store name'),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
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
                        'Select type ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      "IN",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      "OUT",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ),
                          ],
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
                        'Quick type ',
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
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
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
                              )),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: 15,
                ),
                choosedoption == "Custom date"
                    ?
                Container(
                  height: 80,
                  //color: Colors.red,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Container(
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
                              )),
                        ),
                      ),
                      Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Container(
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
                              )),
                        ),
                      )
                    ],
                  ),
                ):
                SizedBox(
                  height: 20,
                ),

                TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.filter_alt,
                        size: 18,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Apply Filter',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  ),
                  onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const viewtransactions()));},
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
