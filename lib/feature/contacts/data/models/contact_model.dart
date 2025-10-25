import 'package:neura/feature/contacts/domain/entities/contact.dart';

class ContactModel extends Contact {
  ContactModel({
    required id,
    required userName,
    required email,
  }):super(
    id: id,
    userName: userName,
    email: email
  );
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['_id'] ?? '',
      userName: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
  
}
