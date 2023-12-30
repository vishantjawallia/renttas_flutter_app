// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, avoid_unnecessary_containers, camel_case_types

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:renttas_flutter_app/Inventory/LowStock.dart';
// import 'package:renttas_flutter_app/Inventory/Transactions.dart';
// import 'package:renttas_flutter_app/Inventory/Storeview.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'DrawerItems.dart';
// import 'MyBuisness.dart';
// import 'ProductInOut.dart';
// import 'ProductView.dart';
// import 'ViewQutation.dart';

// class inentorydashboard extends StatefulWidget {
//   const inentorydashboard({super.key});

//   @override
//   State<inentorydashboard> createState() => _inentorydashboardState();
// }

// class _inentorydashboardState extends State<inentorydashboard> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   String email="",name="";

//   getshareddata() async {
//     SharedPreferences preferences=await SharedPreferences.getInstance();
//     setState(() {
//       email=preferences.getString('email')!;
//       name=preferences.getString('name')!;
//     });

//   }
//   @override
//   void initState() {

//     super.initState();
//     getshareddata();
//   }

//   @override
//   Widget build(BuildContext context) {
//     log("dddddddd");
//     return Scaffold(
//         key: _scaffoldKey,
//         drawer: new DrawerItems(),
//         backgroundColor: Colors.grey[300],
//         appBar: AppBar(
//           backgroundColor: Colors.grey[300],
//           // flexibleSpace: Container(
//           //   decoration: const BoxDecoration(
//           //  color: grey[300],
//           //   ),
//           // ),
//           automaticallyImplyLeading: false,
//           actions: <Widget>[
//             Container(
//               child: Expanded(
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 10,
//                     ),
//                     InkWell(
//                       onTap: () {
//                         _scaffoldKey.currentState?.openDrawer();
//                       },
//                       child: Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(40)),
//                           //alignment: Alignment.center,
//                           child: Icon(
//                             Icons.menu_open,
//                             size: 20,
//                           )
//                           // Text(
//                           //   'Premium',
//                           //   style: TextStyle(
//                           //     fontSize: 18,
//                           //     fontWeight: FontWeight.bold,
//                           //   ),
//                           //   textAlign: TextAlign.center,
//                           // ),
//                           ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                         Text(name),
//                           // Text(
//                           //     "",
//                           //   style: TextStyle(fontWeight: FontWeight.bold),
//                           // )
//                         ],
//                       ),
//                     ),
//                     Flexible(fit: FlexFit.tight, child: SizedBox()),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: InkWell(
//                         onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const MyBusinessPage())),
//                         child: Container(
//                             padding: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(40)),
//                             //alignment: Alignment.center,
//                             child: Icon(
//                               Icons.person_2_rounded,
//                               size: 20,
//                             )
//                             // Text(
//                             //   'Premium',
//                             //   style: TextStyle(
//                             //     fontSize: 18,
//                             //     fontWeight: FontWeight.bold,
//                             //   ),
//                             //   textAlign: TextAlign.center,
//                             // ),
//                             ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               color: Colors.white10,
//               child: Column(
//                 children: [
//                   Stack(children: [
//                     Container(
//                       height: 350,
//                       decoration: BoxDecoration(
//                           color: Colors.blue[300],
//                           borderRadius: BorderRadius.circular(40)),
//                       child: Padding(
//                         padding:
//                             EdgeInsets.only(bottom: 30, right: 20, left: 20),
//                         child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Flexible(
//                                 child: InkWell(
//                                   onTap: () => Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                              productinout(type: "1",)),
//                                   ),
//                                   child: Container(
//                                     height: 50,
//                                     width:
//                                         MediaQuery.of(context).size.width / 2,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                       color: Colors.white,
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(Icons.add_circle_outline),
//                                         SizedBox(
//                                           width: 5,
//                                         ),
//                                         Text(
//                                           "Product In",
//                                           style: TextStyle(fontSize: 15),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Flexible(
//                                 child: InkWell(
//                                   onTap: () => Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                                productinout(type:"0"))),
//                                   child: Container(
//                                     height: 50,
//                                     width:
//                                         MediaQuery.of(context).size.width / 2,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                       color: Colors.white,
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(Icons.add_circle_outline),
//                                         SizedBox(
//                                           width: 5,
//                                         ),
//                                         Text(
//                                           "Product Out",
//                                           style: TextStyle(fontSize: 15),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ]),
//                       ),
//                     ),
//                     Container(
//                       // color: Colors.white,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(40),
//                         color: Colors.white,
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(15),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Overview",
//                                 style: TextStyle(
//                                   color: Colors.indigoAccent,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 )),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.download,
//                                   color: Colors.greenAccent,
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text("Total In"),
//                                 Flexible(fit: FlexFit.tight, child: SizedBox()),
//                                 Text(
//                                   '1.00',
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 9,
//                             ),
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.upload,
//                                   color: Colors.orangeAccent[200],
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text("Total Out"),
//                                 Flexible(fit: FlexFit.tight, child: SizedBox()),
//                                 Text(
//                                   '0.00',
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 9,
//                             ),
//                             Row(
//                               children: [
//                                 Icon(Icons.propane_sharp,
//                                     color: Colors.deepPurple[200]),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text("Products"),
//                                 Flexible(fit: FlexFit.tight, child: SizedBox()),
//                                 Text(
//                                   '1.00',
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 9,
//                             ),
//                             Row(
//                               children: [
//                                 Icon(Icons.low_priority,
//                                     color: Colors.pink[200]),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text("Low Stocks"),
//                                 Flexible(fit: FlexFit.tight, child: SizedBox()),
//                                 Text(
//                                   '0.00',
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 9,
//                             ),
//                             Row(
//                               children: [
//                                 Icon(Icons.handshake,
//                                     color: Colors.purpleAccent),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text("In Hand"),
//                                 Flexible(fit: FlexFit.tight, child: SizedBox()),
//                                 Text(
//                                   '1.00',
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ]),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       InkWell(
//                         onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const productview())),
//                         child: Container(
//                           height: 150,
//                           width: 150,
//                           decoration: BoxDecoration(
//                               color: Colors.white70,
//                               borderRadius: BorderRadius.circular(15)),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.propane_sharp,
//                                   color: Colors.deepPurple[200],
//                                   size: 50,
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   "Products",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const LowStock())),
//                         child: Container(
//                           height: 150,
//                           width: 150,
//                           decoration: BoxDecoration(
//                               color: Colors.white70,
//                               borderRadius: BorderRadius.circular(15)),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.low_priority,
//                                   color: Colors.pink[200],
//                                   size: 50,
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   "Low Stocks",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       InkWell(
//                         onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     const viewtransactions())),
//                         child: Container(
//                           height: 150,
//                           width: 150,
//                           decoration: BoxDecoration(
//                               color: Colors.white70,
//                               borderRadius: BorderRadius.circular(15)),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.transcribe_sharp,
//                                   color: Colors.orangeAccent,
//                                   size: 50,
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   "Transactions",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           InkWell(
//                             onTap: () => Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const StoreView())),
//                             child: Container(
//                               height: 70,
//                               width: 150,
//                               decoration: BoxDecoration(
//                                   color: Colors.white70,
//                                   borderRadius: BorderRadius.circular(15)),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.store,
//                                       color: Colors.greenAccent,
//                                       size: 38,
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       "Stores",
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           InkWell(
//                             onTap: () => Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         const viewqutationmain())),
//                             child: Container(
//                               height: 70,
//                               width: 150,
//                               decoration: BoxDecoration(
//                                   color: Colors.white70,
//                                   borderRadius: BorderRadius.circular(15)),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.note_alt_rounded,
//                                       color: Colors.indigoAccent,
//                                       size: 38,
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       "Qutation",
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }
