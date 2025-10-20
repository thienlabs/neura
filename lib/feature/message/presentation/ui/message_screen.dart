import 'package:flutter/material.dart';
import 'package:neura/core/themes/theme.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
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
              child: ListView(
                children: [
                  _buildMessageTile('Danny', 'dany@gmail.vn', '08.03'),
                  _buildMessageTile('Casu', 'casu@gmail.vn', '08.21'),
                  _buildMessageTile('Res', 'res@gmail.vn', '08.21'),
                  _buildMessageTile('Casu', 'casu@gmail.vn', '08.21'),
                ],
              ),
            ),
          ),
        ],
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
