class Messages {
  final String? id;
  final String? senderId;
  final String? timestamp;
  final String? content;
  const Messages({this.id, this.senderId, this.timestamp, this.content});
  Messages copyWith({String? id, String? senderId, String? timestamp, String? content}) {
    return Messages(id: id ?? this.id, senderId: senderId ?? this.senderId, timestamp: timestamp ?? this.timestamp, content: content ?? this.content);
  }

  Map<String, Object?> toJson() {
    return {'id': id, 'senderId': senderId, 'timestamp': timestamp, 'content': content};
  }

  static Messages fromJson(Map<String, Object?> json) {
    return Messages(
        id: json['id'] == null ? null : json['id'] as String,
        senderId: json['senderId'] == null ? null : json['senderId'] as String,
        timestamp: json['timestamp'] == null ? null : json['timestamp'] as String,
        content: json['content'] == null ? null : json['content'] as String);
  }

  @override
  String toString() {
    return '''Messages(
                id:$id,
senderId:$senderId,
timestamp:$timestamp,
content:$content
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Messages && other.runtimeType == runtimeType && other.id == id && other.senderId == senderId && other.timestamp == timestamp && other.content == content;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, senderId, timestamp, content);
  }

  static fromJsonList(dynamic json) {
    List<Messages> data = [];

    for (Map<String, dynamic> element in json) {
      data.add(Messages.fromJson(element));
    }
    return data;
  }
}
