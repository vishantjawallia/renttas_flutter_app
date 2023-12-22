// ignore_for_file: sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/Common/ApiUrl.dart';
import 'package:http/http.dart' as http;
import 'package:renttas_flutter_app/model/Document.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../TabAction/LoadDocImage.dart';

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
  List<Documents> dataList = [];
  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ?? '';
      name = prefs.getString('name') ?? '';
      mobile = prefs.getString('phone') ?? '';
      loadDoc(mobile);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff54854C),
                  ),
                )
              : dataList.isEmpty
                  ? const Flexible(
                      fit: FlexFit.tight,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 50),
                          child: Text(
                            "Documemt not found !",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Visibility(
                      visible: dataList.isNotEmpty,
                      child: Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 250.0, // Maximum width of each card
                            crossAxisSpacing: 10.0, // Horizontal space between cards
                            mainAxisSpacing: 10.0, // Vertical space between cards
                          ),
                          itemCount: dataList.length,
                          itemBuilder: (context, index) {
                            final document = dataList[index];
                            return Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
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
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            '${ApiUrl.imageurl}${document.imageName}',
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            document.docName,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            document.docType,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: screenWidth * 0.2),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      replacement: const Flexible(
                        fit: FlexFit.tight,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 50),
                            child: Text(
                              "Documemt not found !",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
        ],
      ),
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

      for (var billData in data) {
        dataList.add(Documents.fromJson(billData));
      }
      if (dataList.isNotEmpty) {
        isDocTheir = true;
      } else {
        isDocTheir = false;
      }
      setState(() {
        isLoading = false; // Set loading state to false after the data is loaded
      });
    }
  }
}
