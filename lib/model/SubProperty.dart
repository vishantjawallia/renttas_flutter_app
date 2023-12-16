class SubProperty {
  final String id;
  final String subPropertyName;

  SubProperty({required this.id, required this.subPropertyName});

  factory SubProperty.fromJson(Map<String, dynamic> json) {
    return SubProperty(
      id: json['id'],
      subPropertyName: json['subPropertyName'],
    );
  }
}