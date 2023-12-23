// ignore_for_file: sort_child_properties_last, use_build_context_synchronously, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Const/Const.dart';
import '../TabAction/addExpenses.dart';
import '../model/ExpenseModel.dart';

class ExpensesTab extends StatefulWidget {
  const ExpensesTab({Key? key}) : super(key: key);

  @override
  State<ExpensesTab> createState() => _ExpensesTabState();
}

class _ExpensesTabState extends State<ExpensesTab> {
  String selectedPropertyId = '';
  String selectedSubProptyId = '';
  String userId = '';
  String currency = '';

  bool isLoading = false;
  bool isExpensesTheir = false;
  List<dynamic> dataList = [];
  List<ExpenseModel> expenses = [];

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedPropertyId = prefs.getString('selectedPropertyId') ?? '';
      selectedSubProptyId = prefs.getString('selectedSubProptyId') ?? '';
      userId = prefs.getString('userId') ?? '';
      currency = prefs.getString('currency') ?? '';
      loadExpenses(selectedPropertyId, selectedSubProptyId, userId);
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddExpenses()));
          },
          label: const Text(
            'Expense',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          icon: const Icon(Icons.add),
          backgroundColor: const Color(0xff54854C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        body: Column(
          children: [
            // Other widgets
            isLoading
                ? const Flexible(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 60.0),
                        child: CircularProgressIndicator(
                          color: Color(0xff54854C),
                        ),
                      ),
                    ),
                  )
                : Visibility(
                    visible: isExpensesTheir,
                    child: Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: expenses.length,
                        padding: const EdgeInsets.only(top: 20),
                        itemBuilder: (context, index) {
                          final expense = expenses[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            child: Material(
                              borderRadius: BorderRadius.circular(8),
                              elevation: 5,
                              color: Colors.white,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {},
                                child: Container(
                                    padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12, right: 4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        expense.name,
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 0.0, height: 6),
                                                      Text(
                                                        expense.description.toString(),
                                                        // Convert amount to string
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 0.0, height: 8),
                                                      Text(
                                                        "\$ " + expense.amount,
                                                        // Convert amount to string
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () => showAlertDialogdelete(context, expense.id),
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 16.5),
                                              child: Text(
                                                expense.expensesDate.split('T')[0],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          );
                          // return Card(
                          //   elevation: 5,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.stretch,
                          //     children: [
                          //       // SizedBox(height: screenHeight * 0.02),
                          //       Row(
                          //         children: [
                          //           SizedBox(width: screenWidth * 0.02),
                          //           Text(
                          //             expense.expensesDate.split('T')[0],
                          //             style: const TextStyle(
                          //               fontSize: 12,
                          //               fontWeight: FontWeight.bold,
                          //               color: Colors.grey,
                          //             ),
                          //           ),
                          //           // SizedBox(width: screenWidth * 0.03),
                          //           Column(
                          //             children: [
                          //               Text(
                          //                 expense.name,
                          //                 style: const TextStyle(
                          //                   fontSize: 20,
                          //                   fontWeight: FontWeight.bold,
                          //                   color: Colors.grey,
                          //                 ),
                          //               ),
                          //               // const SizedBox(width: 10),
                          //               // Text(
                          //               //   currency,
                          //               //   style: const TextStyle(
                          //               //     fontSize: 16,
                          //               //     fontWeight: FontWeight.bold,
                          //               //     color: Colors.blue,
                          //               //   ),
                          //               // ),
                          //               Text(
                          //                 " " + expense.amount,
                          //                 // Convert amount to string
                          //                 style: const TextStyle(
                          //                   fontSize: 13,
                          //                   fontWeight: FontWeight.bold,
                          //                   color: Colors.red,
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //           // const SizedBox(width: 50),
                          //           IconButton(
                          //             onPressed: () => showAlertDialogdelete(context, expense.id),
                          //             icon: const Icon(
                          //               Icons.delete,
                          //               color: Colors.redAccent,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       Text(
                          //         expense.description.toString(),
                          //         // Convert amount to string
                          //         style: const TextStyle(
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.grey,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // );
                        },
                      ),
                    ),
                    replacement: const Flexible(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 60.0),
                          child: Text(
                            'Expense not found !',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 230, left: 90),
                    //   child: Text(
                    //     'No Expenses found',
                    //     style: TextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.grey,
                    //     ),
                    //   ),
                    // ),
                  ),
          ],
        ));
  }

  Future<void> loadExpenses(String selectedPropertyId, String selectedSubProptyId, String userId) async {
    setState(() {
      isLoading = true;
    });

    // final Map<String, dynamic> requestBody = {
    //   "propertyId": selectedPropertyId,
    //   "subPropertyId": selectedSubProptyId,
    //   "landlordId": userId,
    // };

    final Map<String, dynamic> requestBody = {"landlordId": userId, "propertyId": selectedPropertyId, "subPropertyId": selectedSubProptyId};

    final response = await http.post(
      Uri.parse(ApiUrl.getExpenses),
      body: jsonEncode(requestBody),
      headers: {
        'Content-Type': 'application/json', // Set the content type header
      },
    );
    print("expesss--" + response.body);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      List<dynamic> expensesJsonList = responseData['data'];
      if (expensesJsonList.isNotEmpty) {
        isExpensesTheir = true;
        expenses = expensesJsonList.map((expenseJson) => ExpenseModel.fromJson(expenseJson)).toList();
      } else {
        isExpensesTheir = false;
      }
      if (kDebugMode) {
        print(responseData);
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }

    setState(() {
      isLoading = false; // Set loading state to false after the data is loaded
    });
  }

  showAlertDialogdelete(BuildContext context, String expid) {
    // show the dialog
    showDialog(
      context: context,
      builder: (context) {
        String contentText = "Are you sure want to delete ?";
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Confirmation"),
              content: Text(contentText),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    final Map<String, dynamic> requestBody = {
                      "expenseid": expid,
                    };

                    final response = await http.post(
                      Uri.parse(ApiUrl.deleteExp),
                      body: jsonEncode(requestBody),
                      headers: {
                        'Content-Type': 'application/json', // Set the content type header
                      },
                    );
                    if (kDebugMode) {
                      print("expesss--" + response.body);
                    }
                    setState(() {
                      isLoading = false; // Set loading state to false after the data is loaded
                    });
                    if (response.statusCode == 200) {
                      loadExpenses(selectedPropertyId, selectedSubProptyId, userId);
                      Navigator.pop(context);
                    } else {
                      snack("Something went wrong", context);
                    }
                  },
                  child: Text(isLoading == false ? "Continue" : "Please wait"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> deleteExpenses(String expensesId) async {
    setState(() {
      isLoading = true;
    });

    final request = http.Request('POST', Uri.parse("${ApiUrl.deleteExp}$expensesId"));

    final response = await request.send();
    if (response.statusCode == 200) {
      await loadExpenses(selectedPropertyId, selectedSubProptyId, userId);
    }
  }
}
