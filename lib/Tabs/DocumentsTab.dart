// ignore_for_file: depend_on_referenced_packages, sort_child_properties_last,  use_build_context_synchronously, sized_box_for_whitespace, avoid_print, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unnecessary_brace_in_string_interps, use_super_parameters, unused_field

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../Common/ApiUrl.dart';
import '../Common/RentalCustomAlert.dart';
import '../Const/Const.dart';
import '../TabAction/LoadDocImage.dart';
import '../model/Document.dart';

class DocumentsTab extends StatefulWidget {
  const DocumentsTab({Key? key}) : super(key: key);

  @override
  State<DocumentsTab> createState() => _DocumentsTabState();
}

class _DocumentsTabState extends State<DocumentsTab> {
  static String selectedPropertyId = '';
  static String selectedSubPropertyId = '';
  static String userId = '';
  final List<String> docTypes = ['ID Proof', 'Address Proof', 'Rent Agreement', 'Other'];
  TextEditingController docName = TextEditingController();
  int selectedCycleIndex = 0;
  String docType = 'ID Proof';
  final picker = ImagePicker();
  File? _imageFile;

  bool isLoading = false;
  bool isDocumentTheir = false;

  List<dynamic> dataList = [];

  List<Documents> documents = [];

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
      selectedPropertyId = prefs.getString('selectedPropertyId') ?? '';
      selectedSubPropertyId = prefs.getString('selectedSubPropertyId') ?? '';
      userId = prefs.getString('userId') ?? '';
      loadDocument(selectedPropertyId, selectedSubPropertyId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    log(jsonEncode(documents));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var status = await Permission.photos.status;
          if (status.isGranted) {
            _pickImage();
          } else {
            if (status.isLimited) {
              await Permission.photos.request();
              if (await Permission.photos.status.isGranted) {
                _pickImage();
              }
            } else {
              _showPermissionError();
            }
          }
        },
        label: const Text(
          'Document',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xff54854C),
        // backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      body: Column(
        children: [
          isLoading
              ? const Flexible(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 60.0),
                      child: CircularProgressIndicator(
                        color: Color(0xff54854C),
                      ),
                    ),
                  ),
                )
              : Visibility(
                  visible: documents.isNotEmpty,
                  child: Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250.0, // Maximum width of each card
                        crossAxisSpacing: 10.0, // Horizontal space between cards
                        mainAxisSpacing: 10.0, // Vertical space between cards
                      ),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
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
                                  const SizedBox(width: 15),
                                  IconButton(
                                    onPressed: () {
                                      showAlertDialogdelete(context, document.id);
                                      //deleteDocument(document.id);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  replacement: Flexible(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 60.0),
                        child: Text(
                          '${"document".tr()} not found !',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
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

  Future _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
    _openBottomSheet(context);
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.8, // Set the desired height
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(right: 300),
                              child: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )),
                          _imageFile == null
                              ? const Text('No documents selected.')
                              : Container(
                                  width: 100, // Specify the desired width
                                  height: 250, // Specify the desired height
                                  child: Image.file(_imageFile!),
                                ),
                          const Text('Document Type'),
                          StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  children: [
                                    Row(
                                      children: List.generate(
                                        docTypes.length,
                                        (index) => GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedCycleIndex = index;
                                              docType = docTypes[index];
                                              print('Selected TextDays: $docType');
                                            });
                                          },
                                          child: Center(
                                            child: Container(
                                              margin: const EdgeInsets.only(top: 20, left: 18),
                                              padding: const EdgeInsets.all(8),
                                              color: index == selectedCycleIndex ? Colors.blueAccent : Colors.black,
                                              child: Text(
                                                docTypes[index],
                                                style: const TextStyle(color: Colors.white),
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
                          TextField(
                            controller: docName,
                            decoration: const InputDecoration(icon: Icon(Icons.verified_user), labelText: "Document Name"),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                saveDoc(_imageFile, docType, docName.text, selectedPropertyId, selectedSubPropertyId);
                              },
                              child: const Text('Add')),
                          const SizedBox(
                            height: 100,
                          )
                        ],
                      )),
                ],
              ),
            ));
      },
    );
  }

  showAlertDialogdelete(BuildContext context, String docid) {
    // show the dialog
    showDialog(
      context: context,
      builder: (context) {
        String contentText = "Are you sure want to delete ?";
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Confirmation"),
              content: Text(contentText),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    final Map<String, dynamic> requestBody = {
                      "docid": docid,
                    };

                    final response = await http.post(
                      Uri.parse(ApiUrl.deletedoc),
                      body: jsonEncode(requestBody),
                      headers: {
                        'Content-Type': 'application/json',
                      },
                    );
                    print("expesss--" + response.body);
                    setState(() {
                      isLoading = false;
                    });
                    if (response.statusCode == 200) {
                      loadDocument(selectedPropertyId, selectedSubPropertyId);
                      Navigator.pop(context);
                    } else {
                      snack("Something went wrong", context);
                    }
                  },
                  child: Text(isLoading == false ? "Continue" : "Please wait"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> saveDoc(
    File? imageFile,
    String docType,
    String docName,
    String selectedPropertyId,
    String selectedSubPropertyId,
  ) async {
    if (imageFile == null) {
      RentalCustomAlert.showErrorsAlert(context, "Error", "Please Select A Image");
      return;
    }

    final allowedExtensions = ['.jpg', '.jpeg', '.png', '.pdf'];
    final fileExtension = path.extension(imageFile.path).toLowerCase();
    if (!allowedExtensions.contains(fileExtension)) {
      RentalCustomAlert.showErrorsAlert(context, "Error", 'Invalid file type. Only JPG, JPEG, PNG, and PDF files are allowed.');
      return;
    }

    try {
      // Create multipart request for sending the file
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiUrl.createDocument),
      );

      // Add file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
        ),
      );

      // Add other form fields
      request.fields['docname'] = docName.toString();
      request.fields['doctype'] = docType;
      request.fields['Propertyid'] = selectedPropertyId;
      request.fields['subPropertyid'] = selectedSubPropertyId;

      // Send the request
      var response = await request.send();

      final stream = response.stream;
      final body = await stream.bytesToString();
      print(body);
      // final data = jsonDecode(body);

      print("response to add document=" + response.statusCode.toString());

      // Check the response status
      if (response.statusCode == 200) {
        await loadDocument(selectedPropertyId, selectedSubPropertyId);
        Navigator.of(context).pop();
        RentalCustomAlert.showSuccessAlert(context, "Success", "Document Added Successfully");
      } else {
        RentalCustomAlert.showErrorAlert(context);
      }
    } catch (e) {
      print('Error saving document: $e');
    }
  }

  Future<void> loadDocument(String PropertyId, String subpropertyId) async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(ApiUrl.getDocument);
    final Map<String, dynamic> requestData = {
      // "propertyId": PropertyId,
      // "subPropertyId": subpropertyId

      "propertyId": PropertyId, "subPropertyId": subpropertyId
    };

    final headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(url, headers: headers, body: jsonEncode(requestData));

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);

    if (response.statusCode == 200) {
      // Documents.host = responseData['data']['host'];
      final List<dynamic> documentsData = responseData['data'];

      documents = documentsData.map((data) => Documents.fromJson(data)).toList();
      isDocumentTheir = true;
    } else {
      isDocumentTheir = false;
    }
    setState(() {
      isLoading = false; // Set loading state to false after the data is loaded
    });
  }

  Future<void> deleteDocument(String docId) async {
    setState(() {
      isLoading = true;
    });
    print("$ApiUrl.deleteDoc$docId");
    final request = http.Request('DELETE', Uri.parse("${ApiUrl.deleteDoc}${docId}"));

    final response = await request.send();
    print(response);

    final stream = response.stream;
    final body = await stream.bytesToString();
    print(body);
    await Future.delayed(const Duration(seconds: 12));
    await loadDocument(selectedPropertyId, selectedSubPropertyId);
    setState(() {
      isLoading = false;
    });
  }

  void _showPermissionError() {}
}
