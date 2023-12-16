// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, empty_catches, avoid_print, camel_case_types, must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Common/ApiUrl.dart';
import '../NewLeaseadd.dart';

class leacepage extends StatefulWidget {
  String id, name, address;
  leacepage(
      {super.key, required this.id, required this.name, required this.address});

  @override
  State<leacepage> createState() => _leacepageState();
}

List<Welcome> leasetlist = [];
List<Floortype> fltp = [];
bool isloaidng = false;

class _leacepageState extends State<leacepage> {
  @override
  void initState() {
    super.initState();
    getproduct();
    setState(() {
      isloaidng = true;
    });
  }

  getproduct() async {
    leasetlist = await getpr();
    setState(() {});
  }

  Future<List<Welcome>> getpr() async {
    print("ssss");
    try {
      SharedPreferences logindata = await SharedPreferences.getInstance();
      String? userid = logindata.getString("userId");

      Map data = {'userid': userid, "companyid": widget.id, "categoryid": "1"};
      final headerss = {
        'Content-Type': 'application/json',
      };
      final response = await http.post(
        Uri.parse(ApiUrl.getlease),
        headers: headerss,
        body: jsonEncode(data),
      );

      setState(() {
        isloaidng = false;
      });

      print("res===" + response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        List res = jsonData["data"];

        return res.map((e) => Welcome.fromJson(e)).toList();
      }
    } catch (e) {}
    return leasetlist;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Spaces"),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => newleaseadd(
                                companyid: widget.id,
                                name: widget.name,
                                address: widget.address,
                              )));
                },
                icon: const Icon(
                  Icons.add_box_rounded,
                ),
                color: Colors.blue,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          isloaidng == true
              ? Center(
                  child: Container(
                      height: 60,
                      width: 60,
                      child: const CircularProgressIndicator()))
              : leasetlist.isEmpty
                  ? Center(
                      child: Container(
                          height: 60, width: 60, child: Text("No data")))
                  : ListView.builder(
                      itemCount: leasetlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(25)),
                          //    color: Colors.white,
                          height: 120,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            leasetlist[index].spaceuse,
                                            //  "Partiton 1",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                        fit: FlexFit.tight, child: SizedBox()),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        leasetlist[index].status,
                                        //  "Withheld",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    //  Flexible(fit: FlexFit.tight, child: SizedBox()),
                                  ],
                                ),
                                Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        // onTap: () => Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) => const newproductadd())),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Icon(Icons.edit),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        //   onTap: () => showAlertDialog(context),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Icon(Icons.delete_outline),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),

          // Center(child: Text("Leace")),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

//
// [{"Id":"1","userid":"dsdsf","companyid":"dsdsf","categoryid":"lease","spaceuse":"dsdsf","availablespacemin":"dsdsf","availablespacemax":"lease","floortype":"[{'id':'1','name':'aaaa'}]","askingrentmin":"lease","askingrentmax":"lease","status":"lease"}]

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

class Welcome {
  String id;
  String userid;
  String companyid;
  String categoryid;
  String spaceuse;
  String availablespacemin;
  String availablespacemax;
  List<Floortype> floortype;
  String askingrentmin;
  String askingrentmax;
  String status;

  Welcome({
    required this.id,
    required this.userid,
    required this.companyid,
    required this.categoryid,
    required this.spaceuse,
    required this.availablespacemin,
    required this.availablespacemax,
    required this.floortype,
    required this.askingrentmin,
    required this.askingrentmax,
    required this.status,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["Id"],
        userid: json["userid"],
        companyid: json["companyid"],
        categoryid: json["categoryid"],
        spaceuse: json["spaceuse"],
        availablespacemin: json["availablespacemin"],
        availablespacemax: json["availablespacemax"],
        floortype: List<Floortype>.from(
            json["floortype"].map((x) => Floortype.fromJson(x))),
        askingrentmin: json["askingrentmin"],
        askingrentmax: json["askingrentmax"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "userid": userid,
        "companyid": companyid,
        "categoryid": categoryid,
        "spaceuse": spaceuse,
        "availablespacemin": availablespacemin,
        "availablespacemax": availablespacemax,
        "floortype": List<dynamic>.from(floortype.map((x) => x.toJson())),
        "askingrentmin": askingrentmin,
        "askingrentmax": askingrentmax,
        "status": status,
      };
}

class Floortype {
  String id;
  String name;

  Floortype({
    required this.id,
    required this.name,
  });

  factory Floortype.fromJson(Map<String, dynamic> json) => Floortype(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
