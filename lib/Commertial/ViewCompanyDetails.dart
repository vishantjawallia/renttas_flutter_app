// ignore_for_file: use_super_parameters, must_be_immutable

import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/Commertial/NewContactadd.dart';
import 'package:renttas_flutter_app/landlord/lanlordProfile.dart';

import 'AddNewpropertytenant.dart';
import 'Addfornewsale.dart';
import 'AddnewProperty.dart';
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
  int? tabValue = 0;
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
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        automaticallyImplyLeading: false,
        leading: const BackButton(),
        elevation: 0,
        title: const Text(
          "View Details",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(bottom: 0),
                    decoration: BoxDecoration(
                      color: const Color(0xff54854C).withOpacity(0.25),
                      borderRadius: const BorderRadius.only(
                          // bottomLeft: Radius.circular(30),
                          // bottomRight: Radius.circular(30),
                          // topLeft: Radius.circular(30),
                          // topRight: Radius.circular(30),
                          ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          color: Colors.white,
                          padding: const EdgeInsets.only(top: 18, left: 20, right: 20),
                          child: Column(
                            children: [
                              Text(
                                widget.name.capitalizeFirstWord(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.address,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 18),
                            ],
                          ),
                        ),
                        const Divider(height: 0.1, thickness: 2, color: Colors.white),
                        // const SizedBox(width: 0.0, height: 18),
                        Container(
                          child: TabBar(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            isScrollable: true,
                            onTap: (value) {
                              // tabController.index = value;
                              setState(() {
                                tabValue = value;
                              });
                            },
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabAlignment: TabAlignment.start,
                            labelStyle: const TextStyle(fontSize: 16),
                            indicator: BoxDecoration(
                              // border: Border.all(width: 4, color: const Color(0xff54854C)),
                              // borderRadius: BorderRadius.circular(6),
                              color: const Color(0xff54854C),
                            ),
                            labelColor: Colors.white,
                            // labelColor: const Color(0xff54854C),
                            unselectedLabelColor: Colors.black,
                            controller: tabController,
                            tabs: const [
                              Tab(child: Text('Leace')),
                              Tab(
                                child: Text('Property'),
                              ),
                              Tab(
                                child: Text('Forsale'),
                              ),
                              Tab(
                                child: Text('PropertyTenant'),
                              ),
                              Tab(
                                child: Text('Contact'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          LeacePage(
                            id: widget.id,
                            name: widget.name,
                            address: widget.address,
                          ),
                          _propertyTab(context),
                          _forSaleTab(context),
                          _propertyTanentTab(context),
                          _contactTab(context),
                        ],
                      ),
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

  Column _contactTab(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Contact details",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewContactAdd(),
                ),
              ),
              icon: const Icon(
                Icons.add_box_rounded,
                size: 30,
              ),
              color: const Color(0xff54854C),
            )
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 86,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mobile No : +91 7852463258",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Email: abcd@gmail.com ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _propertyTanentTab(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Property tenant",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddNewPropertyTenant(),
                ),
              ),
              icon: const Icon(
                Icons.add_box_rounded,
                size: 30,
              ),
              color: const Color(0xff54854C),
            )
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 86,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Co start group",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "GD1,GD2,GD3....",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.delete_outline, color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Column _forSaleTab(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Sale",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddForNewSale()));
              },
              icon: const Icon(
                Icons.add_box_rounded,
                size: 30,
              ),
              color: const Color(0xff54854C),
            )
          ],
        ),
        const SizedBox(height: 10),
        const Center(
            child: Text(
          "Forsale",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        )),
        const SizedBox(height: 20),
      ],
    );
  }

  Column _propertyTab(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Property",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddNewProperty(),
                ),
              ),
              icon: const Icon(
                Icons.add_box_rounded,
                size: 30,
              ),
              color: const Color(0xff54854C),
            )
          ],
        ),
        const SizedBox(height: 20),
        const Center(
          child: Text(
            "Property",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Future signUp() async {}
}
