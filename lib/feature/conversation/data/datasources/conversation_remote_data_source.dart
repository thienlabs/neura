import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:neura/feature/conversation/data/models/conversation_model.dart';
import 'package:dio/dio.dart' as dio;

class ConversationRemoteDataSource {
  final String baseUrl = "https://neura-be.onrender.com";
  final _storage = FlutterSecureStorage();

  Future<List<ConversationModel>> fetchConversations() async {
    String token =
        await _storage.read(key: 'token') ??
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4ZjdhMTBkMWM1NThhNDQ3Y2YwYzdmYyIsImlhdCI6MTc2MTIxMzcyNywiZXhwIjoxNzYzODA1NzI3fQ.pelcWej-iBfcrOUTLV2YHTbYp2gcfAjzbZFT6bswb-4';
    final response = await dio.Dio().get(
      '${baseUrl}/conversations',
      options: dio.Options(headers: {'Authorization': 'Bearer $token'}),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;

      return data
          .map(
            (e) =>
                ConversationModel.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList();
    } else {
      throw Exception('Failed to load conversations');
    }
  }

  Future<String> checkOrCreateConvertion({required String contactId}) async {
    String token =
        await _storage.read(key: 'token') ??
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4ZjdhMTBkMWM1NThhNDQ3Y2YwYzdmYyIsImlhdCI6MTc2MTIxMzcyNywiZXhwIjoxNzYzODA1NzI3fQ.pelcWej-iBfcrOUTLV2YHTbYp2gcfAjzbZFT6bswb-4';
    final response = await dio.Dio().post(
      '${baseUrl}/conversations/check-or-create',
      options: dio.Options(headers: {'Authorization': 'Bearer $token'}),
      data: {'contact_id': contactId},
    );
    if (response.statusCode == 200) {
     return response.data['conversation_id'];
    }else {
      throw Exception('Failed to load conversations');
    }
  }
}
