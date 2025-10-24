import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neura/core/services/socket_service.dart';
import 'package:neura/feature/conversation/domain/usecases/fetch_conversation_use_case.dart';
import 'package:neura/feature/conversation/presentation/bloc/conversation_event.dart';
import 'package:neura/feature/conversation/presentation/bloc/conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final FetchConversationsUseCase fetchConversationsUseCase;
  final SocketService _socketService = SocketService();
  ConversationBloc({required this.fetchConversationsUseCase})
    : super(ConversationInitial()) {
    on<FetchConversationsEvent>(_onFetchConversations);

    _socketService.socket.on('conversationUpdate', _onConversationUpdate);
  }

  Future<void> _onFetchConversations(
    FetchConversationsEvent event,
    Emitter<ConversationState> emit,
  ) async {
    emit(ConversationLoading());
    try {
      final conversations = await fetchConversationsUseCase();
      emit(ConversationLoaded(conversations: conversations));
    } catch (e) {
      emit(ConversationError(message: e.toString()));
    }
  }

  void _onConversationUpdate(data) {
      print('🧩 Cập nhật hội thoại mới: $data');
    add(FetchConversationsEvent());
  }
}
