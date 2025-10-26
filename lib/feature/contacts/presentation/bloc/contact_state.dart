part of 'contact_bloc.dart';

abstract class ContactState {}

final class ContactInitial extends ContactState {}

class ContactsLoading extends ContactState {}

class ContactsLoaded extends ContactState {
  final List<Contact> contacts;

  ContactsLoaded(this.contacts);
}

class ContactsError extends ContactState {
  final String message;

  ContactsError(this.message);
}

class ContactAdded extends ContactState {}

class ConversationReady extends ContactState {
  final String conversationId;
  final String contactName;

  ConversationReady({required this.conversationId, required this.contactName});

  

}
