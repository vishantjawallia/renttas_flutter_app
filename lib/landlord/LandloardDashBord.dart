// ignore_for_file: prefer_const_constructors, avoid_print, prefer_interpolation_to_compose_strings, deprecated_member_use, unused_local_variable, unnecessary_overrides, unnecessary_null_comparison, avoid_unnecessary_containers, use_build_context_synchronously, sort_child_properties_last, use_super_parameters

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/landlord/NotificationView.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Common/ApiUrl.dart';
import '../Premium/PremumScreen.dart';
import '../Tabs/AboutTab.dart';
import '../Tabs/BillsTabs.dart';
import '../Tabs/DocumentsTab.dart';
import '../Tabs/ExpensesTab.dart';
import '../Tabs/TenantsTab.dart';
import '../model/Property.dart';
import '../model/SubProperty.dart';
import '../widgets/custom_ modal_progress_hud.dart';
import 'AddSubproperties.dart';
import 'LandlordAddProperty.dart';
import 'lanlordProfile.dart';

class LandloardDashBord extends StatefulWidget {
  const LandloardDashBord({Key? key}) : super(key: key);

  @override
  State<LandloardDashBord> createState() => _LandloardDashBordState();
}

class _LandloardDashBordState extends State<LandloardDashBord> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool isLoading = false;
  bool isSubproperty = false;
  bool alldt = false;

  static String firstName = '';
  static String landlordId = '';
  String selectedPropertyName = '';
  String selectedSubpropertyName = '';
  String selectedSubPropertyId = '';

  int selectedSubProperties = 0;
  List<Property> propertyLists = [];
  List<SubProperty> selectedSubProperty = [];
  String selectedPropertyId = '';
  bool loadTabBar = false;

  // String selectedSubProperty = '';
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    loadData();
    _tabController = TabController(length: 5, vsync: this);

    super.initState();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('name') ?? '';
      log(firstName.toString());
      landlordId = prefs.getString('userId') ?? '';
      log(landlordId.toString());
    });
    await loadPropertyList(landlordId);
  }

  void navigateToFirstTab() {
    if (_tabController.index != 0) {
      _tabController.animateTo(0);
    } else {
      _tabController.animateTo(1);
    }
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: ListView.builder(
                    itemCount: propertyLists.length,
                    padding: EdgeInsets.only(top: 10),
                    itemBuilder: (BuildContext context, int index) {
                      Property property = propertyLists[index]; // Assuming propertyLists is List<Property>

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () async {
                            setState(() {
                              selectedPropertyName = property.propertyName;
                              selectedPropertyId = property.id;

                              selectedSubProperty = property.subProperties;

                              if (property.subProperties.isNotEmpty) {
                                SubProperty firstSubProperty = property.subProperties[0];
                                selectedSubpropertyName = firstSubProperty.subPropertyName;
                                selectedSubPropertyId = firstSubProperty.id;
                                print("First Sub-Property: ${firstSubProperty.subPropertyName}");
                                print("First Sub-Property: ${firstSubProperty.id}");
                                //     assignFirst(selectedSubPropertyId,);
                                isSubproperty = true;
                              } else {
                                removeItemFromSharedPreferences("selectedSubProptyId");
                                removeItemFromSharedPreferences("selectedSubPropertyName");
                                isSubproperty = false;
                              }
                            });

                            await saveSelectedPropertyId(selectedPropertyId, selectedPropertyName);
                            Navigator.of(context).pop();
                            navigateToFirstTab();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                                // color: Colors.grey.shade300,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    property.propertyName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  selectedPropertyName == property.propertyName ? const Icon(Icons.add_task) : SizedBox(),
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff54854C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LandlordAddProperty()));
                    },
                    child: Text(
                      'Add Property',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 0.0, height: 30),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // log("aaaaa");
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return WillPopScope(
      onWillPop: () async {
        return await _showExitConfirmationDialog(context);
      },
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Color(0xff54854C),
            toolbarHeight: isSubproperty ? screenHeight * 0.28 : screenHeight * 0.20,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              Container(
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Container(
                                  margin: EdgeInsets.only(left: 1),
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const lanlordProfile()),
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 22,
                                      child: Text(
                                        firstName.isEmpty ? "A" : (firstName).substring(0, 1).toUpperCase(),
                                        style: TextStyle(
                                          color: Color(0xff54854C),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: isLoading
                                      ? SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 3))
                                      : InkWell(
                                          borderRadius: BorderRadius.circular(6),
                                          onTap: () => _openBottomSheet(context),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 6, top: 4, bottom: 4, right: 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  height: 42.5,
                                                  child: Text(
                                                    selectedPropertyName,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 18,
                                                    ),
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                ),
                                                Icon(Icons.arrow_drop_down, size: 34)
                                              ],
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(6),
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => notificationview())),
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    child: Icon(
                                      Icons.notification_add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8, height: 0),
                                InkWell(
                                  borderRadius: BorderRadius.circular(6),
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => premiumescreen())),
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.orange),
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          alignment: Alignment.center,
                                          child: Text(
                                            ' Premium',
                                            style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "title".tr().toString().toUpperCase(),
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              // TODO: ask for add property how this functionality work'

                              InkWell(
                                borderRadius: BorderRadius.circular(6),
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddSubproperties(selectedId: selectedPropertyId))),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.add_box, size: 26, color: Colors.white),
                                      SizedBox(width: 6, height: 0.0),
                                      Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          'ADD ROOM',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        if (isSubproperty)
                          Align(
                            alignment: Alignment.topLeft,
                            child: StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // when click on all it will get all datas under the property
                                          setState(() {
                                            alldt = true;
                                          });
                                        },
                                        child: Container(
                                          decoration: alldt == false
                                              ? BoxDecoration(border: Border.all(width: 1, color: Colors.white), borderRadius: BorderRadius.circular(4))
                                              : BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                                          margin: const EdgeInsets.only(left: 10),
                                          padding: const EdgeInsets.all(10),
                                          height: 38,
                                          // p
                                          // color: Colors.greenAccent,
                                          child: Text(
                                            "All",
                                            style: TextStyle(color: alldt == true ? Colors.black : Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Align(
                                        heightFactor: 1.55,
                                        alignment: Alignment.center,
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          height: 22,
                                          width: 2,
                                        ),
                                      ),
                                      SizedBox(width: 2),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: List.generate(
                                          selectedSubProperty.length,
                                          (index) => GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                alldt = false;

                                                var firstElementIndex = selectedSubProperty[0];

                                                print("Index of first element: $firstElementIndex");
                                                selectedSubProperties = index;
                                                selectedSubpropertyName = selectedSubProperty[index].subPropertyName;
                                                selectedSubPropertyId = selectedSubProperty[index].id;
                                                print("selectedSubpropertyID: $selectedPropertyId");
                                                navigateToFirstTab();
                                              });
                                              await saveSelectedSubProperty(selectedSubPropertyId, selectedSubpropertyName);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              margin: const EdgeInsets.only(left: 14),
                                              padding: const EdgeInsets.all(8),
                                              height: 38,
                                              decoration: alldt == false
                                                  ? index == selectedSubProperties
                                                      ? BoxDecoration(
                                                          color: Color.fromARGB(255, 229, 175, 26),
                                                          borderRadius: BorderRadius.circular(4),
                                                          border: Border.all(width: 1.5, color: Color.fromARGB(255, 229, 175, 26)),
                                                        )
                                                      : BoxDecoration(
                                                          border: Border.all(color: Color.fromARGB(255, 229, 175, 26), width: 1.5),
                                                          borderRadius: BorderRadius.circular(4),
                                                        )
                                                  : BoxDecoration(
                                                      border: Border.all(color: Colors.black, width: 1.5),
                                                      borderRadius: BorderRadius.circular(4),
                                                    ),
                                              // color:
                                              //     index == selectedSubProperties
                                              //         ? Colors.blueAccent
                                              //         : Colors.white,
                                              child: Text(
                                                selectedSubProperty[index].subPropertyName,
                                                style: TextStyle(
                                                  color: index == selectedSubProperties ? Colors.black : Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 6),
                color: Colors.white,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    padding: EdgeInsets.all(5),
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabAlignment: TabAlignment.start,
                    labelStyle: TextStyle(
                      fontSize: 18,
                    ),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                      border: Border(
                        bottom: BorderSide(color: Color(0xff54854C), width: 4.0),
                        top: BorderSide(color: Color(0xff54854C), width: 0),
                        left: BorderSide(color: Color(0xff54854C), width: 0),
                        right: BorderSide(color: Color(0xff54854C), width: 0),
                      ),
                    ),
                    labelColor: const Color(0xff54854C),
                    unselectedLabelColor: Colors.black,
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Bills'),
                      Tab(text: 'Tenants'),
                      Tab(text: 'Expenses'),
                      Tab(text: 'Documents'),
                      Tab(text: 'About'),
                    ],
                  ),
                ),
              ),
              // if (loadTabBar && selectedSubProperty.isNotEmpty)
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    BillsTabs(data: isSubproperty),
                    TenantsTab(),
                    ExpensesTab(),
                    DocumentsTab(),
                    AboutTab(),
                  ],
                ),
              ),
              //  if (!loadTabBar) CircularProgressIndicator(color: Color(0xff54854C),),
            ],
          ),
        ),
      ),
    );
  }

  String getCurrency() {
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
    return format.currencySymbol;
  }

  Future<void> loadPropertyList(String landlordId) async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM tocken====" + token!);
    log("sdddddddddddddddddddd==" + landlordId.toString());
    print("sssssss===" + WidgetsBinding.instance.window.locale.countryCode.toString());
    String counrtycode = WidgetsBinding.instance.window.locale.countryCode.toString();
    String aaa = getCurrency();
    print("sssssssasasasa===" + aaa);

    setState(() {
      isLoading = true;
    });
    propertyLists.clear();

    final Map<String, dynamic> requestData = {"landlordId": landlordId, "fcmtocken": token, "countrycode": counrtycode, "currencysymbol": aaa};

    final headers = {
      'Content-Type': 'application/json',
    };
    final request = http.Request('POST', Uri.parse(ApiUrl.getPropertyUserID))
      ..headers.addAll({
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
    request.body = jsonEncode(requestData);
    final response = await request.send();

    final stream = response.stream;
    final body = await stream.bytesToString();

    final data = jsonDecode(body);
    log("assssssssssssssssssss===" + data.toString());
    List<dynamic>? dataList = data['data'];
    if (dataList != null) {
      final List<dynamic> jsonData = dataList;

      propertyLists = jsonData.map((propertyJson) {
        final List<dynamic> subPropertyData = propertyJson['subproperty'];
        final List<SubProperty> subProperties = subPropertyData.map((subPropertyJson) => SubProperty.fromJson(subPropertyJson)).toList();

        return Property(
          id: propertyJson['id'],
          propertyName: propertyJson['propertyName'],
          subProperties: subProperties,
        );
      }).toList();

      if (propertyLists.isNotEmpty) {
        Property firstProperty = propertyLists[0];
        selectedPropertyName = firstProperty.propertyName;
        selectedPropertyId = firstProperty.id;
        print("First Property: ${firstProperty.propertyName}");
        if (firstProperty.subProperties.isNotEmpty) {
          SubProperty firstSubProperty = firstProperty.subProperties[0];
          selectedSubpropertyName = firstSubProperty.subPropertyName;
          selectedSubPropertyId = firstSubProperty.id;
          selectedSubProperty = firstProperty.subProperties;
          setState(() {
            isSubproperty = true;
          });
          // Savesubpropsave()
          print("First Sub-Property: ${firstSubProperty.subPropertyName}");
        } else {
          setState(() {
            isSubproperty = false;
          });
          print("No sub-properties available for the first property.");
        }
      } else {
        print("No properties available.");
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('selectedPropertyId', selectedPropertyId);
      await prefs.setString('selectedPropertyName', selectedPropertyName);
      await prefs.setString('selectedSubProptyId', selectedSubPropertyId);
      await prefs.setString('selectedSubPropertyName', selectedSubpropertyName);
    }
    setState(() {
      isLoading = false; // Set loading state to false after the data is loaded
    });
  }

  Future<void> saveSelectedPropertyId(String selectedPropertyId, String selectedPropertyName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool valueExists = prefs.containsKey('selectedPropertyId');
    bool valueExistss = prefs.containsKey('selectedPropertyId');
    if (valueExists) {
      await prefs.setString('selectedPropertyId', selectedPropertyId);
    }
    if (valueExistss) {
      await prefs.setString('selectedPropertyName', selectedPropertyName);
    }
  }

  Future<void> saveSelectedSubProperty(String selectedPropertyId, String selectedSubpropertyName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool valueExists = prefs.containsKey('selectedSubProptyId');
    bool valueExistss = prefs.containsKey('selectedSubPropertyName');
    if (valueExists) {
      await prefs.setString('selectedSubProptyId', selectedPropertyId);
    }
    if (valueExistss) {
      await prefs.setString('selectedSubPropertyName', selectedPropertyName);
    }
  }

  assignFirst(String subPropertyId) {
    print('First Property: $subPropertyId');
    updateSharedPreferences("selectedSubProptyId", subPropertyId);
  }

  Future<void> updateSharedPreferences(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<void> removeItemFromSharedPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    bool shouldExit = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Exit'),
          content: Text('Are you sure you want to exit?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                shouldExit = false;
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Exit'),
              onPressed: () {
                shouldExit = true;
                exit(0);
                // Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );

    return shouldExit;
  }
}
