import 'package:renttas_flutter_app/chat_module/models/messages.dart';
import 'package:renttas_flutter_app/chat_module/models/participants.dart';

class Chats {
  final String? id;
  final List<Participants>? participants;
  final List<Messages>? messages;
  Chats({this.id, this.participants, this.messages});
  Chats copyWith({
    String? id,
    List<Participants>? participants,
    List<Messages>? messages,
  }) {
    return Chats(
      id: id ?? this.id,
      participants: participants ?? this.participants,
      messages: messages ?? this.messages,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'participants': participants,
      'messages': messages,
    };
  }

  static Chats fromJson(Map<String, Object?> json) {
    return Chats(
      id: json['id'] == null ? null : json['id'] as String,
      participants: json['participants'] == null ? null : Participants.fromJsonList(json['participants']) as List<Participants>,
      messages: json['messages'] == null ? null : Messages.fromJsonList(json['messages']) as List<Messages>,
    );
  }

  static List<Chats> fromJsonList(dynamic value) {
    List<Chats> data = [];

    for (Map<String, dynamic> element in value) {
      data.add(Chats.fromJson(element));
    }
    return data;
  }

  @override
  String toString() {
    return '''Chats(
                id:$id,
participants:$participants,
messages:$messages
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Chats && other.runtimeType == runtimeType && other.id == id && other.participants == participants && other.messages == messages;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, participants, messages);
  }
}

List chats = [
  {
    "id": "123456789",
    "participants": [
      {"id": "1", "user_id": "admin123", "role": "admin", "name": "Admin User"},
      {"id": "2", "user_id": "5fca84cf-9302-4cd8-ae76-f7427ac3f072", "role": "landlord", "name": "bhuvi jwallia"}
    ],
    "messages": [
      {"id": "2", "senderId": "5fca84cf-9302-4cd8-ae76-f7427ac3f072", "timestamp": "2023-01-01T10:05:00", "content": "Hi"},
      {"id": "1", "senderId": "admin123", "timestamp": "2023-01-01T10:00:00", "content": "Hi, how may i help you"},
      {"id": "4", "senderId": "5fca84cf-9302-4cd8-ae76-f7427ac3f072", "timestamp": "2023-01-01T10:15:00", "content": "how are you ?"},
      {"id": "3", "senderId": "admin123", "timestamp": "2023-01-01T10:10:00", "content": "i am fine how are you ?"},
      {"id": "6", "senderId": "5fca84cf-9302-4cd8-ae76-f7427ac3f072", "timestamp": "2023-01-01T10:25:00", "content": "i am good"},
      {"id": "7", "senderId": "5fca84cf-9302-4cd8-ae76-f7427ac3f072", "timestamp": "2023-01-01T10:25:00", "content": "can you help me with preimum package"},
    ]
  }
];
