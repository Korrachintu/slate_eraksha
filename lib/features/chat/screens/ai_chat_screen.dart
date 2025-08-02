import 'package:flutter/material.dart';
import '../../../core/widgets/gradient_background.dart';

class ChatMessage {
  final String text;
  final bool isUser; // true=user, false=ai

  ChatMessage({required this.text, required this.isUser});
}

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  bool isFetchingAudio = false;
  bool isLoadingAI = false;
  final TextEditingController _controller = TextEditingController();

  final List<ChatMessage> _messages = [
    ChatMessage(text: "How can I help you today?", isUser: false),
  ];

  void sendUserMessage(String text) async {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(text: text.trim(), isUser: true));
      isLoadingAI = true;
      _controller.clear();
    });

    // ---- ready for backend: replace this delay with your network/backend call ----
    await Future.delayed(const Duration(seconds: 1));
    final aiReplyText = "AI response to: $text"; // Replace with real backend response

    setState(() {
      _messages.add(ChatMessage(text: aiReplyText, isUser: false));
      isLoadingAI = false;
    });
  }

  void onMicPressed() async {
    setState(() => isFetchingAudio = true);
    // ---- Integrate your audio-to-text backend/service here ----
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => isFetchingAudio = false);

    // Example: after "listening", we simulate received voice input:
    const simulatedVoiceMessage = "This is my problem via voice";
    sendUserMessage(simulatedVoiceMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "AI Chat",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              // Chat Messages List
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16), // chat bubble margins
                  child: ListView.builder(
                    itemCount: _messages.length,
                    reverse: false,
                    itemBuilder: (context, idx) {
                      final msg = _messages[idx];
                      return Align(
                        alignment: msg.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: msg.isUser
                                ? Colors.blueAccent.withAlpha((0.1*255).round())
                                : Colors.white.withAlpha((0.7*255).round()),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(msg.text,
                              style: TextStyle(
                                color: msg.isUser ? Colors.blue[900] : Colors.black87,
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (isLoadingAI)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: CircularProgressIndicator(),
                ),
              if (isFetchingAudio)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 8),
                      Text("Listening..."),
                    ],
                  ),
                ),
              // Input
              if (!isFetchingAudio)
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Row(
                      children: [
                        // The pill-shaped input bar
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 18, right: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _controller,
                                      enabled: !isLoadingAI,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Talk to me",
                                      ),
                                      onSubmitted: sendUserMessage,
                                    ),
                                  ),
                                  // The mic button inside the text field (styled)
                                   Container(
                                     decoration: const BoxDecoration(
                                       color: Color(0xFFE7EDFC),
                                       shape: BoxShape.circle,
                                     ),
                                     child: IconButton(
                                       icon: const Icon(Icons.mic, color: Colors.blue, size: 28),
                                       onPressed: () {
                                      // Navigate to your "voice chat" screen
                                         Navigator.pushNamed(context, '/ai_voice_user');
                                       },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
