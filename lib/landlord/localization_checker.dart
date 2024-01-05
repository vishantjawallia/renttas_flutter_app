import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationChecker {
  static changeLanguge(BuildContext context) {
    Locale? currentLocal = EasyLocalization.of(context)!.currentLocale;
    if (currentLocal == const Locale('en', 'EN')) {
      EasyLocalization.of(context)!.setLocale(const Locale('ar', 'AR'));
    } else {
      EasyLocalization.of(context)!.setLocale(const Locale('en', 'EN'));
    }
  }
}
