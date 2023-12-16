// ignore_for_file: use_key_in_widget_constructors, prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:flutter/material.dart';

import '../Commertial/CommertialDashboard.dart';
import '../Inventory/Dashboard.dart';




class PropertyCardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: const Text('Commercial Property List'),
        ),
        body: CommercialPropertyList(),
      );

  }
}

class CommercialProperty {
  final String propertyName;
  final String location;
  final IconData icon;

  CommercialProperty({
    required this.propertyName,
    required this.location,
    required this.icon,
  });
}

class CommercialPropertyList extends StatelessWidget {
  final List<CommercialProperty> commercialProperties = [
    CommercialProperty(
      propertyName: 'Office Space 1',
      location: 'Downtown',
      icon: Icons.business,
    ),
    CommercialProperty(
      propertyName: 'Retail Store',
      location: 'Mall',
      icon: Icons.store,
    ),
    CommercialProperty(
      propertyName: 'Land / banquet hall',
      location: 'Land',
      icon: Icons.landscape,
    ),
    CommercialProperty(
      propertyName: 'Warehouse',
      location: 'Inventory Management',
      icon: Icons.storage,
    ),
    // Add more commercial properties here
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: commercialProperties.length,
      itemBuilder: (context, index) {
        final commercialProperty = commercialProperties[index];
        return GestureDetector(
          onTap: () {
            log("clicked==="+commercialProperties[index].propertyName);
            if(commercialProperties[index].propertyName=="Warehouse"){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const inentorydashboard()));

            }else{
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const commerialdashboard()));

            }
                    },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 5,
            child: ListTile(
              leading: Icon(commercialProperty.icon),
              title: Text(commercialProperty.propertyName),
              subtitle: Text(commercialProperty.location),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        );
      },
    );
  }
}

class CommercialPropertyDetail extends StatelessWidget {
  final CommercialProperty commercialProperty;

  const CommercialPropertyDetail({required this.commercialProperty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commercial Property Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              commercialProperty.propertyName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Location: ${commercialProperty.location}',
              style: const TextStyle(fontSize: 18),
            ),
            // Add more property details here
          ],
        ),
      ),
    );
  }
}
