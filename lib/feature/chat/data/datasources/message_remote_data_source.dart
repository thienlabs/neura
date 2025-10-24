import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:neura/feature/chat/data/models/message_mode.dart';
import 'package:dio/dio.dart' as dio;

class MessageRemoteDataSource {
  final String baseUrl = 'https://neura-be.onrender.com';
  final _storage = FlutterSecureStorage();

  Future<List<MessageModel>> fetchMessages(String conversationId) async {
    String token = await _storage.read(key: 'token') ?? '';

    final response = await dio.Dio().get(
      '$baseUrl/messages/$conversationId',
      options: dio.Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      final data = response.data['data']; // ✅ Lấy mảng đúng field
      print('Fetched ${data.length} messages');
      return data.map<MessageModel>((m) => MessageModel.fromJson(m)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
