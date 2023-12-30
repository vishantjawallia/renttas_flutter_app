// ignore_for_file: prefer_const_constructors, avoid_print, prefer_interpolation_to_compose_strings, deprecated_member_use, unused_local_variable, unnecessary_overrides, unnecessary_null_comparison, avoid_unnecessary_containers, use_build_context_synchronously, sort_child_properties_last, use_super_parameters, unused_field, unused_element, prefer_null_aware_operators

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/landlord/NotificationView.dart';
import 'package:renttas_flutter_app/model/property_model.dart';
import 'package:renttas_flutter_app/model/subproperty_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../Common/ApiUrl.dart';
import '../Premium/PremumScreen.dart';
import '../Tabs/AboutTab.dart';
import '../Tabs/BillsTabs.dart';
import '../Tabs/DocumentsTab.dart';
import '../Tabs/ExpensesTab.dart';
import '../Tabs/TenantsTab.dart';
import '../model/BillModel.dart';
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

  // int selectedSubProperties = 0;
  List<PropertyModel> propertyLists = [];
  List<SubPropertyModel> selectedSubProperty = [];
  List<BIllModel> bills = [];
  String selectedPropertyId = '';
  bool loadTabBar = false;

  final _isbottomLoad = StreamController<bool>();
  Stream<bool> get _isbottomLoadStream => _isbottomLoad.stream;

  final GlobalKey _tabKey = GlobalKey();

  // String selectedSubProperty = '';
  @override
  void dispose() {
    _isbottomLoad.close();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);

    loadData();
    super.initState();
  }

  Future<void> loadData({bool reload = false}) async {
    if (reload) {
      setState(() => isLoading = true);
      bills = await fetchBillDate();
      setState(() => isLoading = false);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      firstName = prefs.getString('name') ?? '';
      landlordId = prefs.getString('userId') ?? '';
      propertyLists.clear();
      setState(() => isLoading = true);
      await loadPropertyList(landlordId);
      bills = await fetchBillDate();
      setState(() => isLoading = false);
    }
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
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
                      PropertyModel property = propertyLists[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            setState(() {
                              selectedPropertyName = property.propertyName!;
                              selectedPropertyId = property.id!;
                              selectedSubProperty = property.subproperty!;
                            });
                            await prefs.setString("selectedPropertyName", selectedPropertyName);
                            await prefs.setString("selectedPropertyId", selectedPropertyId);
                            if (property.subproperty!.isNotEmpty) {
                              SubPropertyModel sub = property.subproperty!.first;
                              setState(() {
                                selectedSubpropertyName = sub.subPropertyName!;
                                selectedSubPropertyId = sub.id!;
                                isSubproperty = true;
                              });
                              await prefs.setString("selectedSubPropertyId", selectedSubPropertyId);
                              await prefs.setString("selectedSubpropertyName", selectedSubpropertyName);
                            } else {
                              await prefs.setString("selectedSubpropertyName", '');
                              await prefs.setString("selectedSubPropertyId", '');
                              isSubproperty = false;
                            }

                            Navigator.of(context).pop();
                            if (_tabController.index != 0) _tabController.animateTo(0);
                            loadData(reload: true);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedPropertyName == property.propertyName ? Color(0xff54854C).withOpacity(0.2) : Colors.white,
                              border: Border.all(
                                width: 1,
                                color: selectedPropertyName == property.propertyName ? Color(0xff54854C).withOpacity(0.3) : Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  property.propertyName ?? "",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                selectedPropertyName == property.propertyName
                                    ? const Icon(
                                        Icons.check_circle_outline_sharp,
                                        color: Color(0xff54854C),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
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
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LandlordAddProperty()),
                    ),
                    child: Text(
                      "add_property".tr(),
                      // 'Add Property',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
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
            toolbarHeight: !isSubproperty ? 130 : 200,
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
                                Container(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: isLoading
                                      ? SizedBox(
                                          // width: 50.0,
                                          height: 40.0,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.grey.shade100.withOpacity(0.5),
                                            highlightColor: Colors.grey.shade300,
                                            child: Container(
                                              width: 120.0,
                                              height: 40.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        )
                                      // SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 3))
                                      : InkWell(
                                          borderRadius: BorderRadius.circular(6),
                                          onTap: () => _openBottomSheet(context),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 6, top: 4, bottom: 4, right: 0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: selectedPropertyName.length > 8 ? 90 : 72,
                                                  height: 42.5,
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    selectedPropertyName,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 18,
                                                    ),
                                                    textAlign: TextAlign.start,
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
                                        Icon(Icons.star, color: Color.fromARGB(255, 229, 175, 26)),
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          alignment: Alignment.center,
                                          child: Text(
                                            ' ' + "premium".tr(),
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 229, 175, 26),
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
                                    children: [
                                      Icon(Icons.add_box, size: 26, color: Colors.white),
                                      SizedBox(width: 6, height: 0.0),
                                      Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          "add_room".tr().toUpperCase(),
                                          // 'ADD ROOM',
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
                        SizedBox(height: isSubproperty ? 20 : 0),
                        if (isSubproperty)
                          Align(
                            alignment: Alignment.topLeft,
                            child:
                                // StatefulBuilder(
                                // builder: (BuildContext context, StateSetter setState) {
                                // return
                                SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () => setState(() => alldt = true),
                                      child: Container(
                                        decoration: alldt == false
                                            ? BoxDecoration(
                                                border: Border.all(width: 1.5, color: Colors.white),
                                                borderRadius: BorderRadius.circular(6),
                                              )
                                            : BoxDecoration(
                                                color: Color.fromARGB(255, 229, 175, 26),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                        padding: const EdgeInsets.all(10),
                                        height: 38,
                                        child: Text(
                                          "all".tr().toUpperCase(),
                                          // "All",
                                          style: TextStyle(
                                            color: alldt == true ? Colors.black : Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
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
                                    isLoading
                                        ? Padding(
                                            padding: const EdgeInsets.only(left: 14.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  // width: 50.0,
                                                  height: 38,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.grey.shade100.withOpacity(0.5),
                                                    highlightColor: Colors.grey.shade300,
                                                    child: Container(
                                                      width: 76,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                                SizedBox(
                                                  // width: 50.0,
                                                  height: 38,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.grey.shade100.withOpacity(0.5),
                                                    highlightColor: Colors.grey.shade300,
                                                    child: Container(
                                                      width: 76,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                                SizedBox(
                                                  // width: 50.0,
                                                  height: 38,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.grey.shade100.withOpacity(0.5),
                                                    highlightColor: Colors.grey.shade300,
                                                    child: Container(
                                                      width: 76,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: List.generate(
                                              selectedSubProperty.length,
                                              (index) => GestureDetector(
                                                onTap: () async {
                                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                  setState(() {
                                                    alldt = false;
                                                    // selectedSubProperties = index;
                                                    selectedSubpropertyName = selectedSubProperty[index].subPropertyName!;
                                                    selectedSubPropertyId = selectedSubProperty[index].id!;
                                                  });
                                                  await prefs.setString("selectedSubpropertyName", selectedSubpropertyName);
                                                  await prefs.setString("selectedSubPropertyId", selectedSubPropertyId);
                                                  if (_tabController.index != 0) _tabController.animateTo(0);
                                                  loadData(reload: true);
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  margin: const EdgeInsets.only(left: 14),
                                                  padding: const EdgeInsets.all(8),
                                                  height: 38,
                                                  decoration: alldt == false
                                                      ? selectedSubProperty[index].id! == selectedSubPropertyId
                                                          ? BoxDecoration(
                                                              color: Color.fromARGB(255, 229, 175, 26),
                                                              borderRadius: BorderRadius.circular(6),
                                                              border: Border.all(width: 1.5, color: Color.fromARGB(255, 229, 175, 26)),
                                                            )
                                                          : BoxDecoration(
                                                              color: Colors.grey.shade100.withOpacity(0.2),
                                                              border: Border.all(color: Colors.white, width: 1.5),
                                                              borderRadius: BorderRadius.circular(6),
                                                            )
                                                      : BoxDecoration(
                                                          // color: Colors.grey.shade100.withOpacity(0.2),
                                                          border: Border.all(color: Colors.white, width: 1.5),
                                                          borderRadius: BorderRadius.circular(6),
                                                        ),
                                                  child: Text(
                                                    selectedSubProperty[index].subPropertyName!,
                                                    // selectedSubProperty[index].subPropertyName,
                                                    style: TextStyle(
                                                      color: alldt == false ? (selectedSubProperty[index].id! == selectedSubPropertyId ? Colors.black : Colors.white) : Colors.white,
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
                              ),
                            ),
                            // },
                            // ),
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
                      border: Border(
                        bottom: BorderSide(color: Color(0xff54854C), width: 4.0),
                      ),
                    ),
                    labelColor: const Color(0xff54854C),
                    unselectedLabelColor: Colors.black,
                    controller: _tabController,
                    tabs: [
                      Tab(text: 'bills'.tr()),
                      Tab(text: 'tenants'.tr()),
                      Tab(text: 'expenses'.tr()),
                      Tab(text: 'documents'.tr()),
                      Tab(text: 'about'.tr()),
                    ],
                  ),
                ),
              ),
              // if (loadTabBar && selectedSubProperty.isNotEmpty)
              Expanded(
                child: TabBarView(
                  key: _tabKey,
                  controller: _tabController,
                  children: [
                    BillsTabs(
                      loading: isLoading,
                      list: bills,
                      // data: isSubproperty,
                    ),
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await FirebaseMessaging.instance.getToken();
    String counrtycode = WidgetsBinding.instance.window.locale.countryCode.toString();
    String getCurr = getCurrency();

    print("getCurr===>$getCurr");
    final Map<String, dynamic> requestData = {
      "landlordId": landlordId,
      "fcmtocken": token,
      "countrycode": counrtycode,
      "currencysymbol": getCurr,
    };

    final request = http.Request(
      'POST',
      Uri.parse(ApiUrl.getPropertyUserID),
    )..headers.addAll(
        {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
    request.body = jsonEncode(requestData);
    final response = await request.send();
    final stream = response.stream;
    final body = await stream.bytesToString();
    final data = jsonDecode(body);

    List<dynamic>? dataList = data['data'];

    if (dataList != null) {
      propertyLists = PropertyModel.fromJsonList(dataList);
      if (propertyLists.isNotEmpty) {
        String pId = prefs.getString('selectedPropertyId') ?? "";
        String pName = prefs.getString('selectedPropertyName') ?? "";

        if (pId.isNotEmpty && pName.isNotEmpty) {
          PropertyModel? firstProperty = propertyLists.where((element) => element.id == pId).isNotEmpty ? propertyLists.where((element) => element.id == pId).first : null;
          if (firstProperty != null) {
            setState(() {
              selectedSubProperty = firstProperty.subproperty!.toList();
              selectedPropertyName = pName;
              selectedPropertyId = pId;
            });
            print(selectedSubProperty.toString());
            if (firstProperty.subproperty!.isNotEmpty) {
              String pSubId = prefs.getString('selectedSubPropertyId') ?? "";
              String pSubName = prefs.getString('selectedSubpropertyName') ?? "";

              if (pSubId.isNotEmpty && pSubName.isNotEmpty) {
                SubPropertyModel? firstSubProperty = firstProperty.subproperty != null ? firstProperty.subproperty!.where((e) => e.id == pSubId).first : null;
                if (firstSubProperty?.id != null) {
                  setState(() {
                    selectedSubpropertyName = pSubName;
                    selectedSubPropertyId = pSubId;
                    isSubproperty = true;
                  });
                } else {
                  SubPropertyModel firstSubProperty = firstProperty.subproperty!.first;
                  setState(() {
                    selectedSubpropertyName = firstSubProperty.subPropertyName!;
                    selectedSubPropertyId = firstSubProperty.id!;
                    isSubproperty = true;
                  });
                  await prefs.setString('selectedSubPropertyId', selectedSubPropertyId);
                  await prefs.setString('selectedSubpropertyName', selectedSubpropertyName);
                }
              }
            }
          }
        } else {
          PropertyModel? firstProperty = propertyLists.first;
          setState(() {
            selectedSubProperty = firstProperty.subproperty!.toList();
            selectedPropertyId = firstProperty.id!;
            selectedPropertyName = firstProperty.propertyName!;
          });
          await prefs.setString('selectedPropertyId', selectedPropertyId);
          await prefs.setString('selectedPropertyName', selectedPropertyName);
          if (firstProperty.subproperty!.isNotEmpty) {
            SubPropertyModel firstSubProperty = firstProperty.subproperty!.first;
            setState(() {
              selectedSubpropertyName = firstSubProperty.subPropertyName!;
              selectedSubPropertyId = firstSubProperty.id!;
              isSubproperty = true;
            });
            await prefs.setString('selectedSubPropertyId', selectedSubPropertyId);
            await prefs.setString('selectedSubPropertyName', selectedSubpropertyName);
          }
        }
      }
    }
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
    bool valueExists = prefs.containsKey('selectedSubPropertyId');
    bool valueExistss = prefs.containsKey('selectedSubPropertyName');
    if (valueExists) {
      await prefs.setString('selectedSubPropertyId', selectedPropertyId);
    }
    if (valueExistss) {
      await prefs.setString('selectedSubPropertyName', selectedPropertyName);
    }
  }

  assignFirst(String subPropertyId) {
    // print('First Property: $subPropertyId');
    updateSharedPreferences("selectedSubPropertyId", subPropertyId);
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
          title: Text("confirm_exit".tr()
              // 'Confirm Exit',
              ),
          content: Text("are_you_sure".tr()
              // 'Are you sure you want to exit?',
              ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'cancel'.tr(),
              ),
              onPressed: () {
                shouldExit = false;
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("exist".tr()
                  // 'Exit',
                  ),
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

  Future<void> clearAll() async {
    // propertyLists.clear();
    selectedSubProperty.clear();
    isLoading = false;
    isSubproperty = false;
    alldt = false;
    selectedSubpropertyName = '';
    selectedPropertyName = '';
    selectedSubPropertyId = '';
    // selectedSubProperties = 0;
    selectedPropertyId = '';
    // loadTabBar = false;
    // await loadPropertyList(landlordId);
    // return;
  }
}

// @fetchBillData
Future<List<BIllModel>> fetchBillDate() async {
  List<BIllModel> value = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var selectedPropertyId = prefs.getString('selectedPropertyId') ?? '';
  var selectedSubPropertyId = prefs.getString('selectedSubPropertyId') ?? '';
  var selectedSubPropertyName = prefs.getString('selectedSubPropertyName') ?? '';

  final Map<String, dynamic> requestData = {
    "propertyId": selectedPropertyId,
    "subPropertyId": selectedSubPropertyId,
    // "subPropertyId": selectedSubPropertyId,
  };

  final response = await http.post(
    Uri.parse(ApiUrl.getBill),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(requestData),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    List<BIllModel> res = BIllModel.fromJsonList(jsonData['data']);

    if (res.isNotEmpty) {
      value = res;
    }
  }
  return value;
}
