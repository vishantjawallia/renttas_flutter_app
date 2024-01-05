// ignore_for_file: avoid_unnecessary_containers

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

class GlobalWidgets {
  static toast(value, {Color? color, int? sec}) {
    return BotToast.showText(
      text: value,
      textStyle: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      contentColor: color ?? Colors.black54,
      borderRadius: BorderRadius.circular(6),
      contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      duration: Duration(seconds: sec ?? 1),
    );
  }


  static notFound(
    String value,
  ) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Text(
              "$value ${"not_found".tr()}!",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static loading() {
    return Container(
      alignment: Alignment.center,
      child: const Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Color(0xff54854C),
          ),
        ],
      ),
    );
  }
}
