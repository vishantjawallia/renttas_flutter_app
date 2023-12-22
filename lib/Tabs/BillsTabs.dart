// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, unnecessary_new, prefer_final_fields, sized_box_for_whitespace

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:renttas_flutter_app/model/BillModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Const/Const.dart';
import '../Invoice/pages/pdfexport/pdfpreview.dart';
import '../TabAction/BillTabAction.dart';
import '../landlord/BillViewPage.dart';
import '../landlord/LandloardDashBord.dart';

class BillsTabs extends StatefulWidget {
  final bool data;
  const BillsTabs({Key? key, required this.data}) : super(key: key);

  @override
  State<BillsTabs> createState() => _BillsTabsState();
}

class _BillsTabsState extends State<BillsTabs> {
  bool isLoading = false;
  bool isBillTheir = false;
  static String selectedPropertyId = '';
  static String selectedSubProptyId = '';
  static String selectedSubPropertyName = '';
  List<BIllModel> billData = [];

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedPropertyId = prefs.getString('selectedPropertyId') ?? '';
      selectedSubProptyId = prefs.getString('selectedSubProptyId') ?? '';
      selectedSubPropertyName = prefs.getString('selectedSubPropertyName') ?? '';
      fetchBill(selectedPropertyId, selectedSubProptyId);
    });
    print("selectedPropertyId->" + selectedPropertyId);
    print("selectedSubProptyId->" + selectedSubProptyId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (widget.data == false) {
            snack("Add Room first", context);
          } else {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => BillTabAction()));
          }
        },
        label: Text(
          'Rent Bill',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        icon: Icon(Icons.add),
        backgroundColor: Color(0xff54854C),
        // backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
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
                : widget.data == false
                    ? Flexible(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 60.0),
                            child: Text(
                              'Bill not found !',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Visibility(
                        visible: isBillTheir,
                        child: Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: billData.length,
                            itemBuilder: (context, index) {
                              final bill = billData[index];
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          SizedBox(width: 5),
                                          Text(
                                            bill.rentStartDate,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            selectedSubPropertyName,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(width: 30),
                                          Container(
                                            color: Colors.red[100],
                                            child: Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "₹ " + bill.previousBalance.toString(),
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  Text(
                                                    "(balance)",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: Colors.green[100],
                                            child: Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "₹ " + bill.rentAmount.toString(),
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                  Text(
                                                    "(recieved)",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => BillViewPage(
                                                              Data: bill,
                                                              type: '1',
                                                            )));
                                              },
                                              icon: Icon(Icons.arrow_forward_ios)),
                                        ],
                                      ),
                                      // Divider(
                                      //   color: Colors.grey,
                                      //   height: 30,
                                      // ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Container(
                                        color: Colors.black12,
                                        height: 2,
                                        width: 500,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // SizedBox(
                                          //   width: 30,
                                          // ),
                                          Column(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  showbottomsheet(context, bill.id);
                                                  //   _showBottomSheet(
                                                  // context, bill['id']);
                                                },
                                                icon: Icon(Icons.add_box),
                                              ),
                                              Text('Receive'),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   width: 50,
                                          // ),
                                          Container(
                                            color: Colors.black12,
                                            height: 70,
                                            width: 2,
                                          ),
                                          // SizedBox(
                                          //   width: 50,
                                          // ),
                                          Column(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  // String message =
                                                  //     "Hii their your Bill form is ";
                                                  // shareOnWhatsApp(message);

                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (builder) => PdfPreviewPage(invoice: bill, subname: selectedSubPropertyName),
                                                    ),
                                                  );

                                                  //Share.share('Check');
                                                },
                                                icon: Icon(Icons.share),
                                              ),
                                              Text('Share'),
                                            ],
                                          ),
                                          Container(
                                            color: Colors.black12,
                                            height: 70,
                                            width: 2,
                                          ),
                                          Column(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  shareOnWhatsApp("Hello");
                                                  /* _showBottomSheet(
                                              context, bill['id']);*/
                                                },
                                                icon: Image.asset(
                                                  "assets/images/wi.png",
                                                  height: 43,
                                                  width: 43,
                                                ),
                                              ),
                                              Text('Remind'),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   width: 30,
                                          // ),
                                          Container(
                                            color: Colors.black12,
                                            height: 70,
                                            width: 2,
                                          ),
                                          // SizedBox(
                                          //   width: 30,
                                          // ),

                                          Column(
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  if (Platform.isAndroid) {
                                                    var status = await Permission.storage.status;
                                                    if (status != PermissionStatus.granted) {
                                                      status = await Permission.storage.request();
                                                    }
                                                    if (status.isGranted) {
                                                      //   const downloadsFolderPath = '/storage/emulated/0/Download/';
                                                      //   Directory dir = Directory(downloadsFolderPath);
                                                      // var file=  makePdf(bill,selectedSubPropertyName);
                                                      //   file = File('${dir.path}/$selectedSubPropertyName') as Future<Uint8List>;

                                                      Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                          builder: (builder) => PdfPreviewPage(invoice: bill, subname: selectedSubPropertyName),
                                                        ),
                                                      );
                                                    }
                                                  }
                                                },
                                                icon: Icon(Icons.downloading_outlined),
                                              ),
                                              Text('Download'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
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
                                'Bill not found !',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  DateTime dateTime = DateTime.now();
  TextEditingController _textControllerdate1 = new TextEditingController();
  TextEditingController recievedcontroller = new TextEditingController();
  String transer = "cash";
  _selectDate() async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: dateTime, initialDatePickerMode: DatePickerMode.day, firstDate: DateTime(1850), lastDate: DateTime(2101));
    if (picked != null) {
      dateTime = picked;
      //assign the chosen date to the controller
      _textControllerdate1.text = DateFormat.yMd().format(dateTime);
    }
  }

  int selectedone = 1;

  showbottomsheet(context, String id) {
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
              child: Wrap(
                // direction: Axis.vertical,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Add Recived Rent Payment",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Rent paid through",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                setstate(() {
                                  selectedone = 1;
                                  transer = "cash";
                                });
                              },
                              child: Container(
                                  height: 30,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: selectedone == 1 ? Colors.blue : Colors.white,
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Cash",
                                    style: TextStyle(fontSize: 15, color: selectedone == 1 ? Colors.white : Colors.black),
                                  ))),
                            ),
                            InkWell(
                              onTap: () {
                                setstate(() {
                                  selectedone = 2;
                                  transer = "Online transfer";
                                });
                              },
                              child: Container(
                                  height: 30,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: selectedone == 2 ? Colors.blue : Colors.white,
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Online transfer",
                                    style: TextStyle(fontSize: 15, color: selectedone == 2 ? Colors.white : Colors.black),
                                  ))),
                            ),
                            InkWell(
                              onTap: () {
                                setstate(() {
                                  selectedone = 3;
                                  transer = "Check";
                                });
                              },
                              child: Container(
                                  height: 30,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: selectedone == 3 ? Colors.blue : Colors.white,
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Check",
                                    style: TextStyle(fontSize: 15, color: selectedone == 3 ? Colors.white : Colors.black),
                                  ))),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 8,
                      left: 8,
                      right: 8,
                      // bottom: MediaQuery.of(context)
                      //     .viewInsets
                      //     .bottom,
                    ),
                    child: Container(
                      // height: 50,
                      width: MediaQuery.of(context).size.width / 1,
                      //   color: Colors.amber,
                      child: TextFormField(
                        cursorColor: Color.fromARGB(255, 3, 61, 109),
                        //  controller: namecontroller,
                        readOnly: true, //this is important
                        onTap: _selectDate, //the method for opening data picker
                        controller: _textControllerdate1,
                        decoration: InputDecoration(
                            hintText: 'choose date',
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                              child: Icon(Icons.calendar_month),
                            ),
                            label: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                "Rent Paid date",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 3, 61, 109)),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 8,
                      left: 8,
                      right: 8,
                      // bottom: MediaQuery.of(context)
                      //     .viewInsets
                      //     .bottom,
                    ),
                    child: Container(
                      // height: 50,
                      width: MediaQuery.of(context).size.width / 1,
                      //   color: Colors.amber,
                      child: TextFormField(
                        cursorColor: Color.fromARGB(255, 3, 61, 109),
                        controller: recievedcontroller,
                        decoration: InputDecoration(
                            hintText: 'Rent recived',
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                              child: Icon(Icons.monetization_on),
                            ),
                            label: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                "Rent recived",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 3, 61, 109)),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                    child: Center(
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: MaterialButton(
                          color: Colors.purple,
                          onPressed: () {
                            sentdata(id, transer, _textControllerdate1.text, recievedcontroller.text);

                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  Future<void> sentdata(
    String billid,
    String transferthrugh,
    String date,
    String recivedamount,
  ) async {
    final Map<String, dynamic> requestData = {
      "billid": billid,
      "transferthrough": transferthrugh,
      "date": date,
      "receivedamount": recivedamount,
    };

    try {
      final response = await http.post(Uri.parse(ApiUrl.addrecivedpayment), headers: {"Content-Type": "application/json"}, body: jsonEncode(requestData));

      setState(() {
        isLoading = false;
      });

      print("Cycle bill tabs----" + response.body);
      if (response.statusCode == 200) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandloardDashBord()));
      } else {
        snack("Something went wrong, please try again", context);
        print("Failed to send data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  void shareOnWhatsApp(String message) async {
    String url = "whatsapp://send?text=$message";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void fetchBill(String propertyId, String subPropertyId) async {
    log("propert id==" + propertyId + "  subproprid===" + subPropertyId);
    setState(() {
      isLoading = true;
    });
    final Map<String, dynamic> requestData = {"propertyId": propertyId, "subPropertyId": subPropertyId};

    // final Map<String, dynamic> requestData = {
    //   "propertyCode": "8989",
    //   "subProperty": "test"
    // };

    print(propertyId);
    print(subPropertyId);

    final response = await http.post(
      Uri.parse(ApiUrl.getBill), // Replace with your API endpoint
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );

    print("hey in bill===" + response.body);
    if (response.statusCode == 200) {
      //   final List<Map> responseData = jsonDecode(response.body);
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      List res = jsonData["data"];

      if (res.isNotEmpty) {
        for (var billDataModal in res) {
          print(billDataModal);
          BIllModel bill = BIllModel.fromJson(billDataModal);
          billData.add(bill);
        }
        if (billData.isNotEmpty) {
          isBillTheir = true;
        }
      }
      setState(() {
        isLoading = false;
      });
    } else {
      print("Error");
    }
    setState(() {
      isLoading = false;
    });
  }
}
