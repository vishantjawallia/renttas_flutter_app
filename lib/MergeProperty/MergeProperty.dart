// ignore_for_file:  sort_child_properties_last, prefer_interpolation_to_compose_strings, avoid_print, use_build_context_synchronously, use_super_parameters

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Const/Const.dart';
import '../TabAction/AddTendent.dart';
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
  String selectedSubPropertyId = '';

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedPropertyId = prefs.getString('selectedPropertyId') ?? '';
      selectedSubPropertyId = prefs.getString('selectedSubPropertyId') ?? '';
      loadTenants(selectedPropertyId, selectedSubPropertyId);
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
      floatingActionButton: isLoading
          ? const SizedBox()
          : FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddTendent(),
                  ),
                );
              },
              label: Text(
                'Tenant',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              icon: const Icon(Icons.add, color: Colors.white),
              backgroundColor: const Color(0xff54854C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        title: Text("Merge property"),
      ),
      body: Column(
        children: [
          isLoading
              ? const Flexible(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff54854C),
                    ),
                  ),
                )
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
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                Text(
                                  tenant.tenantName,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 50),
                                Text(
                                  tenant.phone,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
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
                                      icon: const Icon(Icons.edit),
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
                                      icon: const Icon(Icons.delete),
                                    ),
                                    Text('Delete'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ViewMergeDetails(data: tenant),
                                        ),
                                      ),
                                      icon: const Icon(Icons.details),
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
                  replacement: Flexible(
                    child: Center(
                      child: Text(
                        'Tenants not found !',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
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
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    setState(() => isLoading = true);

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
                    setState(() => isLoading = false);
                    if (response.statusCode == 200) {
                      loadTenants(selectedPropertyId, selectedSubPropertyId);
                      Navigator.pop(context);
                    } else {
                      snack("Something went wrong", context);
                    }
                  },
                  child: Text(
                    isLoading == false ? "Continue" : "Please wait",
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> loadTenants(
    String propertyCode,
    String subProperty,
  ) async {
    print(propertyCode);
    print(subProperty);
    setState(() => isLoading = true);
    final url = Uri.parse(ApiUrl.getTendentByIds);
    final Map<String, dynamic> requestData = {
      "propertyId": propertyCode,
      "subPropertyId": subProperty,
    };

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
    setState(() => isLoading = false);
  }

  void openPhoneDialer(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl((Uri.parse(url)));
    } else {
      throw 'Could not launch $url';
    }
  }
}
