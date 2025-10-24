import 'package:neura/feature/chat/data/datasources/message_remote_data_source.dart';
import 'package:neura/feature/chat/domain/entities/message.dart';
import 'package:neura/feature/chat/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {

final MessageRemoteDataSource messageRemoteDataSource;

  MessageRepositoryImpl({required this.messageRemoteDataSource});
  @override
  Future<List<Message>> fetchMessages(String conversationId)async {
    return await messageRemoteDataSource.fetchMessages(conversationId);
  }

  @override
  Future<void> sendMessage(Message message) async{
    throw UnimplementedError();
   
  }
}
