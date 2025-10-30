
import 'package:neura/feature/chat/domain/entities/message.dart';

abstract class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoadingState extends ChatState {

}
final class ChatLoadedState extends ChatState {
  final List<Message> messages;

  ChatLoadedState(this.messages);
}
final class ChatErrorState extends ChatState {
  final String message;

  ChatErrorState(this.message);
}
