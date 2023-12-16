import 'SubProperty.dart';

class Property {
  final String id;
  final String propertyName;
  final List<SubProperty> subProperties;

  Property({
    required this.id,
    required this.propertyName,
    required this.subProperties,
  });
}