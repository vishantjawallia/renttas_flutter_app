// ignore_for_file: sort_child_properties_last, avoid_print, use_build_context_synchronously, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unnecessary_import

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/widgets/global_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Common/ApiUrl.dart';
import 'Model/GetProductViewModel.dart';
import 'NewProductAddNew.dart';

class ProductViewNew extends StatefulWidget {
  const ProductViewNew({super.key});

  @override
  State<ProductViewNew> createState() => _ProductViewNewState();
}

List<GetProduct> productlist = [];
bool isloaidng = false;
void snack(String msg, BuildContext context) {
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

class _ProductViewNewState extends State<ProductViewNew> {
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
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        title: Row(
          children: [
            const Text("All Products"),
            const Flexible(fit: FlexFit.tight, child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
                //alignment: Alignment.center,
                child: const Icon(
                  Icons.qr_code_scanner_outlined,
                  size: 20,
                  color: Color(0xff54854C),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
                  child: const Icon(
                    Icons.mobile_screen_share_rounded,
                    size: 20,
                    color: Color(0xff54854C),
                  )),
            ),
            const SizedBox(width: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.search,
                size: 24,
              ),
            ),
          ],
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
          : productlist.isEmpty
              ? GlobalWidgets.notFound('Products')
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 14),
                  itemCount: productlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(6),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(6),
                          onTap: () =>
                              order_confirm(context, productlist[index].id, productlist[index].productname, productlist[index].description, productlist[index].sku, productlist[index].storeid),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            // height: 100,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productlist[index].productname,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        productlist[index].sku,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.arrow_circle_up,
                                            color: Colors.orange,
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            productlist[index].description,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.orange),
                                          ),
                                          const SizedBox(width: 10),
                                          const Icon(
                                            Icons.arrow_circle_down,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(width: 2),
                                          const Text(
                                            "0.00",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.red),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Icon(Icons.equalizer, color: Colors.grey),
                                          const Text(
                                            "= 1.00",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                                          ),
                                          const SizedBox(width: 10),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(40),
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 0.2,
                                          spreadRadius: 0.4,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xff54854C),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewProductAddNew(
              type: "0",
              id: "",
              productname: "",
              descr: "",
              sku: "",
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> order_confirm(BuildContext context, String id, String name, String descrip, String sku, String storeid) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(25),
          topStart: Radius.circular(25),
        ),
      ),
      builder: (context) => SingleChildScrollView(
        padding: const EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
          bottom: 30,
          top: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
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
                        color: const Color(0xFFFDB730)),
                    child: const Center(
                      child: Text(
                        "Transaction",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewProductAddNew(type: "1", id: id, productname: name, descr: descrip, sku: sku))),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.note_alt_outlined),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => viewdetails(context),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.note_rounded),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => showAlertDialog(context, id),
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
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.close),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              sku,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Row(
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
                const Text(
                  "1.00",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Icon(
                          Icons.upload,
                          color: Colors.orangeAccent[200],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("Total Out"),
                      ],
                    ),
                  ),
                ),
                const Text(
                  "1.00",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Row(
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
                const Text(
                  "1.00",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            const Row(
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
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
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
                print("Login Successfully Completed !!!!!!!!!!!!!!!!");
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Added failed.........'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            } else {
              print("Please try again!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
            }
          }
        } else {
          snack("Please select a store in store view", context);
        }
      },
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

  Future<dynamic> viewdetails(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(25),
          topStart: Radius.circular(25),
        ),
      ),
      builder: (context) => SingleChildScrollView(
        padding: const EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
          bottom: 30,
          top: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Flexible(
                  child: Text(
                    "Stock Information",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                const SizedBox(width: 10),
                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.close),
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Row(
                      children: [
                        Text(
                          "Store",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                const Text(
                  "IN",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(width: 20),
                const Text(
                  "OUT",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(width: 20),
                const Text(
                  "Current \nStock",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Row(
                      children: [
                        Text(
                          "Main Store",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                const Text(
                  "1.00",
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  width: 30,
                ),
                const Text(
                  "0.00",
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  width: 30,
                ),
                const Text(
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
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Row(
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
                const Text(
                  "1.00",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "0.00",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
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
