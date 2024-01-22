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
        // actions: [
        title: Row(
          children: [
            Text("Transactions"),
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
                  title: Text('Stock Information'),
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
                            Row(
                              children: [
                                const Icon(
                                  Icons.download,
                                  color: Colors.greenAccent,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("Total In"),
                                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Text(
                                  '1.00',
                                  style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
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
                                Text("Total Out"),
                                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Text(
                                  '0.00',
                                  style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
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
                                Text("Products"),
                                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Text(
                                  '1.00',
                                  style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
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
                                Text("Low Stocks"),
                                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Text(
                                  '0.00',
                                  style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.handshake, color: Colors.purpleAccent),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("In Hand"),
                                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Text(
                                  '1.00',
                                  style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '25/10/2022',
                style: const TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
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
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.download,
                          color: Colors.greenAccent,
                        ),
                      ),
                      const SizedBox(
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
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Purchase rate : 10000",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      const Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.store,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Main store",
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Flexible(fit: FlexFit.tight, child: SizedBox()),
                            Text(
                              "1.00",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                            ),
                            const SizedBox(
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

        onPressed: () {
          // orderConfirm(context);
        },
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
              Flexible(
                child: Text(
                  "hhh",
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
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
          Text(
            "PID - 101",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Text(
            "Date :25/10/2023",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
          Text(
            "Store Name:Main Store ",
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
                  child: Row(
                    children: [
                      const Icon(
                        Icons.line_weight,
                        color: Colors.purple,
                      ),
                      const SizedBox(
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
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      const Icon(
                        Icons.monetization_on,
                        color: Colors.purpleAccent,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("Purchase Rate"),
                    ],
                  ),
                ),
              ),
              Text(
                "1000.0",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Remarkkk :",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
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
    child: Text("Cancel"),
    onPressed: () {},
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Confirmation"),
    content: Text("Are you sure want to delete ?"),
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
