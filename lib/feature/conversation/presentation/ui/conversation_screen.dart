import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:neura/core/themes/theme.dart';
import 'package:neura/core/utils/date_formatter.dart';
import 'package:neura/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:neura/feature/auth/presentation/bloc/auth_event.dart';
import 'package:neura/feature/auth/presentation/bloc/auth_state.dart';
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
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu),
          ),
        ),
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
      drawer: Drawer(
        child: Container(
          color: AppColors.primaryBackground,
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text('PROFILE'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('NOTIFICATIONS'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('SETTINGS'),
                onTap: () {},
              ),

              Spacer(),
              Divider(),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  
                   if (state is AuthLoggedOut) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  }
                },
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('LOGOUT'),
                  onTap: ()async {
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
                      await Future.delayed(const Duration(seconds: 2));
                    context.read<AuthBloc>().add(LogoutEvent());
                  },
                ),
              ),
            ],
          ),
        ),
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
            child: BlocBuilder<ConversationBloc, ConversationState>(
              builder: (context, state) {
                if (state is ConversationLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ConversationLoaded) {
                  return ListView.builder(
                    itemCount: state.conversations.length,
                    scrollDirection: Axis.horizontal,
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
                                image: conversation.participantImage,
                              ),
                            ),
                          );
                        },
                        child: _buildRecentContact(
                          conversation.participantName,
                          conversation.participantImage,
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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.sentMessageInput,
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
                                  image: conversation.participantImage,
                                ),
                              ),
                            );
                          },
                          child: _buildMessageTile(
                            conversation.participantName,
                            conversation.participantImage,
                            conversation.lastMessage,
                            DateFormatter.formatLastMessageTime(
                              conversation.lastMessageTime,
                            ),
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
        backgroundColor: AppColors.buttonColor,
        child: Icon(Icons.contacts),
      ),
    );
  }
}

Widget _buildRecentContact(String name, String image) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: [
        CircleAvatar(radius: 30, backgroundImage: NetworkImage(image)),
        Text(
          name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget _buildMessageTile(
  String name,
  String image,
  String message,
  String time,
) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    leading: CircleAvatar(radius: 30, backgroundImage: NetworkImage(image)),
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
