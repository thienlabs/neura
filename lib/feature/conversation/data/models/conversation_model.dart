import 'package:neura/feature/conversation/domain/entities/conversation.dart';

class ConversationModel extends Conversation {
  ConversationModel({
    required String id,
    required String participantName,
    required String participantImage,
    required String lastMessage,
    required String lastMessageTime,
  }) : super(
          id: id,
          participantName: participantName,
          lastMessage: lastMessage,
          lastMessageTime: lastMessageTime,
          participantImage:participantImage
        );

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['conversation_id'] ?? '',
      participantName: json['participant_name'] ?? 'Unknown User',
      participantImage:json['participant_image'] ?? 'https://www.gravatar.com/avatar/?d=mp',
      lastMessage: json['last_message'] ?? '',
      lastMessageTime: json['last_message_time'] ?? '',
    );
  }
}
