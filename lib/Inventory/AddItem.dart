// ignore_for_file: prefer_const_literals_to_create_immutables,  camel_case_types

import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/Inventory/NewItem.dart';

import 'Filtertransaction.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        leading: const BackButton(),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Add Item"),
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
                  Icons.search,
                  size: 25,
                ),
              ),
            )
          ],
        ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Material(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                elevation: 5,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewItem(),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 70,
                    width: 500,
                    child: Row(
                      children: [
                        Text(
                          "product1",
                          style: const TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        const Flexible(fit: FlexFit.tight, child: SizedBox()),
                        Text(
                          "0.00",
                          style: const TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Material(
                borderRadius: BorderRadius.circular(8),
                elevation: 5,
                color: Colors.white,
                child: Container(
                  height: 70,
                  width: 500,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "product2",
                        style: const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      const Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Text(
                        "1.00",
                        style: const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
