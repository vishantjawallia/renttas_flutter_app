import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Dashboard.dart';
import 'Filtertransaction.dart';

class viewtransactions extends StatefulWidget {
  const viewtransactions({super.key});

  @override
  State<viewtransactions> createState() => _viewtransactionsState();
}

class _viewtransactionsState extends State<viewtransactions> {
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
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const inentorydashboard())),
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
                        Text("Transactions"),
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
                      size: 25,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const filtertransaction())),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.filter_alt,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // height: 60,
              // color: Colors.white,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: ExpansionTile(
                title: const Text('Stock Information'),
                children: [
                  Container(
                    // height: 40,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.download,
                                color: Colors.greenAccent,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Total In"),
                              Flexible(fit: FlexFit.tight, child: SizedBox()),
                              Text(
                                '1.00',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.upload,
                                color: Colors.orangeAccent[200],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Total Out"),
                              Flexible(fit: FlexFit.tight, child: SizedBox()),
                              Text(
                                '0.00',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Row(
                            children: [
                              Icon(Icons.propane_sharp,
                                  color: Colors.deepPurple[200]),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Products"),
                              Flexible(fit: FlexFit.tight, child: SizedBox()),
                              Text(
                                '1.00',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Row(
                            children: [
                              Icon(Icons.low_priority, color: Colors.pink[200]),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Low Stocks"),
                              Flexible(fit: FlexFit.tight, child: SizedBox()),
                              Text(
                                '0.00',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Row(
                            children: [
                              Icon(Icons.handshake, color: Colors.purpleAccent),
                              SizedBox(
                                width: 10,
                              ),
                              Text("In Hand"),
                              Flexible(fit: FlexFit.tight, child: SizedBox()),
                              Text(
                                '1.00',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '25/10/2022',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: () => order_confirm(context),
            child: Container(
              color: Colors.white,
              height: 80,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.download,
                      color: Colors.greenAccent,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "hhhh",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Purchase rate : 10000",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.store,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Main store",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
                        Text(
                          "1.00",
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
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        onPressed: () {
          //  _displayTextInputDialog(context);
        },
      ),
    );
  }
}

Future<dynamic> order_confirm(BuildContext context) {
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
              Icon(
                Icons.download,
                color: Colors.greenAccent,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  "hhh",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Flexible(fit: FlexFit.tight, child: SizedBox()),
              InkWell(
                onTap: () => showAlertDialog(context),
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
            "PID - 101",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Text(
            "Date :25/10/2023",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
          Text(
            "Store Name:Main Store ",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),
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
                        Icons.line_weight,
                        color: Colors.purple,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Quantity",
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
                        Icons.monetization_on,
                        color: Colors.purpleAccent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Purchase Rate"),
                    ],
                  ),
                ),
              ),
              Text(
                "1000.0",
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
                "Remarkkk :",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text("vvb "),
            ],
          )
        ],
      ),
    ),
  );
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      // Navigator.pop(context);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => const productview()));
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: () {
      Navigator.pop(context);
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
