import 'package:flutter/material.dart';
import '../../../core/widgets/gradient_background.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen>
    with SingleTickerProviderStateMixin {
  bool isFetchingAudio = false;
  bool isLoadingAI = false;
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];

  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void sendUserMessage(String text) async {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(text: text.trim(), isUser: true));
      isLoadingAI = true;
      _controller.clear();
    });

    //  Connect to your backend here for AI response
    await Future.delayed(const Duration(seconds: 1));
    final aiReplyText = "AI response to: $text";

    setState(() {
      _messages.add(ChatMessage(text: aiReplyText, isUser: false));
      isLoadingAI = false;
    });
  }

  void onMicPressed() async {
    setState(() => isFetchingAudio = true);

    // Connect to backend for speech-to-text streaming here
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;
    setState(() => isFetchingAudio = false);

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.end, // push content toward bottom
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 95,
                      ), // pushes content a bit up from absolute bottom
                      Text(
                        "Hey, Jane",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Tell me what’s on your mind today",
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "You can tell me something specific, pick from the categories below or even start a voice chat with me",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(height: 1.4),
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          _buildCategoryChip("School Stress"),
                          _buildCategoryChip("Bullying"),
                          _buildCategoryChip("Relationships"),
                        ],
                      ),
                      const SizedBox(
                        height:10,
                      ), // optional extra spacing above bottom bar
                    ],
                  ),
                ),
              ),

              // Chat messages
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _messages.length,
                  itemBuilder: (context, idx) {
                    final msg = _messages[idx];
                    return Align(
                      alignment: msg.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: msg.isUser
                              ? Colors.blueAccent.withValues(alpha: 0.1)
                              : Colors.white.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          msg.text,
                          style: TextStyle(
                            color: msg.isUser
                                ? Colors.blue[900]
                                : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              if (isLoadingAI)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: CircularProgressIndicator(),
                ),

              // Mic pulse animation UI
              if (isFetchingAudio)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Column(
                      children: [
                        AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: 1 + (_pulseController.value * 0.2),
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.mic,
                                  size: 40,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Listening...",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Chat input bar
              if (!isFetchingAudio)
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 8),
                        ],
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.mic,
                              color: Colors.blueAccent,
                            ),
                            onPressed: onMicPressed,
                          ),
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
                          IconButton(
                            icon: const Icon(
                              Icons.send,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () => sendUserMessage(_controller.text),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
