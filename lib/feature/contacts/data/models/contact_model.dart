import 'package:neura/feature/contacts/domain/entities/contact.dart';

class ContactModel extends Contact {
  ContactModel({required id, required userName, required email, required image})
    : super(id: id, userName: userName, email: email, image: image);
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['_id'] ?? '',
      userName: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
