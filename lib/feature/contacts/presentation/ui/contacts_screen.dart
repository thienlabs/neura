import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:neura/core/themes/theme.dart';
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
        listener: (context, state) async {
          if (state is ConversationReady) {
            Navigator.pop(context);
            final res = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  conversationId: state.conversationId,
                  mate: state.contactName,
                  image: state.image,
                ),
              ),
            );
            if (res == null) {
              context.read<ContactBloc>().add(FetchContactsEvent());
            }
          }
        },
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            if (state is ContactsLoading) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: AppColors.senderMessage,
                  size: 40,
                ),
              );
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
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(contact.image,scale: 1.0),
                    ),
                    title: Text(contact.userName),
                    subtitle: Text(contact.email),
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: AppColors.senderMessage,
                            size: 60,
                          ),
                        ),
                      );
                      context.read<ContactBloc>().add(
                        CheckOrCreateConversationEvent(
                          contactId: contact.id,
                          contactName: contact.userName,
                          contactImage: contact.image,
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

      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        child: const Icon(Icons.person_add),
        backgroundColor: AppColors.buttonColor,
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
