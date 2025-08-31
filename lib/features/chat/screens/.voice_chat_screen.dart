import 'package:flutter/material.dart';

class VoiceChatScreen extends StatefulWidget {
  const VoiceChatScreen({super.key});

  @override
  State<VoiceChatScreen> createState() => _VoiceChatScreenState();
}

class _VoiceChatScreenState extends State<VoiceChatScreen>
    with SingleTickerProviderStateMixin {
  bool isListening = false;
  bool isAISpeaking = false;

  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);

    _scaleAnim = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleListening() {
    setState(() {
      if (isListening) {
        // If already listening, stop and AI responds
        isListening = false;
        isAISpeaking = true;

        Future.delayed(const Duration(seconds: 4), () {
          setState(() => isAISpeaking = false);
        });
      } else {
        // Start listening
        isListening = true;
        isAISpeaking = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7EDFC),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Middle Animated Blob
            Expanded(
              child: Center(
                child: ScaleTransition(
                  scale: _scaleAnim,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: isListening
                            ? [Colors.blue.shade400, Colors.blue.shade100]
                            : isAISpeaking
                                ? [Colors.orange.shade400, Colors.orange.shade100]
                                : [Colors.grey.shade300, Colors.grey.shade100],
                        center: Alignment.center,
                        radius: 0.8,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Status Text
            Text(
              isListening
                  ? "You're speaking"
                  : isAISpeaking
                      ? "AI's speaking"
                      : "Tap the button to speak",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 20),

            // Categories
            Wrap(
              spacing: 10,
              children: ["School Stress", "Bullying", "Relationships"]
                  .map((cat) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Text(cat,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500)),
                      ))
                  .toList(),
            ),

            const SizedBox(height: 20),

            // Bottom Voice Button
            GestureDetector(
              onTap: _toggleListening,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 56,
                decoration: BoxDecoration(
                  color: isListening ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mic,
                        color: isListening ? Colors.white : Colors.black),
                    const SizedBox(width: 12),
                    Text(
                      isListening
                          ? "……………Tap to interrupt……………"
                          : "……………Tap to speak……………",
                      style: TextStyle(
                        color: isListening ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
