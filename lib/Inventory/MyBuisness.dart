// ignore_for_file: sort_child_properties_last, avoid_print, avoid_unnecessary_containers, camel_case_types

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';

class mybusinesspage extends StatefulWidget {
  const mybusinesspage({super.key});

  @override
  State<mybusinesspage> createState() => _mybusinesspageState();
}

String selectedcurrency = "Select Currency";

class _mybusinesspageState extends State<mybusinesspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        automaticallyImplyLeading: false,
        leading: const BackButton(),
        title: const Text('My Business'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: const Icon(
                          Icons.image,
                          size: 50,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          "Businesss Logo",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          "ab@gmail.com",
                          style: TextStyle(
                            color: Color(0xff54854C),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  "Buisness Name * ",
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 0.0, height: 4),
                Container(
                  height: 60,
                  width: 450,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration.collapsed(hintText: 'Enter Business name', hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                        style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  "Address * ",
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 60,
                  width: 450,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration.collapsed(hintText: 'Enter address', hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                        style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  "Phone number * ",
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 60,
                  width: 450,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Enter Phone number',
                          hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                        style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  "Currency * ",
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                InkWell(
                  onTap: () {
                    showCurrencyPicker(
                      context: context,
                      showFlag: true,
                      showSearchField: true,
                      showCurrencyName: true,
                      showCurrencyCode: true,
                      favorite: ['eur'],
                      onSelect: (Currency currency) {
                        print('Select currency: ${currency.name}');
                        setState(() {
                          selectedcurrency = currency.name.toString();
                        });
                      },
                    );
                  },
                  child: Container(
                    height: 60,
                    width: 400,
                    alignment: Alignment.centerLeft,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        selectedcurrency,
                        style: "Select Currency" == selectedcurrency
                            ? const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black54)
                            : const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xff54854C),
                  ),
                  height: 55,
                  width: 400,
                  child: Center(
                    child: TextButton(
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Color(0xff54854C),
                        ),
                      ),
                      onPressed: () {},
                    ),
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
