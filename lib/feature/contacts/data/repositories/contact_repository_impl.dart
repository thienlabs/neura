import 'package:neura/feature/contacts/data/datasources/contact_remote_data_source.dart';
import 'package:neura/feature/contacts/domain/entities/contact.dart';
import 'package:neura/feature/contacts/domain/repositories/contact_repository.dart';

class ContactRepositoryImpl extends ContactRepository {
  final ContactRemoteDataSource contactRemoteDataSource;

  ContactRepositoryImpl({required this.contactRemoteDataSource});
  @override
  Future<void> addContact(String email) async {
    return await contactRemoteDataSource.addContact(email);
  }

  @override
  Future<List<Contact>> fetchContacts() async {
    return await contactRemoteDataSource.fetchContact();
  }
}
