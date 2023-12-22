// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:renttas_flutter_app/TabAction/AddTendent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/TendentModel.dart';

class TenantsTab extends StatefulWidget {
  const TenantsTab({Key? key}) : super(key: key);

  @override
  State<TenantsTab> createState() => _TenantsTabState();
}

class _TenantsTabState extends State<TenantsTab> {
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddTendent(),
              ),
            );
          },
          label: Text(
            'Tenant',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          icon: Icon(Icons.add),
          backgroundColor: Color(0xff54854C),
          // backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        body: Column(
          children: [
            // Other widgets
            isLoading
                ? Flexible(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 60.0),
                        child: CircularProgressIndicator(
                          color: Color(0xff54854C),
                        ),
                      ),
                    ),
                  )
                : Visibility(
                    visible: isTenantsTheir,
                    child: Flexible(
                      fit: FlexFit.loose,
                      child: ListView.builder(
                        shrinkWrap: false,
                        itemCount: tandent.length,
                        padding: EdgeInsets.only(top: 4),
                        itemBuilder: (context, index) {
                          final tenant = tandent[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        // SizedBox(width: 10),
                                        Text(
                                          tenant.tenantName,
                                          style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade900,
                                          ),
                                        ),
                                        SizedBox(width: 50),
                                        Text(
                                          tenant.phone,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      height: 30,
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.only(bottom: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            style: ButtonStyle(
                                              maximumSize: MaterialStateProperty.all(Size(150, 40)),
                                              iconColor: MaterialStateProperty.all(Colors.white),
                                              foregroundColor: MaterialStateProperty.all(Colors.white),
                                              backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                                            ),
                                            onPressed: () {},
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: const [
                                                Icon(Icons.delete),
                                                SizedBox(width: 6, height: 0.0),
                                                Text(
                                                  'REMOVE',
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // SizedBox(width: 14),
                                          TextButton(
                                            style: ButtonStyle(
                                              maximumSize: MaterialStateProperty.all(Size(150, 40)),
                                              iconColor: MaterialStateProperty.all(Colors.white),
                                              foregroundColor: MaterialStateProperty.all(Colors.white),
                                              backgroundColor: MaterialStateProperty.all(Colors.green),
                                            ),
                                            onPressed: () => openPhoneDialer(tenant.phone),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: const [
                                                Icon(Icons.phone),
                                                SizedBox(width: 6, height: 0.0),
                                                Text(
                                                  'CALL',
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Container(
                                          //   padding: EdgeInsets.,
                                          //   color: Colors.redAccent,
                                          //   child: Row(
                                          //     children: [
                                          //       Icon(Icons.delete),
                                          //       SizedBox(width: 8, height: 0.0),
                                          //       Text('Remove'),
                                          //     ],
                                          //   ),
                                          // ),
                                          // SizedBox(
                                          //   width: 40,
                                          // ),
                                          // IconButton(
                                          //   onPressed: () {
                                          //     openPhoneDialer(tenant.phone);
                                          //   },
                                          //   icon: Icon(Icons.phone),
                                          // ),
                                          // Text('Call'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    replacement: Flexible(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 60.0),
                          child: Text(
                            'Tenants not found !',
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
                    //   padding: const EdgeInsets.only(top: 250, left: 30),
                    //   child: Center(
                    //     child: Text(
                    //       'No tenants found',
                    //       style: TextStyle(
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  )
          ],
        ));
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
