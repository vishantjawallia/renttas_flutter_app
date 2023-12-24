// ignore_for_file: sort_child_properties_last, prefer_interpolation_to_compose_strings, use_build_context_synchronously, avoid_print, avoid_unnecessary_containers, empty_catches, unused_local_variable, unnecessary_new, camel_case_types

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Common/ApiUrl.dart';
import 'Dashboard.dart';
import 'Model/GetStoreModel.dart';

class storeview extends StatefulWidget {
  const storeview({super.key});

  @override
  State<storeview> createState() => _storeviewState();
}

TextEditingController storenamecontroller = new TextEditingController();
List<GetStore> storelist = [];
bool isloaidng = false;
bool selectedone = false;
String id = "1";

class _storeviewState extends State<storeview> {
  void handleClick(String value, String id) {
    switch (value) {
      case 'Export':
        break;
      case 'Delete':
        delete(id);
        break;
    }
  }

  Future<void> delete(String id) async {
    setState(() {
      isloaidng = true;
    });
    SharedPreferences logindata = await SharedPreferences.getInstance();
    String? userid = logindata.getString("userId");

    String storeid = logindata.getString("storeid")!;

    if (storeid == id) {
      logindata.setString("storeid", "0");
    }
    log("userid in add compnay===" + userid.toString());

    Map data = {
      'userid': userid,
      'storeid': id,
    };
    final headerss = {
      'Content-Type': 'application/json',
    };
    print(data.toString());
    final response = await http.post(
      Uri.parse(ApiUrl.deletestore),
      headers: headerss,
      body: jsonEncode(data),
    );
    setState(() {
      isloaidng = false;
    });
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);

      if (resposne['respCode'].toString().contains("200")) {
        //  Navigator.pop(context);
        getstores();

        print("Login Successfully Completed !!!!!!!!!!!!!!!!");
      } else {
        print("Please try again!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getstores();
    setState(() {
      isloaidng = true;
    });
  }

  getstores() async {
    storelist = await gestt();
    getshareddata();
    setState(() {});
  }

  Future<void> getshareddata() async {
    SharedPreferences logindata = await SharedPreferences.getInstance();
    String? userid = logindata.getString("userId");
    if (logindata.getString("storeid") != null) {
      setState(() {
        id = logindata.getString("storeid")!;
      });
    } else {}
  }

  void snack(String msg) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: const Color.fromARGB(55, 74, 20, 140),
      content: Text(
        msg,
        style: const TextStyle(color: Colors.black),
      ),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<List<GetStore>> gestt() async {
    try {
      SharedPreferences logindata = await SharedPreferences.getInstance();
      String? userid = logindata.getString("userId");
      log("userid in add compnay===" + userid.toString());

      Map data = {
        'userid': userid,
      };
      final headerss = {
        'Content-Type': 'application/json',
      };
      final response = await http.post(
        Uri.parse(ApiUrl.getstore),
        headers: headerss,
        body: jsonEncode(data),
      );

      setState(() {
        isloaidng = false;
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        List res = jsonData["data"];

        return res.map((e) => GetStore.fromJson(e)).toList();
      }
    } catch (e) {}
    return storelist;
  }

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const inentorydashboard())),
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
                        Text("Stores"),
                        // Text(
                        //   "ab@gmail.com",
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // )
                      ],
                    ),
                  ),
                  const Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
                        //alignment: Alignment.center,
                        child: const Icon(
                          Icons.mobile_screen_share_rounded,
                          size: 20,
                        )
                        // Text(
                        //   'Premium',
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: isloaidng == true
          ? const Center(
              child: SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(
                    color: Color(0xff54854C),
                  )))
          : storelist.isEmpty
              ? const Center(child: SizedBox(height: 60, width: 60, child: Text("No data")))
              : ListView.builder(
                  itemCount: storelist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async {
                        SharedPreferences logindata = await SharedPreferences.getInstance();
                        setState(() {
                          id = storelist[index].id.toString();
                          logindata.setString("storeid", id);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 80,
                          // color: Colors.white,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.grey,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.store,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  storelist[index].storename,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                id == storelist[index].id.toString()
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.black,
                                      )
                                    : const SizedBox(),
                                PopupMenuButton<String>(
                                  onSelected: (value) => handleClick(value, storelist[index].id),
                                  itemBuilder: (BuildContext context) {
                                    return {'Export', 'Delete'}.map((String choice) {
                                      return PopupMenuItem<String>(
                                        value: choice,
                                        child: Text(choice),
                                      );
                                    }).toList();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xff54854C),
        // backgroundColor: Colors.blue,
        onPressed: () {
          _displayTextInputDialog(context);
        },
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              const Text(
                "Add Store",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Flexible(fit: FlexFit.tight, child: SizedBox()),
              InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close_rounded))
            ],
          )
          //Text('TextField in Dialog'),
          ,
          content: SizedBox(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Store Name",
                  style: TextStyle(color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 280,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: TextField(
                            controller: storenamecontroller,
                            decoration: const InputDecoration.collapsed(hintText: 'Enter Product name'),
                            style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
          // TextField(
          //   controller: _textFieldController,
          //   decoration: InputDecoration(hintText: "Text Field fdffin Dialog"),
          // ),
          actions: <Widget>[
            Center(
              child: TextButton(
                  child: const Text('Save'),
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  ),
                  onPressed: () async {
                    setState(() {
                      isloaidng = true;
                    });
                    SharedPreferences logindata = await SharedPreferences.getInstance();
                    String? userid = logindata.getString("userId");
                    log("userid in add compnay===" + userid.toString());

                    Map data = {
                      'userid': userid,
                      'storename': storenamecontroller.text,
                    };
                    final headerss = {
                      'Content-Type': 'application/json',
                    };
                    print(data.toString());
                    final response = await http.post(
                      Uri.parse(ApiUrl.addstore),
                      headers: headerss,
                      body: jsonEncode(data),
                    );
                    setState(() {
                      isloaidng = false;
                    });
                    print(response.body);
                    if (response.statusCode == 200) {
                      Map<String, dynamic> resposne = jsonDecode(response.body);

                      if (resposne['respCode'].toString().contains("200")) {
                        Navigator.pop(context);
                        getstores();

                        print("Login Successfully Completed !!!!!!!!!!!!!!!!");
                      } else {
                        print("Please try again!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                      }
                    }
                  }),
            )
          ],
        );
      },
    );
  }
}
