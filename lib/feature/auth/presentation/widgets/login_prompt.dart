import 'package:flutter/material.dart';

class LoginPrompt extends StatelessWidget {
  final String text;
  final String subtittle;
  final VoidCallback _onTap;
  const LoginPrompt({
    super.key,
    required VoidCallback onTap,
    required this.text, required this.subtittle,
  }) : _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _onTap,
        child: RichText(
          text: TextSpan(
            text: text,
            style: TextStyle(color: Colors.grey),
            children: [
              TextSpan(
                text: subtittle,
                style: TextStyle(color: Colors.blueGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
