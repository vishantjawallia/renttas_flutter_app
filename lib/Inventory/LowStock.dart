// ignore_for_file: empty_catches, use_build_context_synchronously, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/widgets/global_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Common/ApiUrl.dart';
import '../Const/Const.dart';
import 'Model/GetLowStockModel.dart';

class LowStock extends StatefulWidget {
  const LowStock({super.key});

  @override
  State<LowStock> createState() => _LowStockState();
}

List<GetLowStock> lowlist = [];
bool isloaidng = false;

class _LowStockState extends State<LowStock> {
  @override
  void initState() {
    super.initState();
    getproduct();
    setState(() {
      isloaidng = true;
    });
  }

  getproduct() async {
    lowlist = await getpr();
    setState(() {});
  }

  Future<List<GetLowStock>> getpr() async {
    try {
      SharedPreferences logindata = await SharedPreferences.getInstance();
      String? userid = logindata.getString("userId");

      if (logindata.getString("storeid") != null) {
        String storeid = logindata.getString("storeid")!;

        if (storeid == "") {
          snack("Please select a store in store view", context);
        } else {
          Map data = {'userid': userid, "storeid": storeid};
          final headerss = {
            'Content-Type': 'application/json',
          };
          final response = await http.post(
            Uri.parse(ApiUrl.getproduct),
            headers: headerss,
            body: jsonEncode(data),
          );

          setState(() {
            isloaidng = false;
          });
          if (response.statusCode == 200) {
            final Map<String, dynamic> jsonData = jsonDecode(response.body);
            List res = jsonData["data"];

            return res.map((e) => GetLowStock.fromJson(e)).toList();
          }
        }
      }
    } catch (e) {}
    return lowlist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        automaticallyImplyLeading: false,
        leading: const BackButton(),
        title: Row(
          children: [
            Text("Low Stocks"),
            const Flexible(fit: FlexFit.tight, child: SizedBox()),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.search,
                size: 25,
              ),
            ),
          ],
        ),
        // ],
      ),
      body: isloaidng == true
          ? const Center(
              child: SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  color: Color(0xff54854C),
                ),
              ),
            )
          : lowlist.isEmpty
              ? GlobalWidgets.notFound('Low stock')
              : ListView.builder(
                  itemCount: lowlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    Container(
                      color: Colors.white,
                      height: 120,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lowlist[index].productname,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  lowlist[index].stockcount,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_circle_up,
                                      color: Colors.orange,
                                    ),
                                    Text(
                                      lowlist[index].outcount,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.orange),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),

                                    const Icon(
                                      Icons.arrow_circle_down,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      lowlist[index].incount,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.green),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    // Icon(
                                    //   Icons.equalizer,
                                    //   color: Colors.grey,
                                    // ),
                                    Text(
                                      "= 1.00",
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                Text(
                                  "Low Stock limit - 2",
                                  style: const TextStyle(color: Colors.blue),
                                )
                              ],
                            ),
                          ),
                          const Flexible(fit: FlexFit.tight, child: SizedBox()),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '1',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                    return null;
                  }),
    );
  }
}
