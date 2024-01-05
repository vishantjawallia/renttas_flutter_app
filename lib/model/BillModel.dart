
class BIllModel {
  final String id;
  final String landlordId;
  final String propertyId;
  final String subpropertyId;
  final String rentCycle;
  final String rentStartDate;
  final String rentEndDate;
  final String collectBy;
  final String previousBalance;
  final String rentAmount;
  final String maintenanceAmount;
  final String totalAmount;
  final String electricityType;
  final String electricCharge;
  final String waterBillType;
  final String waterBillCharge;
  final String gasBillType;
  final String gasBillCharge;
  final String createdAt;
  final String updatedAt;

  BIllModel({
    required this.id,
    required this.landlordId,
    required this.propertyId,
    required this.subpropertyId,
    required this.rentCycle,
    required this.rentStartDate,
    required this.rentEndDate,
    required this.collectBy,
    required this.previousBalance,
    required this.rentAmount,
    required this.maintenanceAmount,
    required this.totalAmount,
    required this.electricityType,
    required this.electricCharge,
    required this.waterBillType,
    required this.waterBillCharge,
    required this.gasBillType,
    required this.gasBillCharge,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BIllModel.fromJson(Map<String, dynamic> json) {
    return BIllModel(
      id: json['id'],
      landlordId: json['landlordId'],
      propertyId: json['propertyId'],
      subpropertyId: json['subpropertyId'],
      rentCycle: json['rentCycle'],
      rentStartDate: json['rentStartData'],
      rentEndDate: json['rentEndDate'],
      collectBy: json['collectdBy'],
      previousBalance: json['perviousBalance'],
      rentAmount: json['rentAmount'],
      maintenanceAmount: json['maintenanceAmount'],
      totalAmount: json['totalAmount'],
      electricityType: json['electricityType'],
      electricCharge: json['electricCharge'] ?? "",
      waterBillType: json['waterBillType'],
      waterBillCharge: json['waterBillCharge'] ?? "",
      gasBillType: json['gasBillType'],
      gasBillCharge: json['gasBillCharge'] ?? "",
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  static List<BIllModel> fromJsonList(List<dynamic> data) {
    List<BIllModel> value = [];
    for (Map<String, dynamic> element in data) {
      value.add(BIllModel.fromJson(element));
    }
    return value;
  }
}

//tt@gmail.com -- 123
