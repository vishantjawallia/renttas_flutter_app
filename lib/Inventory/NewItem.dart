// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/Inventory/AddItem.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 10),
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddItem())),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("New Item"),
                    ],
                  ),
                ),
                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                InkWell(
                  onTap: () => {},
                  child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Add",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 15),
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    const Text(
                      ' Item Name * ',
                      style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const Flexible(fit: FlexFit.tight, child: SizedBox()),
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
                              style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    const Text(
                      'Item pricee ',
                      style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const Flexible(fit: FlexFit.tight, child: SizedBox()),
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
                              style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    const Text(
                      'Item Quantity ',
                      style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const Flexible(fit: FlexFit.tight, child: SizedBox()),
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
                              style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
                child: const Row(
                  children: [
                    Text(
                      'Current Stock :1.00 ',
                      style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
                width: 500,
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
                        child: const Padding(
                          padding: EdgeInsets.all(8),
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
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    const Text(
                      'Description ',
                      style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const Flexible(fit: FlexFit.tight, child: SizedBox()),
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
                              style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
