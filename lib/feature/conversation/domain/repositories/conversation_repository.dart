import 'package:neura/feature/conversation/domain/entities/conversation.dart';

abstract class ConversationRepository {
  Future<List<Conversation>> fetchConversations();
  Future<String>checkOrCreateConversation({required String contactId});
}
