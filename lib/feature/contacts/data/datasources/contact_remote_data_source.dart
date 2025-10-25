import 'package:dio/dio.dart' as dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:neura/feature/contacts/data/models/contact_model.dart';

class ContactRemoteDataSource {
  final String baseUrl = 'https://neura-be.onrender.com';
final _storage = FlutterSecureStorage();
 Future<List<ContactModel>> fetchContact() async {
     try {
     
      final token = await _storage.read(key: 'token') ?? '';

     
      final response = await dio.Dio().get(
        '$baseUrl/contacts',
        options: dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> contactList = response.data['contacts'];

        return contactList
            .map((contactJson) => ContactModel.fromJson(contactJson))
            .toList();
      } else {
        throw Exception('Failed to fetch contacts: ${response.statusMessage}');
      }
    } catch (e) {
      print('❌ Error fetching contacts: $e');
      throw Exception('Error fetching contacts: $e');
    }
  }
  Future<void> addContact(String email) async
  {
      final token = await _storage.read(key: 'token') ?? '';
      try{
        final response = await dio.Dio().post(
        '$baseUrl/contacts/add',
        data: {'email':email},
        options: dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
        if (response.statusCode == 201 ) {
        print('✅ Contact added: ${response.data['contact']}');
      } 
      if (response.statusCode == 404) {
  throw Exception('User not found');
}

      else {
        print('⚠️ Failed to add contact: ${response.statusMessage}');
      }
      }catch(e)
      {
          print('❌ Error adding contact: $e');
      }
  }
}
