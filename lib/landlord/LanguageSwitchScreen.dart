// ignore_for_file: use_build_context_synchronously, camel_case_types

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/Const/Const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class languageswitchscreen extends StatefulWidget {
  const languageswitchscreen({super.key});

  @override
  State<languageswitchscreen> createState() => _languageswitchscreenState();
}

//'English', 'Hindi', 'Germany', 'French', 'Arabia', 'Europe'  -- Provided Languages

List<LangModel> storelist = <LangModel>[
  LangModel(code: "en", countrycode: "EN", nameshown: "English"),
  LangModel(code: "hn", countrycode: "HN", nameshown: "Hindi"),
  LangModel(code: "ge", countrycode: "GE", nameshown: "Germany"),
  LangModel(code: "fr", countrycode: "FR", nameshown: "French"),
  LangModel(code: "ar", countrycode: "AR", nameshown: "Arabia"),
  LangModel(code: "eu", countrycode: "EU", nameshown: "Europe"),
];

String deflanguage = "", defindex = "";

class _languageswitchscreenState extends State<languageswitchscreen> {
  @override
  void initState() {
    super.initState();
    getlang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("choose language".tr()),
      ),
      body: ListView.builder(
          itemCount: storelist.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        snack("Please wait...", context);
                        storelang(storelist[index].nameshown, index.toString(), storelist[index].code, storelist[index].countrycode);
                      },
                      child: Container(
                        height: 50,
                        //color: Colors.grey,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(10))),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(storelist[index].nameshown),
                              const Flexible(fit: FlexFit.tight, child: SizedBox()),
                              defindex == index.toString() ? const Icon(Icons.check) : const SizedBox()
                            ],
                          ),
                        ),
                      ),
                    ),
                    //  Text("title".tr().toString()),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextButton(
//                         onPressed: () {
//                           setState(() {
//                             EasyLocalization.of(context)!
//                                 .setLocale(const Locale('en', 'EN'));
//                           });
//
// //LocalizationChecker.changeLanguge(context);
//                         },
//                         child: Text("English")),
//                     TextButton(
//                         onPressed: () {
//                           setState(() {
//                             setState(() {
//                               EasyLocalization.of(context)!
//                                   .setLocale(const Locale('ar', 'AR'));
//                             });
//
//                             //   EasyLocalization.of(context).locale=Locale('ar','AR');
//                           });
//                         },
//                         child: Text("Arabic"))
//                   ],
//                 )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Future<void> getlang() async {
    SharedPreferences sh = await SharedPreferences.getInstance();

    if (sh.getString("lang") == null) {
      setState(() {
        defindex = "0";
      });
    } else {
      setState(() {
        deflanguage = sh.getString("lang")!;
        defindex = sh.getString("index")!;
      });
    }
  }

  Future<void> storelang(String lang, String index, String code, String countrycode) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString("lang", lang);
    sh.setString("index", index);

    EasyLocalization.of(context)!.setLocale(Locale(code, countrycode));
    getlang();
  }
}

// model class for chnaging the language
class LangModel {
  final String code;
  final String countrycode;
  final String nameshown;

  LangModel({
    required this.code,
    required this.countrycode,
    required this.nameshown,
  });
}
