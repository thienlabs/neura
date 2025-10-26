  import 'package:neura/feature/conversation/domain/entities/conversation.dart';
  import 'package:neura/feature/conversation/domain/repositories/conversation_repository.dart';

  class CheckOrCreateConversationUseCase {
    final ConversationRepository conversationRepository;

    CheckOrCreateConversationUseCase({required this.conversationRepository});

    Future<String> call({required String contactId}) async {
      return await conversationRepository.checkOrCreateConversation(contactId: contactId);
    }
  }
