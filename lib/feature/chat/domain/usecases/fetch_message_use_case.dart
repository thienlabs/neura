
import 'package:neura/feature/chat/domain/entities/message.dart';
import 'package:neura/feature/chat/domain/repositories/message_repository.dart';

class FetchMessageUseCase {
  final MessageRepository repository;
  FetchMessageUseCase({required this.repository});
  Future<List<Message>> call(String conversationId) async {
    return await repository.fetchMessages(conversationId);
  }
}