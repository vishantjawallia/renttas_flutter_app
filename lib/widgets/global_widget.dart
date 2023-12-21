import 'package:bot_toast/bot_toast.dart';

import 'package:flutter/material.dart';

class GlobalWidgets {
  // toast
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
}
