import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/model/TendentModel.dart';

class viewmergedetails extends StatefulWidget {
  final TendentModel data;
  const viewmergedetails({super.key, required this.data});

  @override
  State<viewmergedetails> createState() => _viewmergedetailsState();
}

class _viewmergedetailsState extends State<viewmergedetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        // centerTitle: true,
        title: Text(
          "View Details",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Container(
        // color: Colors.purpleAccent,
        child: SafeArea(
          child: Column(
            children: [
              //PageName(name: "View Admission"),

              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.1,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    // borderRadius:3
                    //BorderRadius.all(5)
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Color.fromARGB(255, 78, 78, 78),
                    //     offset: Offset(5, 5),
                    //     blurRadius: 15,
                    //   ),
                    // ],
                  ),
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 14, right: 10, left: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Text(
                                          widget.data.tenantName,
                                          style: TextStyle(fontSize: 21, color: Colors.purpleAccent, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          widget.data.phone,
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          "Email : " + widget.data.email,
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          "Created  : " + widget.data.createdAt,
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       bottom: 10, right: 15),
                                  //   child: InkWell(
                                  //     child: Text(
                                  //       "View All",
                                  //       style: TextStyle(
                                  //           fontWeight: FontWeight.bold),
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                              SizedBox(height: 5
                                  // MediaQuery.of(context).size.height / 70,
                                  ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 1,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black54.withOpacity(0.2)), borderRadius: BorderRadius.circular(40)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Advance amount ",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          widget.data.advanceAmount,
                                          style: TextStyle(color: Colors.green, fontSize: 18),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(10.0),
                              //   child: Container(
                              //     //  height: 60,
                              //     width: MediaQuery.of(context).size.width /
                              //         2.5,
                              //     decoration: BoxDecoration(
                              //       //color: Colors.amber,
                              //         border: Border.all(
                              //             color: Colors.black54
                              //                 .withOpacity(0.2)),
                              //         borderRadius:
                              //         BorderRadius.circular(40)),
                              //     child: Padding(
                              //       padding: const EdgeInsets.symmetric(
                              //           horizontal: 12.0, vertical: 5),
                              //       child: Column(
                              //         mainAxisAlignment:
                              //         MainAxisAlignment.center,
                              //         children: const [
                              //           Text(
                              //             "Paid Fee ",
                              //             style: TextStyle(fontSize: 18),
                              //           ),
                              //           Text(
                              //             "3000",
                              //             style: TextStyle(
                              //                 color: Colors.green,
                              //                 fontSize: 18),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(height: 5
                                  // MediaQuery.of(context).size.height / 70,
                                  ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.only(
                              //           right: 30, bottom: 10),
                              //       child: Icon(
                              //         Icons.call,
                              //         color: Colors.purpleAccent,
                              //       ),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      );
                    },
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
