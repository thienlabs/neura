import 'package:flutter/material.dart';
import 'package:neura/core/themes/theme.dart';
import 'package:neura/feature/message/presentation/message_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neura App',
      theme: AppTheme.darkTheme,
      home: MessagesScreen()
    );
  }
}

