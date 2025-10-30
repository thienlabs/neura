import 'package:neura/feature/chat/domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    required super.id,
    required super.conversationId,
    required super.senderId,
    required super.content,
    required super.createdAt, 
   
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'] ?? '',
      conversationId: json['conversation_id'] ?? '',
      senderId: json['sender_id']?['_id'] ?? '',
      content: json['content'] ?? '',
      createdAt: json['created_at'],
    );
  }
}
