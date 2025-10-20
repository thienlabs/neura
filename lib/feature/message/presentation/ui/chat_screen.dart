import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neura/core/themes/theme.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
            ),
            SizedBox(width: 10),
            Text('Danny Hokin', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                _buildReceivedMessage(context, 'Hey, are we still.  '),
                _buildSendMessage(
                  context,
                  'Sounds amazing! But I’m currently.',
                ),
              ],
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
          color: DefaultColors.receiverMessage,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
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
          color: DefaultColors.senderMessage,
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
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Aa',
                hintStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                filled: true,
                fillColor: DefaultColors.sentMessageInput,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          GestureDetector(
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
