class TendentModel {
  final String id;
  final String propertyId;
  final String subPropertyId;
  final String tenantName;
  final String phone;
  final String email;
  final String advanceAmount;
  final String createdAt;
  final String updatedAt;

  TendentModel({
    required this.id,
    required this.propertyId,
    required this.subPropertyId,
    required this.tenantName,
    required this.phone,
    required this.email,
    required this.advanceAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TendentModel.fromJson(Map<String, dynamic> json) {
    return TendentModel(
      id: json['id'],
      propertyId: json['propertyId'],
      subPropertyId: json['subPropertyId'],
      tenantName: json['tenantName'],
      phone: json['phone'],
      email: json['email'],
      advanceAmount: json['advanceAmount'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
