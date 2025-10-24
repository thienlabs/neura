import 'package:neura/feature/conversation/domain/entities/conversation.dart';

abstract class ConversationState{}

class ConversationInitial extends ConversationState {}

class ConversationLoading extends ConversationState {}

class ConversationLoaded extends ConversationState {
  final List<Conversation>  conversations;

  ConversationLoaded({required this.conversations});

}

class ConversationError extends ConversationState {
  final String message;

  ConversationError({required this.message});
}