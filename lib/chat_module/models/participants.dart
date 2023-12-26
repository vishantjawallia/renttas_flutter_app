class Participants {
  final String? id;
  final String? userId;
  final String? role;
  final String? name;
  const Participants({
    this.id,
    this.userId,
    this.role,
    this.name,
  });
  Participants copyWith({String? id, String? userId, String? role, String? name}) {
    return Participants(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      name: name ?? this.name,
    );
  }

  Map<String, Object?> toJson() {
    return {'id': id, 'user_id': userId, 'role': role, 'name': name};
  }

  static Participants fromJson(Map<String, Object?> json) {
    return Participants(
        id: json['id'] == null ? null : json['id'] as String,
        userId: json['user_id'] == null ? null : json['user_id'] as String,
        role: json['role'] == null ? null : json['role'] as String,
        name: json['name'] == null ? null : json['name'] as String);
  }

  @override
  String toString() {
    return '''Participants(
                id:$id,
userId:$userId,
role:$role,
name:$name
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Participants && other.runtimeType == runtimeType && other.id == id && other.userId == userId && other.role == role && other.name == name;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, userId, role, name);
  }

  static fromJsonList(dynamic json) {
    List<Participants> data = [];

    for (Map<String, dynamic> element in json) {
      data.add(Participants.fromJson(element));
    }
    return data;
  }
}
