import 'package:flutter/material.dart';

void snack(String msg,BuildContext context) {
  final snackBar = SnackBar(
    elevation: 0,
    backgroundColor: Colors.black,
    content: Text(
      msg,
      style: TextStyle(color: Colors.white),
    ),
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
