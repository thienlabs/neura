import 'package:neura/feature/chat/domain/entities/message.dart';

abstract class MessageRepository {
  Future<List<Message>> fetchMessages(String conversationId);
  Future<void> sendMessage(Message message);
  
}
