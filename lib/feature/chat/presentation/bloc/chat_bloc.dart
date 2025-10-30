import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:neura/core/services/socket_service.dart';
import 'package:neura/feature/chat/domain/entities/message.dart';
import 'package:neura/feature/chat/domain/usecases/fetch_message_use_case.dart';
import 'package:neura/feature/chat/presentation/bloc/chat_event.dart';
import 'package:neura/feature/chat/presentation/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FetchMessageUseCase fetchMessageUseCase;
  final SocketService _socketService = SocketService();
  final List<Message> _messages = [];

  final _storage = const FlutterSecureStorage();
 

  ChatBloc({required this.fetchMessageUseCase}) : super(ChatLoadingState()) {
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<ReceiveMessageEvent>(_onReceiveMessage);
    

    _socketService.socket.on('receive_message', (data) {
      print('📥 Tin nhắn mới nhận được: $data');
      add(ReceiveMessageEvent(data));
    });
  }

  Future<void> _onLoadMessages(
    LoadMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoadingState());
    try {
      final messageList = await fetchMessageUseCase(event.conversationId);

      _messages
        ..clear()
        ..addAll(messageList);
      emit(ChatLoadedState(List.from(_messages)));

    
      // ✅ Tham gia đúng phòng
      _socketService.joinRoom(event.conversationId);
      
    } catch (e, stack) {
      print('❌ Lỗi load message: $e\n$stack');
      emit(ChatErrorState('Không thể tải tin nhắn'));
      
    }
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
     
    final userId = await _storage.read(key: 'userId') ?? '';
    if (userId.isEmpty) {
      print('⚠️ Không tìm thấy userId');
      return;
    }
    
    final newMessage = {
      'conversationId': event.conversationId,
      'senderId': userId,
      'content': event.content,
      
    };

    print('📤 Gửi tin nhắn: $newMessage');
    _socketService.socket.emit('send_message', newMessage);
  }

  void _onReceiveMessage(ReceiveMessageEvent event, Emitter<ChatState> emit) {
    final data = event.messageData;

  
    final sender = data['sender_id'];
    final senderId = sender is Map ? sender['_id'] : sender;

    final message = Message(
      id: data['_id'] ?? data['id'],
      conversationId: data['conversation_id'] ?? data['conversationId'],
      senderId: senderId,
      content: data['content'],
      createdAt: data['created_at'] ?? data['createdAt'],
    );

    _messages.add(message);
    emit(ChatLoadedState(List.from(_messages)));
  }
}
