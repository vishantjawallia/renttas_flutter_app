// ignore_for_file: unnecessary_new, prefer_const_constructors
import 'package:flutter/material.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff54854C),
        automaticallyImplyLeading: false,
        leading: BackButton(),
        title: Row(
          children: [
            Text("New Item"),
            Flexible(
              fit: FlexFit.tight,
              child: SizedBox(),
            ),
            InkWell(
              onTap: () => {},
              child: Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Add",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff54854C),
                        fontSize: 18,
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
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 15),
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Text(
                      ' Item Name * ',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Flexible(fit: FlexFit.tight, child: SizedBox()),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        width: 180,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              decoration: new InputDecoration.collapsed(hintText: 'hhh'),
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Text(
                      'Item pricee ',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Flexible(fit: FlexFit.tight, child: SizedBox()),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        width: 180,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              decoration: new InputDecoration.collapsed(hintText: '00'),
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Text(
                      'Item Quantity ',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Flexible(fit: FlexFit.tight, child: SizedBox()),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        width: 180,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              decoration: new InputDecoration.collapsed(hintText: '0.0'),
                              style: TextStyle(fontSize: 14, color: Colors.black54),
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
                child: Row(
                  children: [
                    Text(
                      'Current Stock :1.00 ',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
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
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        width: 320,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
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
                                style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Text(
                      'Description ',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Flexible(fit: FlexFit.tight, child: SizedBox()),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        width: 180,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              decoration: new InputDecoration.collapsed(hintText: 'hhhj'),
                              style: TextStyle(fontSize: 14, color: Colors.black54),
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
