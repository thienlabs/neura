import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  late IO.Socket _socket;

  SocketService._internal() {
    initSocket();
  }

  void initSocket() {
    const String socketUrl =
        'https://neura-be.onrender.com'; 
    print('🔗 Khởi tạo Socket với URL: $socketUrl');

    _socket = IO.io(
      socketUrl,
      IO.OptionBuilder()
         .setTransports(['websocket'])
         .setPath('/socket.io/')
          .setTimeout(30000) 
          .enableAutoConnect()
          .setReconnectionAttempts(5) 
           .setReconnectionDelay(2000)
          .setExtraHeaders({'x-debug': 'true'})
          .build(),
    );

    _socket.onConnect((_) {
      print('✅ Socket kết nối thành công: ${_socket.id}');
    });

    _socket.onConnectError((data) {
      print('❌ Lỗi kết nối Socket: $data');
    });

    _socket.onError((data) {
      print('💥 Lỗi Socket: $data');
    });

    _socket.onDisconnect((_) {
      print('⚠️ Socket đã ngắt kết nối');
    });

    _socket.on('receive_message', (data) {
      print('📥 Nhận tin nhắn: $data');
    });

    _socket.on('message_error', (data) {
      print('❌ Lỗi tin nhắn: $data');
    });
  }

  IO.Socket get socket => _socket;

  void joinRoom(String conversationId) {
    _socket.emit('join_room', conversationId);
    print('📬 Đã tham gia phòng: $conversationId');
  }

  void sendMessage(String conversationId, String senderId, String content) {
    _socket.emit('send_message', {
      'conversationId': conversationId,
      'senderId': senderId,
      'content': content,
    });
    print('📤 Đã gửi tin nhắn: $content tới $conversationId');
  }
}
