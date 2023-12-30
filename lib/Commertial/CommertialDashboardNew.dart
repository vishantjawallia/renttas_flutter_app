// ignore_for_file: sort_child_properties_last, prefer_interpolation_to_compose_strings, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:renttas_flutter_app/widgets/global_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Common/ApiUrl.dart';
import 'AddNewCompany.dart';
import 'AddNewCompanyNew.dart';
import 'Model/GetCompanyModel.dart';
import 'ViewCompanyDetails.dart';

class CommerialDashboardNew extends StatefulWidget {
  final String? name;
  const CommerialDashboardNew({
    required this.name,
    super.key,
  });

  @override
  State<CommerialDashboardNew> createState() => _CommerialDashboardNewState();
}

List<GetCompany> companylist = [];
bool isloaidng = false;

class _CommerialDashboardNewState extends State<CommerialDashboardNew> {
  @override
  void initState() {
    super.initState();
    getcompanyfunct();
  }

  getcompanyfunct() async {
    companylist = await getcompany();
    setState(() {});
  }

  Future<List<GetCompany>> getcompany() async {
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
        Uri.parse(ApiUrl.getcompany),
        headers: headerss,
        body: jsonEncode(data),
      );

      setState(() {
        isloaidng = false;
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        List res = jsonData["data"];

        return res.map((e) => GetCompany.fromJson(e)).toList();
      }
    } catch (e) {}
    return companylist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        leading: const BackButton(),
        title: Text(
          widget.name ?? "Heloo",
          style: const TextStyle(color: Colors.white),
        ),
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
          : companylist.isEmpty
              ? GlobalWidgets.notFound('${widget.name}')
              : ListView.builder(
                  itemCount: companylist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => Navigator.push(
                          context, MaterialPageRoute(builder: (context) => ViewCompanyDetails(id: companylist[index].id, name: companylist[index].companyname, address: companylist[index].address))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                          //    color: Colors.white,
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        companylist[index].companyname,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        companylist[index].address,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => addnewcompany(
                                                    type: "1",
                                                    comapnyid: companylist[index].id,
                                                  ))),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Icon(Icons.edit),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () => showAlertDialog(context, companylist[index].id),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Icon(Icons.delete_outline),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xff54854C),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddNewCompanyNew(
              name: widget.name!,
              type: "0",
              comapnyid: "0",
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String companyid) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () => deletecompany(companyid),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirmation"),
      content: const Text("Are you sure want to delete ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> deletecompany(String companyid) async {
    setState(() => isloaidng = true);
    SharedPreferences logindata = await SharedPreferences.getInstance();
    String? userid = logindata.getString("userId");
    log("userid in add compnay===" + userid.toString());
    Map data = {
      'userid': userid,
      'companyid': companyid,
    };
    final headerss = {
      'Content-Type': 'application/json',
    };
    print(data.toString());
    final response = await http.post(
      Uri.parse(ApiUrl.deletecompany),
      headers: headerss,
      body: jsonEncode(data),
    );
    setState(() => isloaidng = false);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);

      if (resposne['respCode'].toString().contains("200")) {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const commerialdashboardnew()));

        print("Login Successfully Completed !!!!!!!!!!!!!!!!");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Deletion failed.........'),
          backgroundColor: Colors.green,
        ));
      }
    } else {
      print("Please try again!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
  }
}
