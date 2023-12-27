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
        leading: BackButton(),
        title: Text('Business Detail'),
        // title: Row(
        //   children: [
        //     const SizedBox(
        //       width: 10,
        //     ),
        //     InkWell(
        //       onTap: () => Navigator.pop(context),

        //       // Navigator.push(
        //       // context,
        //       // MaterialPageRoute(
        //       //     builder: (context) => const settingsview())),
        //       child: const Icon(
        //         Icons.arrow_back,
        //         size: 30,
        //       ),
        //     ),
        //   ],
        // ),
        // ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 12),
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
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(60)),
                          child: const Icon(
                            Icons.image,
                            size: 50,
                          )),
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
                          "Email: ab@gmail.com  ",
                          style: TextStyle(color: Colors.blue, fontSize: 13),
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
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                Container(
                  height: 60,
                  width: 450,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration.collapsed(hintText: 'Enter Business name'),
                        style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  "Address * ",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                Container(
                  height: 60,
                  width: 450,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration.collapsed(hintText: 'Enter address'),
                        style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  "Phone number * ",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                Container(
                  height: 60,
                  width: 450,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration.collapsed(hintText: 'Enter Phone number'),
                        style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  "Currency * ",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
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
                    height: 50,
                    width: 400,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        selectedcurrency,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff54854C),
                  ),
                  height: 50,
                  width: 400,
                  child: Center(
                    child: TextButton(
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          const Color(0xff54854C),
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
