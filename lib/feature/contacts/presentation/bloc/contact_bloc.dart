import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:neura/feature/contacts/domain/entities/contact.dart';
import 'package:neura/feature/contacts/domain/usecases/add_contact_use_case.dart';
import 'package:neura/feature/contacts/domain/usecases/fetch_contact_use_case.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final FetchContactUseCase fetchContactUseCase;
  final AddContactUseCase addContactUseCase;

  ContactBloc({
    required this.fetchContactUseCase,
    required this.addContactUseCase,
  }) : super(ContactInitial()) {
    // ✅ Đăng ký các event ở đây
    on<FetchContacts>(_onFetchContacts);
    on<AddContact>(_onAddContact);
  }

  // ✅ Xử lý fetch contact
  Future<void> _onFetchContacts(
    FetchContacts event,
    Emitter<ContactState> emit,
  ) async {
    emit(ContactsLoading());
    try {
      final contacts = await fetchContactUseCase();
      emit(ContactsLoaded(contacts));
    } catch (e) {
      emit(ContactsError('Failed to fetch contacts: $e'));
    }
  }

  // ✅ Xử lý add contact
  Future<void> _onAddContact(
    AddContact event,
    Emitter<ContactState> emit,
  ) async {
    emit(ContactsLoading());
    try {
      await addContactUseCase(email: event.email);
        emit(ContactAdded());
     
      final contacts = await fetchContactUseCase();
      emit(ContactsLoaded(contacts));
    
    } catch (e) {
    emit(ContactsError(e.toString()));
    }
  }
}
