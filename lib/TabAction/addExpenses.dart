import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../landlord/LandloardDashBord.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({Key? key}) : super(key: key);

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
  static String selectedSubProptyId = '';
  static String userId = '';

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedPropertyId = prefs.getString('selectedPropertyId') ?? '';
      selectedSubProptyId = prefs.getString('selectedSubProptyId') ?? '';
      userId = prefs.getString('userId') ?? '';
    });
    print("selectedPropertyId->" + selectedPropertyId);
    print("selectedSubProptyId->" + selectedSubProptyId);
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
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
            ),
            title: Text('Renttas ', style: TextStyle(color: Colors.black)),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                child: Text(
                  'Add a Expense',
                  style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 8),
                child: TextFormField(
                  controller: catagoryController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.category),
                    //  hintText: 'Make Payment?',
                    labelText: 'Category',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 8),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    //  hintText: 'Make Payment?',
                    labelText: 'Name',
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 10, left: 8),
                child: TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.monetization_on),
                    //  hintText: 'Make Payment?',
                    labelText: 'Amount',
                  ),
                ),
              ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Text('ExpensesType'),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     buildTab('One-time'),
              //     // SizedBox(width: 10),
              //     // buildTab('Recurring'),
              //   ],
              // ),
              // SizedBox(height: 20),
              // // Render the appropriate content based on the selected tab
              // selectedTab == 'One-time'
              //     ? renderOneTimeContent()
              //     : renderRecurringContent(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: TextField(
                      controller: _expensesDateControlle,
                      decoration: InputDecoration(
                        labelText: 'Expense Date',
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate(context, _expensesDateControlle);
                      },
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 8),
                child: TextFormField(
                  controller: descController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.description),
                    //  hintText: 'Make Payment?',
                    labelText: 'Description',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 350,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: isLoading ? null : () => saveExpenses(catagoryController.text, nameController.text, amountController.text, _expensesDateControlle.text, descController.text),
                      child: isLoading ? CircularProgressIndicator() : Text('Save')))
            ],
          ),
        ));
  }

  Widget buildTab(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = text;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

  // Widget renderOneTimeContent() {
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(left: 40),
  //         child: TextField(
  //           controller: _expensesDateControlle,
  //           decoration: InputDecoration(
  //             labelText: 'Expense Date',
  //           ),
  //           readOnly: true,
  //           onTap: () {
  //             _selectDate(context, _expensesDateControlle);
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget renderRecurringContent() {
    return Column(
      children: [
        // Widgets for the Recurring tab
        Text('Recurring Content'),
      ],
    );
  }

  Future<void> saveExpenses(String category, String name, String amount, String expenseDate, String description) async {
    print("save exp");
    setState(() {
      isLoading = true;
    });

    final Map<String, dynamic> requestData = {
      "landlordId": userId,
      "propertyId": selectedPropertyId,
      "subPropertyId": selectedSubProptyId,
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
        // Successful response, you can handle it accordingly
        print('Expense data successfully posted.');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Added'),
              content: Text('ExpensesAdded Successfully'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandloardDashBord()));
                  },
                ),
              ],
            );
          },
        );
        print(response.body); // Print the response body
        setState(() {
          isLoading = false; // Set loading state to false after the data is loaded
        });
      } else {
        setState(() {
          isLoading = false; // Set loading state to false after the data is loaded
        });
        print('Failed to post expense data. Status code: ${response.statusCode}');
        print(response.body); // Print the response body
      }
    } catch (error) {
      // Exception occurred during the request
      print('An error occurred: $error');
    }
  }
}
