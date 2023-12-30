import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddQutation.dart';

class AddClient extends StatefulWidget {
  const AddClient({super.key});

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //  color: grey[300],
        //   ),
        // ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Row(
            children: [
              const SizedBox(width: 10),
              InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const qutationview())),
                child: const Icon(Icons.arrow_back, size: 30),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Add Client"),
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
                        "Save",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    const Text(
                      ' Client Name * ',
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
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration.collapsed(hintText: 'Enter Client name'),
                              style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
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
                      'Address',
                      style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const Flexible(fit: FlexFit.tight, child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 180,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration.collapsed(hintText: 'Enter Address'),
                              style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
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
