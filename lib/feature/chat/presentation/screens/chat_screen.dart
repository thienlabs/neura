import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:neura/core/reposive/constraint_scaffold.dart';
import 'package:neura/core/themes/theme.dart';
import 'package:neura/feature/chat/presentation/bloc/chat_bloc.dart';
import 'package:neura/feature/chat/presentation/bloc/chat_event.dart';
import 'package:neura/feature/chat/presentation/bloc/chat_state.dart';

class ChatScreen extends StatefulWidget {
  final String conversationId;
  final String mate;
  final String image;
  const ChatScreen({
    super.key,
    required this.conversationId,
    required this.mate,
    required this.image,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final _storage = FlutterSecureStorage();
  String userId = '';
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatBloc>(
      context,
    ).add(LoadMessagesEvent(widget.conversationId));

    fetchUserId();
  }

  void fetchUserId() async {
    userId = await _storage.read(key: 'userId') ?? '';
    setState(() {
      userId = userId;
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final content = _messageController.text.trim();
    if (content.isNotEmpty) {
      BlocProvider.of<ChatBloc>(
        context,
      ).add(SendMessageEvent(widget.conversationId, content));
      _messageController.clear();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstraintScaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(widget.image)),
            SizedBox(width: 10),
            Text(widget.mate, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoadingState) {
                  return Center(
                    child: LoadingAnimationWidget.progressiveDots(
                      color: AppColors.senderMessage,
                      size: 40,
                    ),
                  );
                } else if (state is ChatLoadedState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  });

                  return ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: state.messages.length,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      final isSentMessage =
                          message.senderId.toString() == userId;
                      if (isSentMessage) {
                        return _buildSendMessage(context, message.content);
                      } else {
                        return _buildReceivedMessage(context, message.content);
                      }
                    },
                  );
                } else if (state is ChatErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                return Center(child: Text('No message fount'));
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.receiverMessage,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Text(message, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildSendMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.senderMessage,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      margin: EdgeInsets.all(15),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.camera_alt, color: Colors.grey),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.photo, color: Colors.grey),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/svg/ic_micro.svg',
              color: Colors.grey,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _messageController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Aa',
                hintStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                filled: true,
                fillColor: AppColors.sentMessageInput,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: _sendMessage,
            child: SvgPicture.asset(
              'assets/svg/ic_send.svg',
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
