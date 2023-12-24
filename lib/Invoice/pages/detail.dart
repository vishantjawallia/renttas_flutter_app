// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:renttas_flutter_app/Invoice/pages/pdfexport/pdfpreview.dart';

import '../../model/BillModel.dart';

class DetailPage extends StatelessWidget {
  final BIllModel invoice;
  const DetailPage({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfPreviewPage(
                invoice: invoice,
                subname: "",
              ),
            ),
          );
          // rootBundle.
        },
        child: Icon(Icons.picture_as_pdf,      color: Colors.white,),
      ),
      appBar: AppBar(
        title: Text(invoice.id),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Customer',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      invoice.id,
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Column(
                children: [
                  Text(
                    'Invoice Items',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  // ...invoice.items.map(
                  //   (e) => ListTile(
                  //     title: Text(e.description),
                  //     trailing: Text(
                  //       e.cost.toStringAsFixed(2),
                  //     ),
                  //   ),
                  // ),
                  DefaultTextStyle.merge(
                    style: Theme.of(context).textTheme.headline4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Total"),
                        Text(
                            //  invoice.totalCost().toStringAsFixed(2),
                            invoice.totalAmount),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
