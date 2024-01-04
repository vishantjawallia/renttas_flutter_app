// ignore_for_file: unnecessary_new, camel_case_types, avoid_print, unused_import

import 'package:currency_picker/currency_picker.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:renttas_flutter_app/Inventory/AddBuisness.dart';
import 'package:renttas_flutter_app/Inventory/AddClient.dart';
import 'package:renttas_flutter_app/Inventory/AddItem.dart';

import 'Filtertransaction.dart';
import 'ViewQutation.dart';

class QutationView extends StatefulWidget {
  const QutationView({super.key});

  @override
  State<QutationView> createState() => _QutationViewState();
}

class _QutationViewState extends State<QutationView> {
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
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        leading: const BackButton(),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text("Add Quotation"),
            const Flexible(fit: FlexFit.tight, child: SizedBox()),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FilterTransaction(),
                ),
              ),
              child: Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                child: const Center(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Save",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff54854C)),
                      )),
                ),
              ),
            ),
            const SizedBox(width: 10, height: 0.0),
          ],
        ),
        // ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Padding(
          padding: const EdgeInsets.all(8),
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
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const Divider(),
                      TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        readOnly: true,
                        onTap: _selectDate,
                        controller: _textControllerdate1,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
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
                        "Buisness info *",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const Divider(),
                      const Text(
                        "From",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddBuisnes())),
                        child: const Text(
                          "Add Buisness",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
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
                            style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
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
                            style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const Flexible(fit: FlexFit.tight, child: SizedBox()),
                          valuesecond == true
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 120,
                                    height: 50,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const TextField(
                                      decoration: InputDecoration.collapsed(hintText: 'Enter TAX (%)'),
                                      style: TextStyle(fontSize: 13, color: Colors.black),
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
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const Divider(),
                      const SizedBox(height: 4),
                      const Text(
                        "Bill TO ",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(height: 6),
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddClient())),
                        child: const Text(
                          "Add Cleint ",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
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
                        "Sales Person *",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const Divider(),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 50,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Sales person Name',
                            ),
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black), //the controller
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                // height: 250,
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
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const Divider(),
                      const Text(
                        "hhh",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Quantity",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                          ),
                          Flexible(fit: FlexFit.tight, child: SizedBox()),
                          Text(
                            "0",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
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
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                          ),
                          Flexible(fit: FlexFit.tight, child: SizedBox()),
                          Text(
                            "1.025",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
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
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                          ),
                          Flexible(fit: FlexFit.tight, child: SizedBox()),
                          Text(
                            "0.001",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
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
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
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
                        child: Center(
                          child: Container(
                            width: 150,
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xff54854C),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_circle_outline,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Add item",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
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
                        "Payment Details",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Divider(),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Sub total",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                          ),
                          Flexible(fit: FlexFit.tight, child: SizedBox()),
                          Text(
                            "0.00",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            "Total",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                          ),
                          Flexible(fit: FlexFit.tight, child: SizedBox()),
                          Text(
                            "0.00",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
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
                    onSelect: (Currency currency) => setState(() => selectedcurrency = currency.name.toString()),
                  );
                },
                child: Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      selectedcurrency,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: 'Select Currency' == selectedcurrency ? Colors.black54 : Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: const Padding(
                  padding: EdgeInsets.only(right: 15, top: 5, left: 15, bottom: 5),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Payment Method",
                      hintStyle: TextStyle(color: Colors.black54),
                    ),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 15, top: 4, left: 15, bottom: 5),
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none, hintText: "Qutation Validity", hintStyle: TextStyle(color: Colors.black54)),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
