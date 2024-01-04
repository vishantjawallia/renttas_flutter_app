// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

import '../Common/CommercialProperty.dart';
import '../Common/PropertyCard.dart';
import 'AddPropertyLanlord.dart';

class LandlordAddProperty extends StatefulWidget {
  const LandlordAddProperty({Key? key}) : super(key: key);

  @override
  State<LandlordAddProperty> createState() => _LandlordAddPropertyState();
}

class _LandlordAddPropertyState extends State<LandlordAddProperty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        title: const Text('Add Property'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPropertyLanlord(
                        type: "1",
                        userid: "0" '',
                      ),
                    ),
                  );
                },
                child: const PropertyCard(
                  title: 'Residential Property',
                  description: 'A beautiful home in a peaceful neighborhood.',
                  icon: Icons.home,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PropertyCardsApp())),
                child: const PropertyCard(
                  title: 'Commercial Property',
                  description: 'A prime location for your business venture.',
                  icon: Icons.business,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
