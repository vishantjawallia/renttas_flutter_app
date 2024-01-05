import 'subproperty_model.dart';

class PropertyModel {
  final String? id;
  final String? landlordId;
  final String? propertyName;
  final String? location;
  final String? createdAt;
  final String? updatedAt;
  final String? propertyTypeId;
  final String? pin;
  final List<SubPropertyModel>? subproperty;
  PropertyModel({
    this.id,
    this.landlordId,
    this.propertyName,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.propertyTypeId,
    this.pin,
    this.subproperty,
  });
  PropertyModel copyWith({
    String? id,
    String? landlordId,
    String? propertyName,
    String? location,
    String? createdAt,
    String? updatedAt,
    String? propertyTypeId,
    String? pin,
    List<SubPropertyModel>? subproperty,
  }) {
    return PropertyModel(
        id: id ?? this.id,
        landlordId: landlordId ?? this.landlordId,
        propertyName: propertyName ?? this.propertyName,
        location: location ?? this.location,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        propertyTypeId: propertyTypeId ?? this.propertyTypeId,
        pin: pin ?? this.pin,
        subproperty: subproperty ?? this.subproperty);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'landlordId': landlordId,
      'propertyName': propertyName,
      'location': location,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'propertyTypeId': propertyTypeId,
      'pin': pin,
      'subproperty': subproperty
    };
  }

  static PropertyModel fromJson(Map<String, Object?> json) {
    return PropertyModel(
        id: json['id'] == null ? null : json['id'] as String,
        landlordId: json['landlordId'] == null ? null : json['landlordId'] as String,
        propertyName: json['propertyName'] == null ? null : json['propertyName'] as String,
        location: json['location'] == null ? null : json['location'] as String,
        createdAt: json['createdAt'] == null ? null : json['createdAt'] as String,
        updatedAt: json['updatedAt'] == null ? null : json['updatedAt'] as String,
        propertyTypeId: json['propertyTypeId'] == null ? null : json['propertyTypeId'] as String,
        pin: json['pin'] == null ? null : json['pin'] as String,
        subproperty: json['subproperty'] == null ? null : SubPropertyModel.fromJsonList(json['subproperty']) as List<SubPropertyModel>);
  }

  static List<PropertyModel> fromJsonList(dynamic json) {
    List<PropertyModel> value = [];
    for (Map<String, dynamic> element in json) {
      value.add(PropertyModel.fromJson(element));
    }
    return value;
  }

  @override
  String toString() {
    return '''PropertyModel(
                id:$id,
landlordId:$landlordId,
propertyName:$propertyName,
location:$location,
createdAt:$createdAt,
updatedAt:$updatedAt,
propertyTypeId:$propertyTypeId,
pin:$pin,
subproperty:$subproperty
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is PropertyModel &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.landlordId == landlordId &&
        other.propertyName == propertyName &&
        other.location == location &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.propertyTypeId == propertyTypeId &&
        other.pin == pin &&
        other.subproperty == subproperty;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, landlordId, propertyName, location, createdAt, updatedAt, propertyTypeId, pin, subproperty);
  }
}
