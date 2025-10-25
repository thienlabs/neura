import 'package:neura/feature/contacts/domain/entities/contact.dart';

abstract class ContactRepository {
  Future<List<Contact>> fetchContacts();
  Future<void> addContact(String email);
}
