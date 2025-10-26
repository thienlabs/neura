import 'package:neura/feature/conversation/data/datasources/conversation_remote_data_source.dart';
import 'package:neura/feature/conversation/domain/entities/conversation.dart';
import 'package:neura/feature/conversation/domain/repositories/conversation_repository.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationRemoteDataSource converSationRemoteDataDource;

  ConversationRepositoryImpl({required this.converSationRemoteDataDource});

  @override
  Future<List<Conversation>> fetchConversations() async {
    return await converSationRemoteDataDource.fetchConversations();
  }

  @override
  Future<String> checkOrCreateConversation({required String contactId}) async {
    return await converSationRemoteDataDource.checkOrCreateConvertion(
      contactId: contactId,
    );
  }
}
