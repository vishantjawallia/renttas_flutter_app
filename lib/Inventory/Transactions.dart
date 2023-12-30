// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

import 'Filtertransaction.dart';

class ViewTransactions extends StatefulWidget {
  const ViewTransactions({super.key});

  @override
  State<ViewTransactions> createState() => _ViewTransactionsState();
}

class _ViewTransactionsState extends State<ViewTransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        // backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: false,
        leading: const BackButton(),
        // actions: <Widget>[
        title: Row(
          children: [
            const Text("Transactions"),
            const Flexible(fit: FlexFit.tight, child: SizedBox()),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.search,
                size: 25,
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FilterTransaction(),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.filter_alt,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: BorderRadius.circular(8),
                elevation: 5,
                child: ExpansionTile(
                  title: const Text('Stock Information'),
                  children: [
                    Container(
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
                            const Row(
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
                                  style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 9),
                            Row(
                              children: [
                                Icon(
                                  Icons.upload,
                                  color: Colors.orangeAccent[200],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("Total Out"),
                                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                const Text(
                                  '0.00',
                                  style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Row(
                              children: [
                                Icon(Icons.propane_sharp, color: Colors.deepPurple[200]),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("Products"),
                                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                const Text(
                                  '1.00',
                                  style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Row(
                              children: [
                                Icon(Icons.low_priority, color: Colors.pink[200]),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("Low Stocks"),
                                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                const Text(
                                  '0.00',
                                  style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            const Row(
                              children: [
                                Icon(Icons.handshake, color: Colors.purpleAccent),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("In Hand"),
                                Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Text(
                                  '1.00',
                                  style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
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
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '25/10/2022',
                style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () => orderConfirm(context),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  height: 95,
                  width: double.infinity,
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.download,
                          color: Colors.greenAccent,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "hhhh",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Purchase rate : 10000",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Padding(
                        padding: EdgeInsets.all(5.0),
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
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Flexible(fit: FlexFit.tight, child: SizedBox()),
                            Text(
                              "1.00",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
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
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xff54854C),

        onPressed: () {},
      ),
    );
  }
}

Future<dynamic> orderConfirm(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.download,
                color: Colors.greenAccent,
              ),
              const SizedBox(
                width: 10,
              ),
              const Flexible(
                child: Text(
                  "hhh",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              const Flexible(fit: FlexFit.tight, child: SizedBox()),
              InkWell(
                onTap: () => showAlertDialog(context),
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
          const Text(
            "PID - 101",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const Text(
            "Date :25/10/2023",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
          const Text(
            "Store Name:Main Store ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),
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
              const Text(
                "1000.0",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          const Row(
            children: [
              Text(
                "Remarkkk :",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text("vvb "),
            ],
          )
        ],
      ),
    ),
  );
}

showAlertDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {},
  );
  Widget continueButton = TextButton(
    child: const Text("Continue"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("Confirmation"),
    content: const Text("Are you sure want to delete ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
