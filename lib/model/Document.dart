// ignore_for_file: unused_local_variable

class Documents {
  final String id;
  final String propertyId;
  final String subPropertyId;
  final String imageName;
  final String docType;
  final String docName;
  final String createdAt;
  final String updatedAt;
  static String host = 'https://renttas.com/doc/'; // Store the host value
  Documents({
    required this.id,
    required this.propertyId,
    required this.subPropertyId,
    required this.imageName,
    required this.docType,
    required this.docName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Documents.fromJson(Map<String, dynamic> json) {
    return Documents(
      id: json['id'],
      propertyId: json['propertyid'],
      subPropertyId: json['subPropertyid'],
      imageName: json['ImageName'],
      docType: json['doctype'],
      docName: json['docname'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  static List<Documents> fromJsonList(List<dynamic> collection) {
    List<Documents> value = [];
    for (Map<String, dynamic> element in collection) {
      value.add(Documents.fromJson(element));
    }
    return value;
  }
}
