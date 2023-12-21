// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_interpolation_to_compose_strings, avoid_print, use_build_context_synchronously, use_super_parameters

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Const/Const.dart';
import '../model/TendentModel.dart';
import 'EditMergeProperty.dart';
import 'ViewMergeDetails.dart';

class MergeProperty extends StatefulWidget {
  const MergeProperty({Key? key}) : super(key: key);

  @override
  State<MergeProperty> createState() => _TenantsTabState();
}

class _TenantsTabState extends State<MergeProperty> {
  bool isLoading = false;
  bool isTenantsTheir = false;

  String selectedOption = '';
  String landlordId = '';
  String selectedSubproperty = '';
  String selectedCode = '';
  List<TendentModel> tandent = [];
  String selectedPropertyId = '';
  String selectedSubProptyId = '';

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedPropertyId = prefs.getString('selectedPropertyId') ?? '';
      selectedSubProptyId = prefs.getString('selectedSubProptyId') ?? '';
      loadTenants(selectedPropertyId, selectedSubProptyId);
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    tandent.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () {
        //     Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (context) => AddTendent(),
        //       ),
        //     );
        //   },
        //   label: Text('Add Tenant'),
        //   icon: Icon(Icons.add),
        //   backgroundColor: Colors.blue,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20.0),
        //   ),
        // ),
        appBar: AppBar(
          title: Text("Merge property"),
          backgroundColor: Colors.black26,
        ),
        body: Column(
          children: [
            // Other widgets
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: Color(0xff54854C),
                  ))
                : Visibility(
                    visible: isTenantsTheir,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: tandent.length,
                      itemBuilder: (context, index) {
                        final tenant = tandent[index];
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Text(
                                    tenant.tenantName,
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 50),
                                  Text(
                                    tenant.phone,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditMergeProperty(data: tenant)));
                                          // Delete logic
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                      Text('Edit'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          // Delete logic
                                          showAlertDialogdelete(context, tenant.id);
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                      Text('Delete'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => viewmergedetails(data: tenant)));
                                        },
                                        icon: Icon(Icons.details),
                                      ),
                                      Text('Details'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    replacement: Padding(
                      padding: const EdgeInsets.only(top: 250, left: 30),
                      child: Center(
                        child: Text(
                          'No tenants found',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ));
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
              title: Text("Confirmation"),
              content: Text(contentText),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    final Map<String, dynamic> requestBody = {
                      "tenantid": expid,
                    };

                    final response = await http.post(
                      Uri.parse(ApiUrl.deletetenant),
                      body: jsonEncode(requestBody),
                      headers: {
                        'Content-Type': 'application/json', // Set the content type header
                      },
                    );
                    print("expesss--" + response.body);
                    setState(() {
                      isLoading = false; // Set loading state to false after the data is loaded
                    });
                    if (response.statusCode == 200) {
                      loadTenants(selectedPropertyId, selectedSubProptyId);
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

  Future<void> loadTenants(String propertyCode, String subProperty) async {
    print(propertyCode);
    print(subProperty);
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(ApiUrl.getTendentByIds);
    final Map<String, dynamic> requestData = {"propertyId": propertyCode, "subPropertyId": subProperty};

    final headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(url, headers: headers, body: jsonEncode(requestData));

    final body = response.body;
    print(body);
    final data = jsonDecode(body);
    List<dynamic> dataList = data['data'];

    print("List Dta");
    print(dataList);
    if (dataList.isNotEmpty) {
      tandent = dataList.map((tenantJson) {
        return TendentModel.fromJson(tenantJson);
      }).toList();
      isTenantsTheir = true;
    } else {
      isTenantsTheir = false;
    }
    setState(() {
      isLoading = false; // Set loading state to false after the data is loaded
    });
  }

  // Future<void> deleteTenants(String mobileNumber) async {
  //   setState(() {
  //     dataList.removeWhere((tenant) => tenant['mobile'] == mobileNumber);
  //   });
  //   print(mobileNumber);
  //   final request =
  //   await http.Request('POST', Uri.parse(Api.propertyTenantDelete));
  //   request.body = jsonEncode({"mobile": mobileNumber});
  //   final response = await request.send();
  //
  //   final stream = response.stream;
  //   final body = await stream.bytesToString();
  //
  //   final data = jsonDecode(body);
  //   print(data);
  // }

  void openPhoneDialer(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl((Uri.parse(url)));
    } else {
      throw 'Could not launch $url';
    }
  }
}
