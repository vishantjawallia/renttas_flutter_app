// ignore_for_file: camel_case_types, avoid_print, unnecessary_new, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings, non_constant_identifier_names, deprecated_member_use, sized_box_for_whitespace, empty_catches, unused_local_variable

import 'dart:convert';
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
  String amou="",validity="";

  @override
  void initState() {
    super.initState();
    getprrmiumet();
    setState(() {
      isloaidng = true;
    });
  }

  getprrmiumet() async {
    premiumelist = await getpre();
    setState(() {});
  }

  Future<List<GetPrrmiume>> getpre() async {
    String counrtycode =
        WidgetsBinding.instance.window.locale.countryCode.toString();
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

      setState(() {
        isloaidng = false;
      });

      print("res===" + response.body);
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
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LandloardDashBord()));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: isloaidng == true
          ? Center(
              child: Container(
                  height: 60,
                  width: 60,
                  child: const CircularProgressIndicator()))
          : premiumelist.isEmpty
              ? Center(
                  child:
                      Container(height: 60, width: 60, child: Text("No data")))
              : SingleChildScrollView(
                  child: Column(children: [
                    Align(
                        alignment: Alignment.center,
                        child: Column(children: [
                          const Text(
                            "Get More Features",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w600),
                          ),
                          const Text(
                            "Current plan : Free Forever",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 50,
                            child: Center(child: Divider()),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ])),
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
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isSelected = premiumelist[index].Id;
                                        amou= premiumelist[index].amount;
                                        validity=premiumelist[index].validity;
                                      });
                                    },
                                    child: Container(
                                      height: 100.0,
                                      width: 150.0,
                                      color: Colors.transparent,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: isSelected == premiumelist[index].Id
                                                  ? Border.all(
                                                      color: Color.fromARGB(
                                                          255, 76, 16, 181),
                                                      width: 2.0,
                                                    )
                                                  : Border.all(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(17.0))),
                                          child: new Center(
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 8,
                                                        right: 10,
                                                        left: 10,
                                                      ),
                                                      child: premiumelist[index]
                                                                  .mostpopular ==
                                                              "1"
                                                          ? Container(
                                                              height: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    12,
                                                                    134,
                                                                    118),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                      child:
                                                                          Text(
                                                                "Most Popular",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                            )
                                                          : SizedBox()),
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      new Text(
                                                        premiumelist[index]
                                                            .amount,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 22),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      new Text(
                                                        premiumelist[index]
                                                            .validity,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 18),
                                                        textAlign:
                                                            TextAlign.center,
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "What you will get",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
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
                            SizedBox(
                              width: 10,
                            ),
                            Text("SMS & Email Update to Tenants")
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_outlined,
                              color: Color.fromARGB(255, 39, 121, 41),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                "Auto Rent Reminders to \nTenants via SMS & Email")
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_outlined,
                              color: Color.fromARGB(255, 39, 121, 41),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Priority On-Call Support")
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          // print("sssssss===" +
                          //     WidgetsBinding
                          //         .instance.window.locale.countryCode
                          //         .toString());
                          // String aaa = getCurrency();
                          // print("sssssssasasasa===" + aaa);
                          showbottomsheet(context);
                        },
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          color: Color.fromARGB(255, 76, 16, 181),
                          child: Center(
                              child: Text(
                            "Subscribe for "+amou+"/"+validity,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ),
                  ]),
                ),

      // ListView.builder(
      //             itemCount: premiumelist.length,
      //             itemBuilder: (BuildContext context, int index) {
      //               return SingleChildScrollView(
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Container(
      //                     child: Column(
      //                       children: [
      //                         Align(
      //                             alignment: Alignment.center,
      //                             child: Column(
      //                               children: [
      //                                 const Text(
      //                                   "Get More Features",
      //                                   style: TextStyle(
      //                                       color: Colors.black,
      //                                       fontSize: 25,
      //                                       fontWeight: FontWeight.w600),
      //                                 ),
      //                                 const Text(
      //                                   "Current plan : Free Forever",
      //                                   style: TextStyle(
      //                                       color: Colors.grey,
      //                                       fontSize: 12,
      //                                       fontWeight: FontWeight.w600),
      //                                 ),
      //                                 const SizedBox(
      //                                   height: 50,
      //                                   child: Center(child: Divider()),
      //                                 ),
      //                                 SizedBox(
      //                                   height: 20,
      //                                 ),
      //
      //                                 const SizedBox(
      //                                   height: 20,
      //                                 ),
      //                                 Row(
      //                                   mainAxisAlignment:
      //                                       MainAxisAlignment.spaceEvenly,
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {
      //                                         setState(() {
      //                                           isSelected = 3;
      //                                         });
      //                                       },
      //                                       child: Container(
      //                                         height: 100.0,
      //                                         width: 150.0,
      //                                         color: Colors.transparent,
      //                                         child: Container(
      //                                             decoration: BoxDecoration(
      //                                                 border: isSelected == 3
      //                                                     ? Border.all(
      //                                                         color: Color
      //                                                             .fromARGB(
      //                                                                 255,
      //                                                                 76,
      //                                                                 16,
      //                                                                 181),
      //                                                         width: 2.0,
      //                                                       )
      //                                                     : Border.all(
      //                                                         color:
      //                                                             Colors.grey,
      //                                                         width: 1.0,
      //                                                       ),
      //                                                 borderRadius:
      //                                                     BorderRadius.all(
      //                                                         Radius.circular(
      //                                                             17.0))),
      //                                             child: new Center(
      //                                               child: Stack(
      //                                                 children: [
      //                                                   Align(
      //                                                     alignment: Alignment
      //                                                         .bottomCenter,
      //                                                     child: Padding(
      //                                                       padding:
      //                                                           const EdgeInsets
      //                                                               .only(
      //                                                         top: 8,
      //                                                         right: 10,
      //                                                         left: 10,
      //                                                       ),
      //                                                       child: Container(
      //                                                         height: 20,
      //                                                         decoration:
      //                                                             BoxDecoration(
      //                                                           borderRadius:
      //                                                               BorderRadius
      //                                                                   .circular(
      //                                                                       10),
      //                                                           color: const Color
      //                                                               .fromARGB(
      //                                                               255,
      //                                                               12,
      //                                                               134,
      //                                                               118),
      //                                                         ),
      //                                                         child:
      //                                                             const Center(
      //                                                                 child:
      //                                                                     Text(
      //                                                           "Most Popular",
      //                                                           style: TextStyle(
      //                                                               color: Colors
      //                                                                   .white),
      //                                                         )),
      //                                                       ),
      //                                                     ),
      //                                                   ),
      //                                                   Align(
      //                                                     alignment:
      //                                                         Alignment.center,
      //                                                     child: Column(
      //                                                       mainAxisAlignment:
      //                                                           MainAxisAlignment
      //                                                               .center,
      //                                                       children: [
      //                                                         new Text(
      //                                                           "₹ 1199 ",
      //                                                           style: const TextStyle(
      //                                                               fontWeight:
      //                                                                   FontWeight
      //                                                                       .bold,
      //                                                               color: Colors
      //                                                                   .black87,
      //                                                               fontSize:
      //                                                                   22),
      //                                                           textAlign:
      //                                                               TextAlign
      //                                                                   .center,
      //                                                         ),
      //                                                         new Text(
      //                                                           "1 Year",
      //                                                           style: const TextStyle(
      //                                                               color: Colors
      //                                                                   .black87,
      //                                                               fontSize:
      //                                                                   18),
      //                                                           textAlign:
      //                                                               TextAlign
      //                                                                   .center,
      //                                                         ),
      //                                                       ],
      //                                                     ),
      //                                                   ),
      //                                                 ],
      //                                               ),
      //                                             )),
      //                                       ),
      //                                     ),
      //                                     InkWell(
      //                                       onTap: () {
      //                                         setState(() {
      //                                           isSelected = 4;
      //                                         });
      //                                       },
      //                                       child: Container(
      //                                         height: 100.0,
      //                                         width: 150.0,
      //                                         color: Colors.transparent,
      //                                         child: Container(
      //                                             decoration: BoxDecoration(
      //                                                 border: isSelected == 4
      //                                                     ? Border.all(
      //                                                         color: Color
      //                                                             .fromARGB(
      //                                                                 255,
      //                                                                 76,
      //                                                                 16,
      //                                                                 181),
      //                                                         width: 2.0,
      //                                                       )
      //                                                     : Border.all(
      //                                                         color:
      //                                                             Colors.grey,
      //                                                         width: 1.0,
      //                                                       ),
      //                                                 borderRadius:
      //                                                     BorderRadius.all(
      //                                                         Radius.circular(
      //                                                             17.0))),
      //                                             child: new Center(
      //                                               child: Column(
      //                                                 mainAxisAlignment:
      //                                                     MainAxisAlignment
      //                                                         .center,
      //                                                 children: [
      //                                                   new Text(
      //                                                     "₹ 1799 ",
      //                                                     style: TextStyle(
      //                                                         fontWeight:
      //                                                             FontWeight
      //                                                                 .bold,
      //                                                         color: Colors
      //                                                             .black87,
      //                                                         fontSize: 22),
      //                                                     textAlign:
      //                                                         TextAlign.center,
      //                                                   ),
      //                                                   new Text(
      //                                                     "2 Years",
      //                                                     style: TextStyle(
      //                                                         color: Colors
      //                                                             .black87,
      //                                                         fontSize: 18),
      //                                                     textAlign:
      //                                                         TextAlign.center,
      //                                                   ),
      //                                                 ],
      //                                               ),
      //                                             )),
      //                                       ),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ],
      //                             )),
      //                         const SizedBox(
      //                           height: 20,
      //                         ),
      //                         const Align(
      //                           alignment: Alignment.centerLeft,
      //                           child: Padding(
      //                             padding: EdgeInsets.all(8.0),
      //                             child: Text(
      //                               "What you will get",
      //                               style: TextStyle(
      //                                   color: Colors.black,
      //                                   fontSize: 15,
      //                                   fontWeight: FontWeight.w600),
      //                             ),
      //                           ),
      //                         ),
      //                         Padding(
      //                             padding: const EdgeInsets.all(8.0),
      //                             child: Row(
      //                               children: [
      //                                 Icon(
      //                                   Icons.check_outlined,
      //                                   color: Color.fromARGB(255, 39, 121, 41),
      //                                 ),
      //                                 SizedBox(
      //                                   width: 10,
      //                                 ),
      //                                 Text("SMS & Email Update to Tenants")
      //                               ],
      //                             )),
      //                         Padding(
      //                             padding: const EdgeInsets.all(8.0),
      //                             child: Row(
      //                               children: [
      //                                 Icon(
      //                                   Icons.check_outlined,
      //                                   color: Color.fromARGB(255, 39, 121, 41),
      //                                 ),
      //                                 SizedBox(
      //                                   width: 10,
      //                                 ),
      //                                 Text(
      //                                     "Auto Rent Reminders to \nTenants via SMS & Email")
      //                               ],
      //                             )),
      //                         Padding(
      //                             padding: const EdgeInsets.all(8.0),
      //                             child: Row(
      //                               children: [
      //                                 Icon(
      //                                   Icons.check_outlined,
      //                                   color: Color.fromARGB(255, 39, 121, 41),
      //                                 ),
      //                                 SizedBox(
      //                                   width: 10,
      //                                 ),
      //                                 Text("Priority On-Call Support")
      //                               ],
      //                             )),
      //                         Padding(
      //                           padding: const EdgeInsets.all(8.0),
      //                           child: InkWell(
      //                             onTap: () {
      //                               // print("sssssss===" +
      //                               //     WidgetsBinding
      //                               //         .instance.window.locale.countryCode
      //                               //         .toString());
      //                               // String aaa = getCurrency();
      //                               // print("sssssssasasasa===" + aaa);
      //                               showbottomsheet(context);
      //                             },
      //                             child: Container(
      //                               height: 60,
      //                               width: MediaQuery.of(context).size.width,
      //                               color: Color.fromARGB(255, 76, 16, 181),
      //                               child: Center(
      //                                   child: Text(
      //                                 "Subscribe for ₹ 99/month",
      //                                 style: TextStyle(
      //                                     fontSize: 20,
      //                                     color: Colors.white,
      //                                     fontWeight: FontWeight.bold),
      //                               )),
      //                             ),
      //                           ),
      //                         ),
      //                         // Padding(
      //                         //   padding: const EdgeInsets.all(8.0),
      //                         //   child: InkWell(
      //                         //     onTap: () async {
      //                         //       // Navigator.of(context).push(
      //                         //       //   MaterialPageRoute(
      //                         //       //     builder: (builder) => InvoicePage(),
      //                         //       //   ),
      //                         //       // );
      //                         //
      //                         //       // final InvoicePdf invoicePdf = InvoicePdf();
      //                         //       // final File pdfFile = await invoicePdf.generateInvoice();
      //                         //       // generatePDF();
      //                         //       //  final InvoicePdf invoicePdf = InvoicePdf();
      //                         //       //  final File pdfFile = await invoicePdf.generateInvoice();
      //                         //       //callfunctiontogenertae();
      //                         //     },
      //                         //     child: Container(
      //                         //       height: 60,
      //                         //       width: MediaQuery.of(context).size.width,
      //                         //       color: Color.fromARGB(255, 76, 16, 181),
      //                         //       child: Center(
      //                         //           child: Text(
      //                         //         "Generate invoice",
      //                         //         style: TextStyle(
      //                         //             fontSize: 20,
      //                         //             color: Colors.white,
      //                         //             fontWeight: FontWeight.bold),
      //                         //       )),
      //                         //     ),
      //                         //   ),
      //                         // ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               );
      //             }),
    );
  }
}

int _groupValue1 = -1;
showbottomsheet(context) {
  return showModalBottomSheet(
      context: context,
      builder: (builder) {
        return StatefulBuilder(builder: (context, setstate) {
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
                      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: Text(
                            "Filter",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
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
                      onChanged: (newValue) =>
                          setstate(() => _groupValue1 = newValue as int),
                      activeColor: Colors.blue,
                      selected: false,
                    ),
                    RadioListTile(
                      value: 1,
                      groupValue: _groupValue1,
                      title: Text("Online"),
                      onChanged: (newValue) =>
                          setstate(() => _groupValue1 = newValue as int),
                      activeColor: Colors.blue,
                      selected: false,
                    ),
                    RadioListTile(
                      value: 2,
                      groupValue: _groupValue1,
                      title: Text("Bank Transfer"),
                      onChanged: (newValue) =>
                          setstate(() => _groupValue1 = newValue as int),
                      activeColor: Colors.blue,
                      selected: false,
                    ),
                  ]));
        });
      });
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
}
