import 'package:flutter/material.dart';
import '../../../core/widgets/gradient_background.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  bool isFetchingAudio = false;

  void onMicPressed() {
    setState(() => isFetchingAudio = true);
    // Simulate "fetching audio" process; you’d trigger your actual audio logic here
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => isFetchingAudio = false);
        // Optionally, navigate to the voice chat screen or process result
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(height: 16),
                Text(
                  "Hey, Jane\nTell me what’s on your mind today",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  "You can tell me something specific, pick from the categories below or even start a voice chat with me",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 12,
                  children: [
                    FilterChip(label: const Text("School Stress"), onSelected: (_) {}),
                    FilterChip(label: const Text("Bullying"), onSelected: (_) {}),
                    FilterChip(label: const Text("Relationships"), onSelected: (_) {}),
                  ],
                ),
                const Spacer(),
                if (isFetchingAudio) ...[
                  Center(
                    child: Column(
                      children: const [
                        SizedBox(height: 16),
                        CircularProgressIndicator(),
                        SizedBox(height: 8),
                        Text("Fetching audio..."),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Talk to me",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FloatingActionButton(
                      mini: true,
                      heroTag: null,
                      onPressed: isFetchingAudio ? null : onMicPressed,
                      child: const Icon(Icons.mic),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
