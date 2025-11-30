import 'package:flutter/material.dart';

class ConstraintScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Color? backgroundColor;
  final FloatingActionButton? floatingActionButton;
  const ConstraintScaffold({
    super.key,
    this.appBar,
    this.backgroundColor,
    required this.body,
    this.drawer,
    this.floatingActionButton
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          width: double.infinity,
          child: body,
        ),
      ),
    );
  }
}
