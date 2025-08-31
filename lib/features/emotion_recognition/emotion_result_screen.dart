import 'package:flutter/material.dart';

class EmotionResultScreen extends StatelessWidget {
  final String mood;
  final double intensity;

  const EmotionResultScreen({super.key, required this.mood, required this.intensity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Emotion Result")),
      body: Center(
        child: Text(
          "Mood: $mood\nIntensity: ${(intensity * 100).round()}%",
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
