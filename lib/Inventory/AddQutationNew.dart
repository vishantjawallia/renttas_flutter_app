// ignore_for_file: unnecessary_new, camel_case_types, avoid_print

import 'package:currency_picker/currency_picker.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:renttas_flutter_app/Inventory/AddBuisness.dart';
import 'package:renttas_flutter_app/Inventory/AddClient.dart';
import 'package:renttas_flutter_app/Inventory/AddItem.dart';

import 'ViewQutation.dart';

class QutationViewNew extends StatefulWidget {
  const QutationViewNew({super.key});

  @override
  State<QutationViewNew> createState() => _QutationViewNewState();
}

class _QutationViewNewState extends State<QutationViewNew> {
  String choosedoption = "";
  bool valuefirst = false;
  bool valuesecond = false;
  DateTime dateTime = DateTime.now();
  String selectedcurrency = "Select Currency";
  final TextEditingController _textControllerdate1 = new TextEditingController();

  _selectDate() async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: dateTime, initialDatePickerMode: DatePickerMode.day, firstDate: DateTime(1850), lastDate: DateTime(2101));
    if (picked != null) {
      dateTime = picked;
      _textControllerdate1.text = DateFormat.yMd().format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    _textControllerdate1.text = "30/10/2023";

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Expanded(
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ViewQutationMain(),
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Add Quotation"),
                    ],
                  ),
                ),
                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                InkWell(
                  onTap: () => {},
                  child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Save",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Details",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      const Divider(),
                      InkWell(
                        child: TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          readOnly: true,
                          onTap: _selectDate,
                          controller: _textControllerdate1,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black), //the controller
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Buisness info *",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      const Divider(),
                      const Text(
                        "From",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddBuisnes())),
                        child: const Text(
                          "Add Buisness",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Center(
                            child: Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.black,
                              value: valuefirst,
                              onChanged: (bool? value) => setState(() => valuefirst = value!),
                            ),
                          ),
                          const Text(
                            'Buisness information show',
                            style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Center(
                            child: Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.black,
                              value: valuesecond,
                              onChanged: (bool? value) => setState(() => valuesecond = value!),
                            ),
                          ),
                          const Text(
                            'Include TAX(%)',
                            style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          const Flexible(fit: FlexFit.tight, child: SizedBox()),
                          valuesecond == true
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 90,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                        child: TextField(
                                          decoration: InputDecoration.collapsed(hintText: 'Enter TAX(%)'),
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Cleint *",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      const Divider(),
                      const Text(
                        "Bill TO ",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddClient())),
                        child: const Text(
                          "Add Cleint ",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sales Person *",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Sales person Name',
                        ),
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black), //the controller
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Items *",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      const Divider(),
                      const Text(
                        "hhh",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      const Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            "Quantity",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                          Flexible(fit: FlexFit.tight, child: SizedBox()),
                          Text(
                            "0",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Price",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                          Flexible(fit: FlexFit.tight, child: SizedBox()),
                          Text(
                            "1.025",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "VAT",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                          Flexible(fit: FlexFit.tight, child: SizedBox()),
                          Text(
                            "0.001",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Amount",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                          Flexible(fit: FlexFit.tight, child: SizedBox()),
                          Text(
                            "0.00",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddItem())),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              size: 22,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Add item ",
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 120,
                // color: Colors.white,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment Details",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      Divider(),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Sub total",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                          Flexible(fit: FlexFit.tight, child: SizedBox()),
                          Text(
                            "0.00",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Total",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                          Flexible(fit: FlexFit.tight, child: SizedBox()),
                          Text(
                            "0.00",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showSearchField: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    favorite: ['eur'],
                    onSelect: (Currency currency) {
                      print('Select currency: ${currency.name}');
                      setState(() {
                        selectedcurrency = currency.name.toString();
                      });
                    },
                  );
                },
                child: Container(
                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      selectedcurrency,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: const Padding(
                  padding: EdgeInsets.only(right: 15, top: 20, left: 10, bottom: 5),
                  child: TextField(
                    decoration: InputDecoration(border: InputBorder.none, hintText: "Payment Method", hintStyle: TextStyle(color: Colors.grey)),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 15, top: 20, left: 10, bottom: 5),
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none, hintText: "Qutation Validity", hintStyle: TextStyle(color: Colors.grey)),
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
