import 'package:flutter/material.dart';

class LoadDocImage extends StatelessWidget {
  final imageUrl;
  const LoadDocImage( {required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Image.network(
          imageUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
