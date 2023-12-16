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
    return
      Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.green,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          title: Text('Add Property'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddPropertyLanlord(type:"1", userid: "0"'',)));
                },
                child: PropertyCard(
                  title: 'Residential Property',
                  description: 'A beautiful home in a peaceful neighborhood.',
                  icon: Icons.home,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PropertyCardsApp()));

                },
                child: PropertyCard(
                  title: 'Commercial Property',
                  description: 'A prime location for your business venture.',
                  icon: Icons.business,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),

    );
  }
}
