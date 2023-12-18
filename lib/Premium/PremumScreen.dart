// ignore_for_file: camel_case_types, avoid_print, unnecessary_new, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings, non_constant_identifier_names, deprecated_member_use, sized_box_for_whitespace, empty_catches, unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../Common/ApiUrl.dart';
import '../landlord/LandloardDashBord.dart';

class premiumescreen extends StatefulWidget {
  const premiumescreen({super.key});

  @override
  State<premiumescreen> createState() => _premiumescreenState();
}

class _premiumescreenState extends State<premiumescreen> {
  List<GetPrrmiume> premiumelist = [];
  bool isloaidng = false;
  String amou = "", validity = "";

  @override
  void initState() {
    super.initState();
    getprrmiumet();
  }

  void getprrmiumet() async {
    setState(() => isloaidng = true);
    await Future.delayed(Duration(seconds: 2));
    final value = await getpre();
    setState(() {
      isloaidng = false;
      premiumelist = value;
    });
  }

  Future<List<GetPrrmiume>> getpre() async {
    String counrtycode = WidgetsBinding.instance.window.locale.countryCode.toString();
    String aaa = getCurrency();
    print("sssssssasasasa===" + aaa);
    print("ssss");

    try {
      SharedPreferences logindata = await SharedPreferences.getInstance();
      String? userid = logindata.getString("userId");

      Map data = {
        'userid': "1",
        "countrycode": counrtycode,
      };
      final headerss = {
        'Content-Type': 'application/json',
      };
      final response = await http.post(
        Uri.parse(ApiUrl.getpremiume),
        headers: headerss,
        body: jsonEncode(data),
      );

      setState(() => isloaidng = false);
      log(response.body.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        List res = jsonData["data"];

        return res.map((e) => GetPrrmiume.fromJson(e)).toList();
      }
    } catch (e) {}
    return premiumelist;
  }

  String? isSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LandloardDashBord())),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: isloaidng == true
          ? Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: CircularProgressIndicator(),
              ),
            )
          // Center(child: Container(height: 60, width: 60, child: const CircularProgressIndicator()))
          : premiumelist.isEmpty
              ? Center(
                  child: Container(
                    height: 60,
                    // width: 100,
                    child: Text(
                      "No Found !",
                      style: TextStyle(color: Colors.grey, fontSize: 23, fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              const Text(
                                "Get More Features",
                                style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
                              ),
                              const Text(
                                "Current plan : Free Forever",
                                style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                              Center(child: Divider()),
                            ],
                          ),
                        ),
                        GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 1.0,
                          shrinkWrap: true,
                          children: List.generate(
                            premiumelist.length,
                            (index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isSelected = premiumelist[index].Id;
                                        amou = premiumelist[index].amount;
                                        validity = premiumelist[index].validity;
                                      });
                                    },
                                    child: Container(
                                      height: 110.0,
                                      width: 150.0,
                                      color: Colors.transparent,
                                      child: Container(
                                          decoration: BoxDecoration(
                                            border: isSelected == premiumelist[index].Id
                                                ? Border.all(
                                                    color: Color.fromARGB(255, 76, 16, 181),
                                                    width: 2.0,
                                                  )
                                                : Border.all(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                            color: isSelected == premiumelist[index].Id ? Color.fromARGB(255, 76, 16, 181).withOpacity(0.085) : Colors.transparent,
                                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                          ),
                                          child: new Center(
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: 8, right: 10, left: 10),
                                                    child: premiumelist[index].mostpopular == "1"
                                                        ? Container(
                                                            height: 20,
                                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(4),
                                                              color: const Color.fromARGB(255, 12, 134, 118),
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                "Most Popular",
                                                                style: TextStyle(color: Colors.white),
                                                              ),
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                  ),
                                                ),
                                                Align(
                                                  heightFactor: premiumelist[index].mostpopular == "1" ? 0.85 : 1,
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      new Text(
                                                        premiumelist[index].amount,
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black87,
                                                          fontSize: 22,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      new Text(
                                                        premiumelist[index].validity,
                                                        style: const TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 18,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  )
                                ]),
                              );
                            },
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "What you will get",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_outlined,
                                color: Color.fromARGB(255, 39, 121, 41),
                              ),
                              SizedBox(width: 10),
                              Text("SMS & Email Update to Tenants")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_outlined,
                                color: Color.fromARGB(255, 39, 121, 41),
                              ),
                              SizedBox(width: 10),
                              Text("Auto Rent Reminders to Tenants via SMS & Email")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_outlined,
                                color: Color.fromARGB(255, 39, 121, 41),
                              ),
                              SizedBox(width: 10),
                              Text("Priority On-Call Support")
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 46, bottom: 46),
                          child: InkWell(
                            onTap: () => showBottomSheet(context),
                            child: Container(
                              height: 66,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: amou.isNotEmpty ? Color.fromARGB(255, 76, 16, 181) : Colors.grey,
                              ),
                              child: Center(
                                  child: Text(
                                amou.isNotEmpty ? ("Subscribe for " + amou + "/" + validity) : "Package Not Selected !",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
    );
  }
}

