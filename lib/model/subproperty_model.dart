class SubPropertyModel {
  final String? subPropertyName;
  final String? id;
  final String? propertyId;
  SubPropertyModel({this.subPropertyName, this.id, this.propertyId});
  SubPropertyModel copyWith({String? subPropertyName, String? id, String? propertyId}) {
    return SubPropertyModel(subPropertyName: subPropertyName ?? this.subPropertyName, id: id ?? this.id, propertyId: propertyId ?? this.propertyId);
  }

  Map<String, Object?> toJson() {
    return {'subPropertyName': subPropertyName, 'id': id, 'propertyId': propertyId};
  }

  static SubPropertyModel fromJson(Map<String, Object?> json) {
    return SubPropertyModel(
        subPropertyName: json['subPropertyName'] == null ? null : json['subPropertyName'] as String,
        id: json['id'] == null ? null : json['id'] as String,
        propertyId: json['propertyId'] == null ? null : json['propertyId'] as String);
  }

  @override
  String toString() {
    return '''SubPropertyModel(
                subPropertyName:$subPropertyName,
id:$id,
propertyId:$propertyId
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is SubPropertyModel && other.runtimeType == runtimeType && other.subPropertyName == subPropertyName && other.id == id && other.propertyId == propertyId;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, subPropertyName, id, propertyId);
  }

  static fromJsonList(dynamic json) {
    List<SubPropertyModel> value = [];
    for (Map<String, dynamic> element in json) {
      value.add(SubPropertyModel.fromJson(element));
    }
    return value;
  }
}
