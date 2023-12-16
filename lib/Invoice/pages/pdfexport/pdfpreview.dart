import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../../../model/BillModel.dart';
import 'pdf/pdfexport.dart';

class PdfPreviewPage extends StatelessWidget {
  final BIllModel invoice;
  final String subname;
  const PdfPreviewPage({Key? key, required this.invoice, required this.subname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subname),
      ),
      body: PdfPreview(
        build: (context) => makePdf(invoice,subname),
      ),
    );
  }
}
