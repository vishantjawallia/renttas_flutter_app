// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class JoinBuisnessPage extends StatefulWidget {
  const JoinBuisnessPage({super.key});

  @override
  State<JoinBuisnessPage> createState() => _JoinBuisnessPageState();
}

class _JoinBuisnessPageState extends State<JoinBuisnessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        automaticallyImplyLeading: false,
        leading: const BackButton(),
        title: Row(
          children: [
            Text("Join To Buisness"),
            const Flexible(fit: FlexFit.tight, child: SizedBox()),
            InkWell(
              onTap: () => {},
              child: Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Save",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff54854C),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Text(
                'To Join Buisness Enter The Buisness Code',
                style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                'OR',
                style: const TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                'Scan QR Code',
                style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    'Your Name',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 185,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: TextField(
                            decoration: InputDecoration.collapsed(
                              hintText: 'Enter your name',
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    ' Your Name',
                    style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 145,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: TextField(
                                decoration: InputDecoration.collapsed(hintText: 'Enter your name'),
                                style: TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.qr_code_scanner_outlined,
                          size: 30,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 35),
              Text(
                'You Can Get This Code For Newly Buisness',
                style: const TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
