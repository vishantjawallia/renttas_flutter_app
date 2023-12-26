// ignore_for_file: avoid_print, use_build_context_synchronously, sized_box_for_whitespace, depend_on_referenced_packages, non_constant_identifier_names, use_super_parameters, sort_child_properties_last, prefer_const_constructors

import 'dart:convert';
// import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:renttas_flutter_app/Const/Const.dart';
import 'package:path/path.dart' as path;
import 'package:renttas_flutter_app/landlord/lanlordProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Common/ApiUrl.dart';

class AboutTab extends StatefulWidget {
  const AboutTab({Key? key}) : super(key: key);

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> with SingleTickerProviderStateMixin {
  TextEditingController addressControler = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController propertyOwner = TextEditingController();
  TextEditingController documentName = TextEditingController();
  late TabController _tabController1;

  String selectedPropertyId = '';
  String selectedSubProptyId = '';
  String userId = '';
  String currency = '';
  String selectedSubpropertyName = '';
  String selectedPropertyName = '';
  String landlordName = '';
  bool isKeyboardVisible = false;
  bool isloaidngfirst = false;

  String address = "", pincode = "", image = "", Docname = "", ownername = "";
  String stcodeadd = "", stcodedoc = "";

  final picker = ImagePicker();
  File? _imageFile;

  String location = '';
  String pan = '';
  String property_owner = '';

  bool isLocationTheir = false;
  bool isPanTheir = false;
  bool isloaidng = false;

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedPropertyId = prefs.getString('selectedPropertyId') ?? '';
      selectedPropertyName = prefs.getString('selectedPropertyName') ?? '';
      selectedSubProptyId = prefs.getString('selectedSubProptyId') ?? '';
      selectedPropertyId = prefs.getString('selectedPropertyId') ?? '';
      selectedSubpropertyName = prefs.getString('selectedSubPropertyName') ?? '';
      userId = prefs.getString('userId') ?? '';
      currency = prefs.getString('currency') ?? '';
      landlordName = prefs.getString('name') ?? '';
    });
    getaddress();
    getdoc();
  }

  @override
  void initState() {
    //getdoc();
    _tabController1 = TabController(length: 2, vsync: this);

    super.initState();
    loadData();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() => isKeyboardVisible = visible);
    });
  }

  @override
  void dispose() {
    _tabController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloaidngfirst == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff54854C),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TabBar(
                      isScrollable: true,
                      indicator: const BoxDecoration(
                        color: Color(0xff54854C),
                      ),
                      labelColor: Colors.white,
                      labelStyle: TextStyle(
                        fontSize: 16,
                      ),
                      controller: _tabController1,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(text: 'property_details'.tr()),
                        Tab(text: 'rent_detail'.tr()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController1,
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Center(child: Text('No documents are added',textAlign: TextAlign.center,),),
                            // SizedBox(height: 100,),
                            // ElevatedButton(onPressed: (){},
                            //
                            //   child: Text(' + Add Document Images'),
                            //   style: ElevatedButton.styleFrom(primary:Colors.blue, shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(10)
                            //   )),
                            // ),

                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(top: 20, left: 10),
                              child: Text(
                                "${"details".tr()}:",
                                // 'Details:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),

                            const Divider(
                              //  margin:EdgeInsets.only(top: 10),
                              color: Colors.grey,
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(left: 8, top: 8),
                                  padding: const EdgeInsets.only(right: 25),
                                  child: Text(
                                    "property_name".tr(),
                                    // 'Property Name',
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(left: 25, top: 8),
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(selectedPropertyName),
                                ),
                              ],
                            ),
                            const Divider(
                              //  margin:EdgeInsets.only(top: 10),
                              color: Colors.grey,
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(left: 8, top: 8),
                                  padding: const EdgeInsets.only(right: 25),
                                  child: Text(
                                    "owner_name".tr(),
                                    // 'Owner Name',
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(left: 25, top: 8),
                                  padding: const EdgeInsets.only(left: 45),
                                  child: Text(landlordName),
                                ),
                              ],
                            ),
                            SizedBox(width: 0.0, height: 10),
                            if (isLocationTheir)
                              const Divider(
                                //  margin:EdgeInsets.only(top: 10),
                                color: Colors.grey,
                              ),
                            if (isLocationTheir)
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(left: 8, top: 8),
                                    padding: const EdgeInsets.only(right: 25),
                                    child: Text(
                                      'address'.tr(),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(left: 25, top: 8),
                                    padding: const EdgeInsets.only(left: 45),
                                    child: Text(location),
                                  ),
                                ],
                              ),
                            if (isLocationTheir)
                              const Divider(
                                //  margin:EdgeInsets.only(top: 10),
                                color: Colors.grey,
                              ),
                            if (isPanTheir)
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(left: 8, top: 18, bottom: 10),
                                padding: const EdgeInsets.only(right: 25),
                                child: const Text(
                                  'Property Owner Details:',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                              ),
                            if (isPanTheir)
                              const Divider(
                                //  margin:EdgeInsets.only(top: 10),
                                color: Colors.grey,
                              ),
                            if (isPanTheir)
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(left: 8, top: 8),
                                    padding: const EdgeInsets.only(right: 25),
                                    child: const Text(
                                      'OwnerName',
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(left: 25, top: 8),
                                    padding: const EdgeInsets.only(left: 45),
                                    child: const Text(
                                      "property_owner",
                                    ),
                                  ),
                                ],
                              ),
                            if (isPanTheir)
                              const Divider(
                                //  margin:EdgeInsets.only(top: 10),
                                color: Colors.grey,
                              ),
                            if (isPanTheir)
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(left: 8, top: 8),
                                    padding: const EdgeInsets.only(right: 25),
                                    child: const Text('PAN'),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(left: 25, top: 8),
                                    padding: const EdgeInsets.only(left: 45),
                                    child: const Text("pan"),
                                  ),
                                ],
                              ),
                            if (isPanTheir)
                              const Divider(
                                //  margin:EdgeInsets.only(top: 10),
                                color: Colors.grey,
                              ),
                            stcodeadd == "201"
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 8, top: 8),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (!isLocationTheir)
                                          Padding(
                                            padding: const EdgeInsets.only(right: 45),
                                            child: OutlinedButton(
                                              style: ButtonStyle(
                                                foregroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
                                                // maximumSize: MaterialStateProperty.all(const Size(200, 40)),
                                                // iconColor: MaterialStateProperty.all(Colors.white),
                                                // foregroundColor: MaterialStateProperty.all(Colors.white),
                                                // backgroundColor: MaterialStateProperty.all(Colors.blue.shade100),
                                              ),
                                              onPressed: () => _showAddressModal(context),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.add),
                                                  SizedBox(width: 6, height: 0.0),
                                                  Text(
                                                    'address'.tr(),
                                                    style: TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        // Container(
                                        //   margin: const EdgeInsets.only(left: 10, top: 15),
                                        //   child: InkWell(
                                        //     child: const Text(
                                        //       '+ Property Address',
                                        //       style: TextStyle(color: Colors.blue),
                                        //     ),
                                        //     onTap: () async => _showAddressModal(context),
                                        //   ),
                                        // ),
                                        if (!isPanTheir)
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: OutlinedButton(
                                              style: ButtonStyle(
                                                foregroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
                                                // maximumSize: MaterialStateProperty.all(const Size(200, 40)),
                                                // iconColor: MaterialStateProperty.all(Colors.white),
                                                // foregroundColor: MaterialStateProperty.all(Colors.white),
                                                // backgroundColor: MaterialStateProperty.all(Colors.blue),
                                              ),
                                              onPressed: () => _openBottomOwnerDetails(context),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.add),
                                                  SizedBox(width: 6, height: 0.0),
                                                  Text(
                                                    'owner_details'.tr(),
                                                    style: TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                        // Container(
                                        //   margin: const EdgeInsets.only(left: 10, top: 15),
                                        //   child: InkWell(
                                        //       child: const Text(
                                        //         '+ Property Owner Details',
                                        //         style: TextStyle(color: Colors.blue),
                                        //       ),
                                        //       onTap: () async {
                                        //         /* _opneBottomOwnerDetatils(context);*/
                                        //         _openBottomOwnerDetails(context);
                                        //       }),
                                        // ),
                                      ],
                                    ),
                                  )
                                : Flexible(
                                    // fit: FlexFit.tight,
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${"document".tr()}:-",
                                                // "Document:-",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(top: 8, bottom: 12),
                                                alignment: Alignment.center,
                                                child: Image.network(
                                                  ApiUrl.imageurl + image,
                                                  height: 150,
                                                ),
                                              ),
                                              Text(
                                                "${"property_address".tr()}:-",
                                                // "Property address:-",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                "${"address".tr()} : ${address.capitalizeFirstWord()}",
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                "${"pincode".tr()} : ${pincode.capitalizeFirstWord()}",
                                              ),
                                              const SizedBox(height: 15),
                                              Text(
                                                "${"owner_details".tr()}:-",
                                                // "Owner details:-",
                                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                "${"owner_name".tr()}: ${ownername.capitalizeFirstWord()}",
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "${"document_name".tr()} : ${Docname.capitalizeFirstWord()}",
                                              ),
                                              const SizedBox(height: 5),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "no_rent_details".tr(),
                                // 'No rent details are added to the property.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text("click_add_rent".tr()
                                  // ' +  Click to add rent',
                                  ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff54854C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() => _imageFile = File(pickedFile!.path));
  }

  void _showAddressModal(BuildContext context) {
    showStickyFlexibleBottomSheet(
      minHeight: 0,
      initHeight: 0.45,
      maxHeight: 1,
      headerHeight: 100,
      bottomSheetColor: Colors.white,
      context: context,
      headerBuilder: (BuildContext context, double offset) {
        return Container(
          alignment: Alignment.center,
          color: Colors.white,
          height: 200,
          child: const Text(
            'Add Address',
            style: TextStyle(fontSize: 18),
          ),
        );
      },
      anchors: [0, 0.5, 1],
      bodyBuilder: (BuildContext context, double bottomSheetOffset) {
        return SliverChildListDelegate(
          [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Owner Address',
                    ),
                    TextFormField(
                      controller: addressControler,
                      decoration: const InputDecoration(labelText: 'Address'),
                    ),
                    const SizedBox(width: 0.0, height: 8),
                    TextFormField(
                      controller: pinCode,
                      decoration: const InputDecoration(labelText: 'PinCode'),
                    ),
                    const SizedBox(width: 0.0, height: 20),
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff54854C))),
                      onPressed: () {
                        addaddress(addressControler.text, pinCode.text);
                        //  Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                    const SizedBox(width: 0.0, height: 8),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //   },
                    //   child: const Text('Close'),
                    // ),

                    //  SizedBox(height: isKeyboardVisible ? 300 : 0), // Spacer for keyboard
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> addaddress(String address, pincode) async {
    setState(() {
      isloaidng = true;
    });
    // SharedPreferences logindata = await SharedPreferences.getInstance();
    // String? userid = logindata.getString("userId");

    Map data = {'address': address, 'pincode': pincode, 'selectedPropertyId': selectedPropertyId, "selectedSubPropertyId": selectedSubProptyId};
    final headerss = {
      'Content-Type': 'application/json',
    };
    print(data.toString());

    final response = await http.post(
      Uri.parse(ApiUrl.addaddressdetails),
      headers: headerss,
      body: jsonEncode(data),
    );

    print("aaaaaaa======${response.body}");
    setState(() {
      isloaidng = false;
    });
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);

      if (resposne['msg'].toString().contains("success")) {
        //  Navigator.pop(context);

        getaddress();
        Navigator.pop(context);

        print("Login Successfully Completed !!!!!!!!!!!!!!!!");
      } else {
        print("Please try again!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      }
    }
  }

  Future<void> getaddress() async {
    setState(() {
      isloaidngfirst = true;
    });
    // SharedPreferences logindata = await SharedPreferences.getInstance();
    // String? userid = logindata.getString("userId");

    Map data = {'selectedPropertyId': selectedPropertyId, "selectedSubPropertyId": selectedSubProptyId};
    final headerss = {
      'Content-Type': 'application/json',
    };
    print(data.toString());
    final response = await http.post(
      Uri.parse(ApiUrl.getaddressdetails),
      headers: headerss,
      body: jsonEncode(data),
    );
    setState(() {
      isloaidngfirst = false;
    });
    print("get addressss ===${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);

      if (resposne['statuscode'].toString().contains("200")) {
        setState(() {
          address = resposne['address'].toString();
          pincode = resposne['pincode'].toString();
        });
        // No response code here
        //String id,address,picode;
        //  Navigator.pop(context);
        ///  getdatas();

        print("Login Successfully Completed !!!!!!!!!!!!!!!!");
      } else {}
    } else {
      setState(() {
        stcodeadd = 201.toString();
      });
    }
  }

  Future<void> getdoc() async {
    setState(() {
      isloaidngfirst = true;
    });
    // SharedPreferences logindata = await SharedPreferences.getInstance();
    // String? userid = logindata.getString("userId");

    Map data = {'selectedPropertyId': selectedPropertyId, "selectedSubPropertyId": selectedSubProptyId};
    final headerss = {
      'Content-Type': 'application/json',
    };
    print(data.toString());
    final response = await http.post(
      Uri.parse(ApiUrl.getdocumentinabout),
      headers: headerss,
      body: jsonEncode(data),
    );

    print("resp in doc---${response.body}");
    setState(() {
      isloaidngfirst = false;
    });
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);

      if (resposne['statuscode'].toString().contains("200")) {
        setState(() {
          ownername = resposne['propertyownername'].toString();
          Docname = resposne['docname'].toString();
          image = resposne['ImageName'].toString();
        });
        // No response code here
        //String id,address,picode;
        //  Navigator.pop(context);
        ///  getdatas();

        print("Login Successfully Completed !!!!!!!!!!!!!!!!");
      } else {}
    } else {
      setState(() {
        stcodeadd = 201.toString();
      });
    }
  }

  void _openBottomOwnerDetails(BuildContext context) {
    showStickyFlexibleBottomSheet(
      context: context,
      headerHeight: 60,
      minHeight: 0,
      initHeight: 0.55,
      maxHeight: 1,
      bottomSheetColor: Colors.white,
      headerBuilder: (BuildContext context, double offset) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
      bodyBuilder: (BuildContext context, double bottomSheetOffset) {
        return SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      const Text(
                        'Add Address',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextField(
                        controller: propertyOwner,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.supervised_user_circle_outlined),
                          labelText: "Property Owner",
                        ),
                      ),
                      const SizedBox(width: 0.0, height: 10),
                      TextField(
                        controller: documentName,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.credit_card),
                          labelText: "Document Name",
                        ),
                      ),
                      const SizedBox(width: 0.0, height: 20),
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return _imageFile == null
                              ? Container(
                                  alignment: Alignment.centerLeft,
                                  // width: 100,
                                  // height: 50,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(const Color(0xff54854C).withOpacity(0.6)),
                                    ),
                                    onPressed: () {
                                      _pickImage().then((_) {
                                        setState(() {});
                                      });
                                    },
                                    child: const Text("Choose Image"),
                                  ),
                                )
                              : Container(
                                  width: 100,
                                  height: 250,
                                  child: Image.file(_imageFile!),
                                );
                        },
                      ),
                      const SizedBox(width: 0.0, height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
                          ),
                          onPressed: () async {
                            // saveDoc(
                            //     _imageFile,
                            //     propertyOwner.text,
                            //     documentName.text,
                            //     selectedPropertyId,
                            //     selectedSubProptyId);
                            // addPanCard(
                            //    selectedCode,
                            //    selectedCode,
                            //    propertyOwner.text,
                            //    documentName.text,
                            //    _imageFile,
                            //  );
                            File? imageFile = _imageFile;
                            if (imageFile == null) {
                              snack("please select a image", context);
                              return;
                            }

                            final allowedExtensions = ['.jpg', '.jpeg', '.png', '.pdf'];
                            final fileExtension = path.extension(imageFile.path).toLowerCase();
                            if (!allowedExtensions.contains(fileExtension)) {
                              snack("Error Invalid file type. Only JPG, JPEG, PNG, and PDF files are allowed.", context);
                              return;
                            }

                            try {
                              // Create multipart request for sending the file
                              var request = http.MultipartRequest(
                                'POST',
                                Uri.parse(ApiUrl.adddocumentinabout),
                              );

                              // Add file to the request
                              request.files.add(
                                await http.MultipartFile.fromPath(
                                  'file',
                                  imageFile.path,
                                ),
                              );

                              // Add other form fields
                              request.fields['propertyownername'] = propertyOwner.text;
                              request.fields['docName'] = documentName.text;
                              request.fields['Propertyid'] = selectedPropertyId;
                              request.fields['subPropertyid'] = selectedSubProptyId;

                              // Send the request
                              var response = await request.send();

                              final stream = response.stream;
                              final body = await stream.bytesToString();
                              print(body);
                              // final data = jsonDecode(body);

                              print("response to add document=${response.statusCode}");

                              // Check the response status
                              if (response.statusCode == 200) {
                                Navigator.of(context).pop();
                                await getdoc();
                                // snack(
                                //   "Success Document Added Successfully",
                                //   context,
                                // );
                              } else {
                                snack(
                                  "Something went wrong",
                                  context,
                                );
                                //RentalCustomAlert.showErrorAlert(context);
                              }
                            } catch (e) {
                              print('Error saving document: $e');
                            }
                          },
                          child: const Text('Submit For Verification'),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]);
      },
    );
  }

  Future<void> saveDoc(
    File? imageFile,
    String propertyownername,
    String docName,
    String selectedPropertyId,
    String selectedSubProptyId,
  ) async {
    if (imageFile == null) {
      snack("please select a image", context);
      return;
    }

    final allowedExtensions = ['.jpg', '.jpeg', '.png', '.pdf'];
    final fileExtension = path.extension(imageFile.path).toLowerCase();
    if (!allowedExtensions.contains(fileExtension)) {
      snack("Error Invalid file type. Only JPG, JPEG, PNG, and PDF files are allowed.", context);
      return;
    }

    try {
      // Create multipart request for sending the file
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiUrl.adddocumentinabout),
      );

      // Add file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'File',
          imageFile.path,
        ),
      );

      // Add other form fields
      request.fields['propertyownername'] = propertyownername.toString();
      request.fields['docName'] = docName;
      request.fields['Propertyid'] = selectedPropertyId;
      request.fields['subPropertyid'] = selectedSubProptyId;

      // Send the request
      var response = await request.send();

      final stream = response.stream;
      final body = await stream.bytesToString();
      print(body);
      // final data = jsonDecode(body);

      print("response to add document=${response.statusCode}");

      // Check the response status
      if (response.statusCode == 200) {
        await getdoc();
        Navigator.of(context).pop();
        // snack(
        //   "Success Document Added Successfully",
        //   context,
        // );
      } else {
        snack(
          "Something went wrong",
          context,
        );
        //RentalCustomAlert.showErrorAlert(context);
      }
    } catch (e) {
      print('Error saving document: $e');
    }
  }
}
