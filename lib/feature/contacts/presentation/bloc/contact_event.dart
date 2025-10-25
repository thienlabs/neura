part of 'contact_bloc.dart';

abstract class ContactEvent {}

class FetchContacts extends ContactEvent {}

class AddContact extends ContactEvent {
  final String email;

  AddContact({required this.email});

}