int _groupValue1 = -1;
showBottomSheet(context) {
  return showModalBottomSheet(
    context: context,
    builder: (builder) {
      return StatefulBuilder(
        builder: (context, setstate) {
          return SingleChildScrollView(
            padding: EdgeInsetsDirectional.only(
              start: 20,
              end: 10,
              bottom: 30,
              top: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "Filter",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: SizedBox(),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(Icons.close_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                RadioListTile(
                  value: 0,
                  groupValue: _groupValue1,
                  title: Text("Cash"),
                  onChanged: (newValue) => setstate(() => _groupValue1 = newValue as int),
                  activeColor: Colors.blue,
                  selected: false,
                ),
                RadioListTile(
                  value: 1,
                  groupValue: _groupValue1,
                  title: Text("Online"),
                  onChanged: (newValue) => setstate(() => _groupValue1 = newValue as int),
                  activeColor: Colors.blue,
                  selected: false,
                ),
                RadioListTile(
                  value: 2,
                  groupValue: _groupValue1,
                  title: Text("Bank Transfer"),
                  onChanged: (newValue) => setstate(() => _groupValue1 = newValue as int),
                  activeColor: Colors.blue,
                  selected: false,
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

String getCurrency() {
  var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
  return format.currencySymbol;
}

class GetPrrmiume {
  String Id;
  String userid;
  String amount;
  String validity;
  String mostpopular;

  GetPrrmiume({
    required this.Id,
    required this.userid,
    required this.amount,
    required this.validity,
    required this.mostpopular,
  });

//[{"Id":"1","userid":"1","amount":"500","validity":"90","mostpopular":"0"}]
  factory GetPrrmiume.fromJson(Map<String, dynamic> json) => GetPrrmiume(
        Id: json["Id"],
        userid: json["userid"],
        amount: json["amount"],
        validity: json["validity"],
        mostpopular: json["mostpopular"],
      );

  Map<String, dynamic> toJson() => {
        "Id": Id,
        "userid": userid,
        "amount": amount,
        "validity": validity,
        "mostpopular": mostpopular,
      };
  // static List<GetPrrmiume> toJsonList(dynamic json) {
  //   List<GetPrrmiume> value = [];
  //   for (Map<String, dynamic> element in json) {
  //     value.add(GetPrrmiume.fromJson(element));
  //   }
  //   return value;
  // }
}

// [
//   {"Id":"1","userid":"1","amount":"\u20b9500","validity":"90 days","mostpopular":"0"}
// ,{"Id":"2","userid":"1","amount":"\u20b9500","validity":"90 days","mostpopular":"1"},
// {"Id":"3","userid":"1","amount":"\u20b9500","validity":"90 days","mostpopular":"0"},
// {"Id":"4","userid":"1","amount":"\u20b9500","validity":"90 days","mostpopular":"0"}



// ]