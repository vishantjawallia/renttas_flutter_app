// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../../model/BillModel.dart';

Future<Uint8List> makePdf(BIllModel invoice,String subname) async {
  dynamic currentTime = DateFormat.jm().format(DateTime.now());
  var now = DateTime.now();
  var formatterDate = DateFormat('dd/MM/yy');
  String actualDate = formatterDate.format(now);
  final pdf = Document();
  int amountt=int.parse(invoice.maintenanceAmount)+int.parse(invoice.rentAmount);
  int finalamount=amountt-int.parse(invoice.previousBalance);

  final imageLogo = MemoryImage((await rootBundle.load('assets/images/renttas.png')).buffer.asUint8List());
  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Name: ${subname}"),
                    Text("Bill No: ${invoice.id}"),
                    Text("Bill Date: ${actualDate}"),
                    Text("Bill Time: ${currentTime}"),
                    Text("Bill Period: ${invoice.rentStartDate +" to "+invoice.rentEndDate}"),
                    //Text("Due date :${invoice. +" to "+invoice.rentEndDate}"),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(imageLogo),
                )
              ],
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      child: Text(
                        'INVOICE',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                  ],
                ),
                // ...invoice.items.map(
                //   (e) => TableRow(
                //     children: [
                //       Expanded(
                //         child: PaddedText(e.description),
                //         flex: 2,
                //       ),
                //       Expanded(
                //         child: PaddedText("\$${e.cost}"),
                //         flex: 1,
                //       )
                //     ],
                //   ),
                // ),
                // TableRow(
                //   children: [
                //     PaddedText('TAX', align: TextAlign.right),
                //     PaddedText('\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
                //   ],
                // ),
                // TableRow(
                //   children: [PaddedText('TOTAL', align: TextAlign.right), PaddedText('\$${(invoice.totalCost() * 1.1).toStringAsFixed(2)}')],
                // )
              ],
            ),
            Padding(
              child: Text(
                "THANK YOU FOR YOUR CUSTOM!",
                style: Theme.of(context).header2,
              ),
              padding: EdgeInsets.all(20),
            ),
            Text("Please forward the below slip to your accounts payable department."),
            Divider(
              height: 1,
              borderStyle: BorderStyle.dashed,
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    PaddedText('Rent'),
                    PaddedText(
                      invoice.rentAmount
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Maintanance Amount',
                    ),
                    PaddedText(
                      invoice.maintenanceAmount,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Previous Balance',
                    ),
                    PaddedText(
                      invoice.previousBalance,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Total',
                    ),
                    //PaddedText('\$${(invoice.rentAmount + invoice.maintenanceAmount)}')
                 PaddedText(finalamount.toString())
                   // PaddedText((int.parse(invoice.rentAmount)+int.parse(invoice.maintenanceAmount)-int.parse(invoice.previousBalance)).toRadixString(2))
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'Powerd by RENTTAS',
                style: Theme.of(context).header3.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
