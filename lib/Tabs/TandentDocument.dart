// ignore_for_file: sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/model/Document.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../TabAction/LoadDocImage.dart';
import '../widgets/global_widget.dart';

class TandentDocument extends StatefulWidget {
  const TandentDocument({Key? key}) : super(key: key);

  @override
  State<TandentDocument> createState() => _TandentDocumentState();
}

class _TandentDocumentState extends State<TandentDocument> {
  String userId = '';
  String name = '';
  String mobile = '';
  String host = '';
  bool isLoading = false;
  bool isDocTheir = false;
  List<Documents> dataList = [
    Documents(id: "1", propertyId: "", subPropertyId: "", imageName: "", docType: "type2", docName: "Hello", createdAt: "", updatedAt: ""),
    Documents(id: "2", propertyId: "", subPropertyId: "", imageName: "", docType: "type3", docName: "Vishant", createdAt: "", updatedAt: ""),
    Documents(id: "2", propertyId: "", subPropertyId: "", imageName: "", docType: "type3", docName: "Vishant", createdAt: "", updatedAt: ""),
    Documents(id: "2", propertyId: "", subPropertyId: "", imageName: "", docType: "type3", docName: "Vishant", createdAt: "", updatedAt: ""),
    Documents(id: "2", propertyId: "", subPropertyId: "", imageName: "", docType: "type3", docName: "Vishant", createdAt: "", updatedAt: ""),
    Documents(id: "2", propertyId: "", subPropertyId: "", imageName: "", docType: "type3", docName: "Vishant", createdAt: "", updatedAt: ""),
    Documents(id: "2", propertyId: "", subPropertyId: "", imageName: "", docType: "type3", docName: "Vishant", createdAt: "", updatedAt: ""),
  ];
  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ?? '';
      name = prefs.getString('name') ?? '';
      mobile = prefs.getString('phone') ?? '';
    });
    loadDoc(mobile);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return isLoading
        ? GlobalWidgets.loading()
        : dataList.isEmpty
            ? GlobalWidgets.notFound('Documents')
            : Visibility(
                visible: dataList.isNotEmpty,
                child: Flexible(
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 20),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 250.0, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      final document = dataList[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                            boxShadow: [const BoxShadow(blurRadius: 0.9, spreadRadius: 0.4, color: Colors.grey)]),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoadDocImage(imageUrl: ApiUrl.imageurl + document.imageName),
                                  ),
                                );
                              },
                              child: Container(
                                width: screenWidth * 1,
                                height: screenHeight * 0.12,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://images.fastcompany.net/image/upload/w_1250,ar_16:9,c_fill,g_auto,f_auto,q_auto,fl_lossy/wp-cms/uploads/2023/12/p-1-90996792-the-best-thing-you-can-do-to-set-yourself-up-for-a-productive-new-year.webp'
                                        // '${ApiUrl.imageurl}${document.imageName}',
                                        ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              margin: const EdgeInsets.only(top: 12),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    document.docName,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  Text(
                                    document.docType,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                replacement: GlobalWidgets.notFound('Documents'),
              );
  }

  Future<void> loadDoc(String mobile) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(ApiUrl.getDocByMobile);

    final Map<String, dynamic> requestData = {
      // "propertyId": PropertyId,
      // "subPropertyId": subpropertyId

      // "mobileNumber": "1234567890"
      "mobileNumber": mobile
    };

    final headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(url, headers: headers, body: jsonEncode(requestData));

    final Map<String, dynamic> responseData = json.decode(response.body);
    print("get doc by mobileeee===" + response.body);
    //
    // final request =
    // await http.Request('GET', Uri.parse("${ApiUrl.getDocByMobile}${mobile}"));
    // request.body =
    //     jsonEncode({
    //       "mobile":mobile
    //     });
    // final response = await request.send();
    //
    // final stream = response.stream;
    // final body = await stream.bytesToString();
    // print(body);
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      // final jsonData = jsonDecode(body);
      final List<dynamic> data = responseData['data'];
      // Documents.host = jsonData['data']['host'];

      if (data.isNotEmpty) {
        dataList.addAll(Documents.fromJsonList(data));
      }

      // for (var billData in data) {
      //   dataList.add(Documents.fromJson(billData));
      // }
      // if (dataList.isNotEmpty) {
      //   isDocTheir = true;
      // } else {
      //   isDocTheir = false;
      // }
      setState(() => isLoading = false);
    }
  }
}
