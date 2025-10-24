import 'package:neura/feature/conversation/domain/entities/conversation.dart';
import 'package:neura/feature/conversation/domain/repositories/conversation_repository.dart';

class FetchConversationsUseCase {
  final ConversationRepository repository;

  FetchConversationsUseCase({required this.repository});

  Future<List<Conversation>> call() async {
    return await repository.fetchConversations();
  }
}
