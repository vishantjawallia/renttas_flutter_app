// ignore_for_file: use_super_parameters, must_be_immutable

import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/Commertial/NewContactadd.dart';

import 'AddNewpropertytenant.dart';
import 'Addfornewsale.dart';
import 'AddnewProperty.dart';
import 'CommertialDashboard.dart';
import 'TapBarClasses/Leace.dart';

class ViewCompanyDetails extends StatefulWidget {
  String id, name, address;

  ViewCompanyDetails({
    Key? key,
    required this.id,
    required this.name,
    required this.address,
  }) : super(key: key);

  @override
  State<ViewCompanyDetails> createState() => _ViewCompanyDetailsState();
}

class _ViewCompanyDetailsState extends State<ViewCompanyDetails> with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;
  late TabController tabController;

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: false,
        actions: [
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
                  child: const Icon(Icons.arrow_back, size: 30),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.address,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 25),
                  TabBar(
                    controller: tabController,
                    isScrollable: true,
                    tabs: [
                      Container(
                        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Tab(text: 'Leace', height: 30),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Tab(
                            text: 'Property',
                            height: 30,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Tab(
                            text: 'Forsale',
                            height: 30,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Tab(
                            text: 'PropertyTenant',
                            height: 30,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Tab(
                            text: 'Contact',
                            height: 30,
                          ),
                        ),
                      ),
                    ],
                    labelColor: Colors.white,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        LeacePage(
                          id: widget.id,
                          name: widget.name,
                          address: widget.address,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Property"),
                                IconButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AddNewProperty(),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.add_box_rounded,
                                  ),
                                  color: Colors.blue,
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Center(child: Text("Property")),
                            const SizedBox(height: 20),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Sale"),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddForNewSale()));
                                  },
                                  icon: const Icon(
                                    Icons.add_box_rounded,
                                  ),
                                  color: Colors.blue,
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Center(child: Text("Forsale")),
                            const SizedBox(height: 20),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Property tenant"),
                                IconButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AddNewPropertyTenant(),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.add_box_rounded,
                                  ),
                                  color: Colors.blue,
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(25),
                              ),
                              height: 120,
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Co start group",
                                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                        const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "GD1,GD2,GD3....",
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                                          ),
                                        ),
                                        //  Flexible(fit: FlexFit.tight, child: SizedBox()),
                                      ],
                                    ),
                                    const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey,
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Icon(Icons.edit),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          InkWell(
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey,
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Icon(Icons.delete_outline),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Contact details"),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NewContactAdd()));
                                  },
                                  icon: const Icon(
                                    Icons.add_box_rounded,
                                  ),
                                  color: Colors.blue,
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 130,
                                width: 400,
                                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(25)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mobile No : +91 7852463258",
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Email: abcd@gmail.com ",
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                                      ),
                                      const SizedBox(height: 5),
                                      const Flexible(fit: FlexFit.tight, child: SizedBox()),
                                      Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey,
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Icon(Icons.edit),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            InkWell(
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey,
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Icon(Icons.delete_outline),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signUp() async {}
}
