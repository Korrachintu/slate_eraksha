import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,   // <-- Ensures full height
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFDEE6FA), Color(0xFFC4E0F7), Color(0xFFFBEDDA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}
