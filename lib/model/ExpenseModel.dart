class ExpenseModel {
  final String id;
  final String landlordId;
  final String propertyId;
  final String subPropertyId;
  final String category;
  final String name;
  final String amount;
  final String expensesDate;
  final String description;
  final String createdAt;
  final String updatedAt;

  ExpenseModel({
    required this.id,
    required this.landlordId,
    required this.propertyId,
    required this.subPropertyId,
    required this.category,
    required this.name,
    required this.amount,
    required this.expensesDate,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      landlordId: json['landlordId'],
      propertyId: json['propertyId'],
      subPropertyId: json['subPropertyId'],
      category: json['category'],
      name: json['name'],
     amount: json['amount'],
      expensesDate: json['expensesDate'],
      description: json['description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
