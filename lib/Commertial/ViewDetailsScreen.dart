// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'CommertialDashboard.dart';

class ViewDetailScreen extends StatefulWidget {
  const ViewDetailScreen({super.key});

  @override
  State<ViewDetailScreen> createState() => _ViewDetailScreenState();
}

class _ViewDetailScreenState extends State<ViewDetailScreen> {
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
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CommerialDashboard(),
                    ),
                  ),
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
                      Text("View Details"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewDetailScreen())),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Company name 1",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 10),
              const Text(
                "ABCD line \n 123 flat \n snjhkhkjhk     ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Company name 1",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "ABCD line \n 123 flat \n snjhkhkjhk     ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(40)),
                          child: const Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
