// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiReference {
  ApiReference._();

  /* -------------------------------- Api Post ------------------------------- */
  static Future apiPost(
    String? url,
    Map<String, dynamic>? body,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(url!),
        headers: {
          'Content-Type': "application/json",
        },
        body: jsonEncode(body!),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw "Exception-Occurred";
      }
    } on SocketException {
      throw "Exception-Occurred";
    }
  }

  /* -------------------------------- Api Get ------------------------------- */
  static Future apiGet(String? url) async {
    try {
      final response = await http.get(
        Uri.parse(url!),
        headers: {
          'Content-Type': "application/json",
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw "Exception-Occurred";
      }
    } on SocketException {
      throw "Exception-Occurred";
    }
  }
}
