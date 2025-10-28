import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:neura/feature/contacts/domain/entities/contact.dart';
import 'package:neura/feature/contacts/domain/usecases/add_contact_use_case.dart';
import 'package:neura/feature/contacts/domain/usecases/fetch_contact_use_case.dart';
import 'package:neura/feature/conversation/domain/usecases/check_or_create_conversation_use_case.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final FetchContactUseCase fetchContactUseCase;
  final AddContactUseCase addContactUseCase;
  final CheckOrCreateConversationUseCase checkOrCreateConversationUseCase;
  ContactBloc({
    required this.fetchContactUseCase,
    required this.addContactUseCase,
    required this.checkOrCreateConversationUseCase,
  }) : super(ContactInitial()) {
    // ✅ Đăng ký các event ở đây
    on<FetchContactsEvent>(_onFetchContacts);
    on<AddContactEvent>(_onAddContact);
    on<CheckOrCreateConversationEvent>(_onCheckOrCreateConversationEvent);
  }

  // ✅ Xử lý fetch contact
  Future<void> _onFetchContacts(
    FetchContactsEvent event,
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
    AddContactEvent event,
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

  Future<void> _onCheckOrCreateConversationEvent(
    CheckOrCreateConversationEvent event,
    Emitter<ContactState> emit,
  ) async {
    try {
    //  emit(ContactsLoading());
      final conversationId= await checkOrCreateConversationUseCase(
        contactId: event.contactId,
        
      );
      emit(ConversationReady(conversationId: conversationId, contactName: event.contactName,image: event.contactImage,));
    } catch (e) {
      emit(ContactsError(e.toString()));
    }
  }
}
