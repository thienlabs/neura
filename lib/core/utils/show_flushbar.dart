import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

Future<void> showFlushbarStyle(
  BuildContext context, {
  required String title,
  required String message,
  Color backgroundColor = Colors.green,
  Duration duration = const Duration(seconds: 3),
}) async {
  await Flushbar(
    title: title,
    message: message,
    backgroundColor: backgroundColor,
    duration: duration,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(20),
    flushbarPosition: FlushbarPosition.TOP, 
    icon: const Icon(Icons.check_circle, color: Colors.white),
  ).show(context);
}
