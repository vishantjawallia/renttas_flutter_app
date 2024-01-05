// ignore_for_file: unnecessary_,  unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddBuisnes extends StatefulWidget {
  const AddBuisnes({super.key});

  @override
  State<AddBuisnes> createState() => _AddBuisnesState();
}

class _AddBuisnesState extends State<AddBuisnes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        automaticallyImplyLeading: false,
        leading: const BackButton(),
        title: Row(
          children: [
            Text("Add Buisness"),
            const Flexible(fit: FlexFit.tight, child: SizedBox()),
            InkWell(
              onTap: () => {},
              child: Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Save",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff54854C),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Column(
            children: [
              const SizedBox(height: 15),
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Text(
                      'Buisness Name * ',
                      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Flexible(fit: FlexFit.tight, child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 180,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration.collapsed(hintText: 'Enter Buisness name'),
                              style: TextStyle(fontSize: 14, color: Colors.black),
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
                    Text(
                      'Addess',
                      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Flexible(fit: FlexFit.tight, child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 180,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration.collapsed(hintText: 'Enter Address'),
                              style: TextStyle(fontSize: 14, color: Colors.black),
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
                    Text(
                      'Email',
                      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Flexible(fit: FlexFit.tight, child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 180,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: TextField(
                                decoration: InputDecoration.collapsed(hintText: 'Enter Buisness email'),
                                style: TextStyle(fontSize: 14, color: Colors.black),
                              ),
                            )),
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
                    Text(
                      'Website',
                      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Flexible(fit: FlexFit.tight, child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 180,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration.collapsed(hintText: 'Enter Buisness web'),
                              style: TextStyle(fontSize: 14, color: Colors.black),
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
                    Text(
                      'Phone',
                      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Flexible(fit: FlexFit.tight, child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 180,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration.collapsed(hintText: 'Enter Buisness phone'),
                              style: TextStyle(fontSize: 14, color: Colors.black),
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
                    Text(
                      'Fax',
                      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Flexible(fit: FlexFit.tight, child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 180,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration.collapsed(hintText: 'Enter Buisness fax'),
                              style: TextStyle(fontSize: 14, color: Colors.black),
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
