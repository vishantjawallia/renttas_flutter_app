// ignore_for_file:  sized_box_for_whitespace, prefer_interpolation_to_compose_strings, empty_catches, avoid_print, camel_case_types, must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Common/ApiUrl.dart';
import '../NewLeaseadd.dart';

class LeacePage extends StatefulWidget {
  String id, name, address;
  LeacePage({super.key, required this.id, required this.name, required this.address});

  @override
  State<LeacePage> createState() => _LeacePageState();
}

List<Welcome> leasetlist = [];
List<Floortype> fltp = [];
bool isloaidng = false;

class _LeacePageState extends State<LeacePage> {
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
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Spaces",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewLeaseAdd(
                        companyid: widget.id,
                        name: widget.name,
                        address: widget.address,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add_box_rounded,
                  size: 30,
                ),
                color: Color(0xff54854C),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          isloaidng == true
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xff54854C)),
                )
              : leasetlist.isEmpty
                  ? Flexible(
                      child: Center(
                        heightFactor: 9,
                        child: Container(
                          height: 60,
                          // width: 60,
                          child: const Text("No data found !",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              )),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: leasetlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(25),
                          ),
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            leasetlist[index].spaceuse,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                    const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        leasetlist[index].status,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: 10),
                                      InkWell(
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
                                      const SizedBox(width: 10),
                                      InkWell(
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
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

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
        floortype: List<Floortype>.from(json["floortype"].map((x) => Floortype.fromJson(x))),
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
