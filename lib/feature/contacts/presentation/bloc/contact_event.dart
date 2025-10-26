part of 'contact_bloc.dart';

abstract class ContactEvent {}

class FetchContactsEvent extends ContactEvent {}

class CheckOrCreateConversationEvent extends ContactEvent {
  final String contactId;
  final String contactName;
  CheckOrCreateConversationEvent({required this.contactId, required this.contactName});
}

class AddContactEvent extends ContactEvent {
  final String email;

  AddContactEvent({required this.email});
}
