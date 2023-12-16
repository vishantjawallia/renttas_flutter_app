import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/Inventory/AddItem.dart';

class newitem extends StatefulWidget {
  const newitem({super.key});

  @override
  State<newitem> createState() => _newitemState();
}

class _newitemState extends State<newitem> {
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
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const additem())),
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
                        Text("New Item"),
                        // Text(
                        //   "ab@gmail.com",
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // )
                      ],
                    ),
                  ),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  InkWell(
                    onTap: () => {},
                    //
                    // Navigator.push(
                    // context,
                    // MaterialPageRoute(
                    //     builder: (context) => const filtertransaction())),
                    child: Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Add",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 80,
                  //color: Colors.red,
                  child: Row(
                    children: [
                      Text(
                        ' Item Name * ',
                        style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 180,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: TextField(
                                  decoration: new InputDecoration.collapsed(hintText: 'hhh'),
                                  style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 80,
                  //color: Colors.red,
                  child: Row(
                    children: [
                      Text(
                        'Item pricee ',
                        style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 180,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: TextField(
                                  decoration: new InputDecoration.collapsed(hintText: '00'),
                                  style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 80,
                  //color: Colors.red,
                  child: Row(
                    children: [
                      Text(
                        'Item Quantity ',
                        style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 180,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: TextField(
                                  decoration: new InputDecoration.collapsed(hintText: '0.0'),
                                  style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  //color: Colors.red,
                  child: Row(
                    children: [
                      Text(
                        'Current Stock :1.00 ',
                        style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      // Flexible(fit: FlexFit.tight, child: SizedBox()),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //     width: 180,
                      //     height: 80,
                      //     decoration: BoxDecoration(
                      //       border: Border.all(color: Colors.grey),
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //     child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Center(
                      //           child: TextField(
                      //             decoration: new InputDecoration.collapsed(
                      //                 hintText: '0.0'),
                      //             style: TextStyle(
                      //                 fontSize: 14,
                      //                 color: Colors.black,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //         )),
                      //   ),
                      // )
                    ],
                  ),
                ),

////// Amount    c ontainerrrrr

                Container(
                  height: 80,
                  width: 500,
                  //color: Colors.red,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 320,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Text(
                                    'Amount',
                                    style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
                                  ),
                                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                                  Text(
                                    '0.000',
                                    style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 80,
                  //color: Colors.red,
                  child: Row(
                    children: [
                      Text(
                        'Description ',
                        style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 180,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: TextField(
                                  decoration: new InputDecoration.collapsed(hintText: 'hhhj'),
                                  style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
