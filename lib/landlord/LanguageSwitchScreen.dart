// ignore_for_file: use_build_context_synchronously, camel_case_types, unnecessary_const

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/Const/Const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSwitchScreen extends StatefulWidget {
  const LanguageSwitchScreen({super.key});

  @override
  State<LanguageSwitchScreen> createState() => _LanguageSwitchScreenState();
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

class _LanguageSwitchScreenState extends State<LanguageSwitchScreen> {
  @override
  void initState() {
    super.initState();
    getlang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        title: Text("Choose Language".tr()),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 40),
        itemCount: storelist.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      snack("Please wait...", context);
                      storelang(storelist[index].nameshown, index.toString(), storelist[index].code, storelist[index].countrycode);
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: defindex == index.toString() ? const Color(0xff54854C).withOpacity(0.2) : Colors.transparent,
                          border: Border.all(
                            color: defindex == index.toString() ? const Color(0xff54854C).withOpacity(0.9) : Colors.grey,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(12))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              storelist[index].nameshown,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Flexible(fit: FlexFit.tight, child: SizedBox()),
                            defindex == index.toString()
                                ? const Icon(
                                    Icons.check_rounded,
                                    color: const Color(0xff54854C),
                                    size: 30,
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
