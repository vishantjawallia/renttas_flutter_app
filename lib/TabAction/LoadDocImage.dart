// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class LoadDocImage extends StatelessWidget {
  final imageUrl;
  const LoadDocImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Image.network(
          imageUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
