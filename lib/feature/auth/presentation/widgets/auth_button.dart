import 'package:flutter/material.dart';
import 'package:neura/core/themes/theme.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback _onPressed;
  const AuthButton({
    super.key,
    required this.text,
    required VoidCallback onPressed,
  }) : _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }
}
