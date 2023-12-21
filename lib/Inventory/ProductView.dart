import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Common/ApiUrl.dart';
import 'Dashboard.dart';
import 'Model/GetProductViewModel.dart';
import 'NewProductAdd.dart';

class productview extends StatefulWidget {
  const productview({super.key});

  @override
  State<productview> createState() => _productviewState();
}

List<GetProduct> productlist = [];
bool isloaidng = false;
void snack(String msg, BuildContext context) {
  final snackBar = SnackBar(
    elevation: 0,
    backgroundColor: Color.fromARGB(55, 74, 20, 140),
    content: Text(
      msg,
      style: TextStyle(color: Colors.black),
    ),
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class _productviewState extends State<productview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getproduct();
    setState(() {
      isloaidng = true;
    });
  }

  getproduct() async {
    productlist = await getpr();
    setState(() {});
  }

  Future<List<GetProduct>> getpr() async {
    print("ssss");
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

          print("res===" + response.body);
          if (response.statusCode == 200) {
            final Map<String, dynamic> jsonData = jsonDecode(response.body);
            List res = jsonData["data"];

            return res.map((e) => GetProduct.fromJson(e)).toList();
          }
        }
      } else {
        snack("Choose store", context);
      }
    } catch (e) {}
    return productlist;
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
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const inentorydashboard())),
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("All Products"),
                        // Text(
                        //   "ab@gmail.com",
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // )
                      ],
                    ),
                  ),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      size: 24,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
                        //alignment: Alignment.center,
                        child: Icon(
                          Icons.qr_code_scanner_outlined,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
                        //alignment: Alignment.center,
                        child: Icon(
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
          ? Center(
              child: Container(
                  height: 60,
                  width: 60,
                  child: const CircularProgressIndicator(
                    color: Color(0xff54854C),
                  )))
          : productlist.isEmpty
              ? Center(child: Container(height: 60, width: 60, child: Text("No data")))
              : ListView.builder(
                  itemCount: productlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () => order_confirm(context, productlist[index].id, productlist[index].productname, productlist[index].description, productlist[index].sku, productlist[index].storeid),
                        child: Container(
                          color: Colors.white,
                          height: 100,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productlist[index].productname,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      productlist[index].sku,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_circle_up,
                                          color: Colors.orange,
                                        ),
                                        Text(
                                          productlist[index].description,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.orange),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),

                                        Icon(
                                          Icons.arrow_circle_down,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          "0.00",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.green),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        // Icon(
                                        //   Icons.equalizer,
                                        //   color: Colors.grey,
                                        // ),
                                        Text(
                                          "= 1.00",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Flexible(fit: FlexFit.tight, child: SizedBox()),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(40)),
                                    //alignment: Alignment.center,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
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
                    );
                  }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => newproductadd(
                        type: "0",
                        id: "",
                        productname: "",
                        descr: "",
                        sku: "",
                      )));
        },
      ),
    );
  }

  Future<dynamic> order_confirm(BuildContext context, String id, String name, String descrip, String sku, String storeid) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(25),
          topStart: Radius.circular(25),
        ),
      ),
      builder: (context) => SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                        color: Color(0xFFFDB730)),
                    child: Center(
                      child: Text(
                        "Transaction",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => newproductadd(type: "1", id: id, productname: name, descr: descrip, sku: sku))),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(Icons.note_alt_outlined),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => viewdetails(context),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(Icons.note_rounded),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => showAlertDialog(context, id),
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
                SizedBox(
                  width: 10,
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
                      child: Icon(Icons.close),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              sku,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Icon(
                          Icons.download,
                          color: Colors.greenAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Total In",
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "1.00",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Icon(
                          Icons.upload,
                          color: Colors.orangeAccent[200],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Total Out"),
                      ],
                    ),
                  ),
                ),
                Text(
                  "1.00",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Icon(Icons.handshake, color: Colors.purpleAccent),
                        SizedBox(
                          width: 10,
                        ),
                        Text("In Hand"),
                      ],
                    ),
                  ),
                ),
                Text(
                  "1.00",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Description :",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("description "),
              ],
            )
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const productview()));
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () async {
        SharedPreferences logindata = await SharedPreferences.getInstance();
        String? userid = logindata.getString("userId");

        if (logindata.getString("storeid") != null) {
          String storeid = logindata.getString("storeid")!;

          if (storeid == "") {
            snack("Please select a store in store view", context);
          } else {
            Map data = {
              'userid': userid,
              'storeid': storeid,
              'id': id,
            };
            final headerss = {
              'Content-Type': 'application/json',
            };
            print(data.toString());
            final response = await http.post(
              Uri.parse(ApiUrl.deleteproduct),
              headers: headerss,
              body: jsonEncode(data),
            );

            print(response.body);
            if (response.statusCode == 200) {
              Map<String, dynamic> resposne = jsonDecode(response.body);

              if (resposne['respCode'].toString().contains("200")) {
                Navigator.pop(context);
                //getproduct();
                print("Login Successfully Completed !!!!!!!!!!!!!!!!");
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Added failed.........'),
                  backgroundColor: Colors.green,
                ));
              }
            } else {
              print("Please try again!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
            }
          }
        } else {
          snack("Please select a store in store view", context);
        }

        // Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Are you sure want to delete ?"),
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

  Future<dynamic> viewdetails(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(25),
          topStart: Radius.circular(25),
        ),
      ),
      builder: (context) => SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    "Stock Information",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                SizedBox(
                  width: 10,
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
                      child: Icon(Icons.close),
                    ),
                  ),
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text(
                          "Store",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // Flexible(fit: FlexFit.tight, child: SizedBox()),
                        // Text(
                        //   "IN",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        // ),
                        // Text(
                        //   "OUT",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        // ),
                        // Text(
                        //   "Current \nStock",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        // ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "IN",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "OUT",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Current \nStock",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),

                // Text(
                //   "1.00",
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text(
                          "Main Store",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // Flexible(fit: FlexFit.tight, child: SizedBox()),
                        // Text(
                        //   "IN",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        // ),
                        // Text(
                        //   "OUT",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        // ),
                        // Text(
                        //   "Current \nStock",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        // ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "1.00",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "0.00",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "1.00",
                  style: TextStyle(fontSize: 15),
                ),

                // Text(
                //   "1.00",
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
              ],
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Flexible(
            //       child: Container(
            //         width: MediaQuery.of(context).size.width,
            //         child: Row(
            //           children: [
            //             Icon(
            //               Icons.upload,
            //               color: Colors.orangeAccent[200],
            //             ),
            //             SizedBox(
            //               width: 10,
            //             ),
            //             Text("Total Out"),
            //           ],
            //         ),
            //       ),
            //     ),
            //     Text(
            //       "1.00",
            //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Flexible(
            //       child: Container(
            //         width: MediaQuery.of(context).size.width,
            //         child: Row(
            //           children: [
            //             Icon(Icons.handshake, color: Colors.purpleAccent),
            //             SizedBox(
            //               width: 10,
            //             ),
            //             Text("In Hand"),
            //           ],
            //         ),
            //       ),
            //     ),
            //     Text(
            //       "1.00",
            //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // Flexible(fit: FlexFit.tight, child: SizedBox()),
                        // Text(
                        //   "IN",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        // ),
                        // Text(
                        //   "OUT",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        // ),
                        // Text(
                        //   "Current \nStock",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        // ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "1.00",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "0.00",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "1.00",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),

                // Text(
                //   "1.00",
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
