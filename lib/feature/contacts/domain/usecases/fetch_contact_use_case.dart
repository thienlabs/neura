import 'package:neura/feature/contacts/domain/entities/contact.dart';
import 'package:neura/feature/contacts/domain/repositories/contact_repository.dart';

class FetchContactUseCase {
  final ContactRepository contactRepository;

  FetchContactUseCase({required this.contactRepository});

  Future<List<Contact>> call() async {
    return await contactRepository.fetchContacts();
  }
}
