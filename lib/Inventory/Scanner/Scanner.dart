// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ProductScanner extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ProductScanner> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver('#ff6666', 'Cancel', true, ScanMode.BARCODE)!.listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() => _scanBarcode = barcodeScanRes);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() => _scanBarcode = barcodeScanRes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: const Color(0xff54854C),
        title: const Text('Barcode scan'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.center,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(double.infinity, 45)),
                    backgroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
                    textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  onPressed: () => scanBarcodeNormal(),
                  child: const Text(
                    'Start barcode scan',
                  ),
                ),
                const SizedBox(width: 0.0, height: 16),
                ElevatedButton(
                  onPressed: () => scanQR(),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(double.infinity, 45)),
                    backgroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
                    textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  child: const Text(
                    'Start QR scan',
                  ),
                ),
                const SizedBox(width: 0.0, height: 16),
                ElevatedButton(
                  onPressed: () => startBarcodeScanStream(),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(double.infinity, 45)),
                    backgroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
                    textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  child: const Text(
                    'Start barcode scan stream',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Scan result : $_scanBarcode\n',
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
