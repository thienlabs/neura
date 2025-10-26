import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neura/feature/chat/presentation/screens/chat_screen.dart';
import 'package:neura/feature/contacts/presentation/bloc/contact_bloc.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ContactBloc>().add(FetchContactsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),

      body: BlocListener<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ConversationReady) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  conversationId: state.conversationId,
                  mate: state.contactName,
                ),
              ),
            );
          }
        },
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            if (state is ContactsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ContactsLoaded) {
              final contacts = state.contacts;
              if (contacts.isEmpty) {
                return const Center(child: Text('No contacts found'));
              }
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
                    ),
                    title: Text(contact.userName),
                    subtitle: Text(contact.email),
                    onTap: () {
                      context.read<ContactBloc>().add(
                            CheckOrCreateConversationEvent(
                              contactId: contact.id,
                              contactName: contact.userName,
                            ),
                          );
                    },
                  );
                },
              );
            } else if (state is ContactsError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox();
          },
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddContactDialog(context),
        icon: const Icon(Icons.person_add),
        label: const Text('Add'),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    final emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Contact'),
        content: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(hintText: 'Enter contact email'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final email = emailController.text.trim();
              if (email.isNotEmpty) {
                context.read<ContactBloc>().add(AddContactEvent(email: email));
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('⚠️ Please enter an email'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
