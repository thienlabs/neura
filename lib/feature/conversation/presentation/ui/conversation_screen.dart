import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neura/core/themes/theme.dart';
import 'package:neura/feature/chat/presentation/screens/chat_screen.dart';
import 'package:neura/feature/contacts/presentation/ui/contacts_screen.dart';
import 'package:neura/feature/conversation/presentation/bloc/conversation_bloc.dart';
import 'package:neura/feature/conversation/presentation/bloc/conversation_event.dart';
import 'package:neura/feature/conversation/presentation/bloc/conversation_state.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ConversationBloc>(context).add(FetchConversationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 16.0),
            child: Text('Recent', style: Theme.of(context).textTheme.bodySmall),
          ),

          Container(
            height: 100,
            padding: EdgeInsets.all(5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildRecentContact('Ji Seon', context),
                _buildRecentContact('Cherry', context),
                _buildRecentContact('Apple', context),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: DefaultColors.sentMessageInput,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: BlocBuilder<ConversationBloc, ConversationState>(
                builder: (context, state) {
                  if (state is ConversationLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ConversationLoaded) {
                    return ListView.builder(
                      itemCount: state.conversations.length,
                      itemBuilder: (context, index) {
                        final conversation = state.conversations[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  conversationId: conversation.id,
                                  mate: conversation.participantName,
                                ),
                              ),
                            );
                          },
                          child: _buildMessageTile(
                            conversation.participantName,
                            conversation.lastMessage,
                            conversation.lastMessageTime.toString(),
                          ),
                        );
                      },
                    );
                  } else if (state is ConversationError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return Center(child: Text('No conversations found.'));
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactsScreen()),
          );
        },
        backgroundColor: DefaultColors.buttonColor,
        child: Icon(Icons.contacts),
      ),
    );
  }
}

Widget _buildRecentContact(String name, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
        ),
        Text(name, style: Theme.of(context).textTheme.bodyMedium),
      ],
    ),
  );
}

Widget _buildMessageTile(String name, String message, String time) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    leading: CircleAvatar(
      radius: 30,
      backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
    ),
    title: Text(
      name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      message,
      style: TextStyle(color: Colors.grey),
      overflow: TextOverflow.ellipsis,
    ),
    trailing: Text(time, style: TextStyle(color: Colors.grey)),
  );
}
