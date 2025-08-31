import 'package:flutter/material.dart';
import '../../../models/emotion.dart';

class MoodCarousel extends StatelessWidget {
  final List<Emotion> moods;
  final int selectedMood;
  final ValueChanged<int> onMoodChanged;

  const MoodCarousel({
    super.key,
    required this.moods,
    required this.selectedMood,
    required this.onMoodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.5, initialPage: selectedMood),
        itemCount: moods.length,
        onPageChanged: onMoodChanged,
        itemBuilder: (context, idx) {
          final isSelected = idx == selectedMood;
          final mood = moods[idx];
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.symmetric(horizontal: isSelected ? 8 : 18, vertical: isSelected ? 0 : 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue[100] : Colors.grey[200],
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(mood.emoji, style: TextStyle(fontSize: isSelected ? 36 : 28)),
                  SizedBox(height: 8),
                  Text(
                    mood.name,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: isSelected ? 20 : 16,
                      color: isSelected ? Colors.blue[800] : Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}