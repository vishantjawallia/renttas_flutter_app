// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_interpolation_to_compose_strings, prefer_final_fields

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:renttas_flutter_app/landlord/LanlordProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../landlord/LandloardDashBord.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  TextEditingController catagoryController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController _expensesDateControlle = TextEditingController();

  bool isLoading = false;
  bool isBillTheir = false;
  List<dynamic> dataList = [];
  String selectedTab = 'One-time';
  static String selectedPropertyId = '';
  static String selectedSubPropertyId = '';
  static String userId = '';

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedPropertyId = prefs.getString('selectedPropertyId') ?? '';
      selectedSubPropertyId = prefs.getString('selectedSubPropertyId') ?? '';
      userId = prefs.getString('userId') ?? '';
    });
    print("selectedPropertyId->" + selectedPropertyId);
    print("selectedSubPropertyId->" + selectedSubPropertyId);
    print("userId->" + userId);
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: const BackButton(),
          backgroundColor: const Color(0xff54854C),
          title: Text(
            "expense".tr().capitalizeFirstWord(),
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: [
              Container(
                height: 50,
                margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: Text(
                  "add_expense".tr(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 8),
                child: TextFormField(
                  controller: catagoryController,
                  decoration: InputDecoration(icon: const Icon(Icons.category), labelText: 'category'.tr()),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 8),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.person),
                    labelText: 'name'.tr(),
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 10, left: 8),
                child: TextFormField(
                  controller: amountController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.monetization_on),
                    labelText: 'amount'.tr(),
                  ),
                ),
              ),
              // Row(

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: TextField(
                      controller: _expensesDateControlle,
                      decoration: InputDecoration(
                        labelText: 'expense_date'.tr(),
                      ),
                      readOnly: true,
                      onTap: () => _selectDate(context, _expensesDateControlle),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 8),
                child: TextFormField(
                  controller: descController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.description),
                    labelText: 'description'.tr(),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 350,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
                  ),
                  onPressed: isLoading ? null : () => saveExpenses(catagoryController.text, nameController.text, amountController.text, _expensesDateControlle.text, descController.text),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Color(0xff54854C),
                        )
                      : Text(
                          'save'.tr(),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTab(String text) {
    return GestureDetector(
      onTap: () => setState(() => selectedTab = text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selectedTab == text ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selectedTab == text ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget renderRecurringContent() {
    return const Column(
      children: [
        Text('Recurring Content'),
      ],
    );
  }

  Future<void> saveExpenses(
    String category,
    String name,
    String amount,
    String expenseDate,
    String description,
  ) async {
    print("save exp");
    setState(() {
      isLoading = true;
    });

    final Map<String, dynamic> requestData = {
      "landlordId": userId,
      "propertyId": selectedPropertyId,
      "subPropertyId": selectedSubPropertyId,
      "category": category,
      "name": name,
      "amount": amount,
      "expensesDate": expenseDate,
      "description": description
    };

    try {
      final response = await http.post(
        Uri.parse(ApiUrl.createExpenses),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestData),
      );

      print("addeddd expese res[ppp--" + response.body);

      if (response.statusCode == 200) {
        print('Expense data successfully posted.');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Added'),
              content: const Text('ExpensesAdded Successfully'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LandloardDashBord(),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
        print(response.body); // Print the response body
        setState(() => isLoading = false);
      } else {
        setState(() => isLoading = false);
        print('Failed to post expense data. Status code: ${response.statusCode}');
        print(response.body); // Print the response body
      }
    } catch (error) {
      // Exception occurred during the request
      print('An error occurred: $error');
    }
  }
}
