import 'dart:ui';
import 'package:e_raksha/core/widgets/custom_botton_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final startDate = today.subtract(const Duration(days: 2));
    final weekDates = List.generate(7, (i) => startDate.add(Duration(days: i)));
    const weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFD496), // warm orange
              Color(0xFFE7EEFF), // soft blue
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Main scroll
              ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                children: [
                  // Header row (no back arrow)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        const Text(
                          "Hello, Jane Doe",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.stacked_line_chart, color: Colors.white, size: 16),
                        ),
                      ],
                    ),
                  ),

                  // FIRST HALF: Quick Mood Analysis + Calendar
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/emotion_recognition'),
                    child: _GlassCard(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "uses face scanner",
                              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Quick mood analysis",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Feeling tired? happy? disturbed?",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Overflow-safe rounded date chips row
                  MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: const TextScaler.linear(1.0), // cap text scale here
                    ),
                    child: SizedBox(
                      height: 66, // tighter to avoid bottom overflow
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, idx) {
                          final date = weekDates[idx];
                          final isSelected = date.year == today.year &&
                              date.month == today.month &&
                              date.day == today.day;

                          return Container(
                            width: 64,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.75),
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min, // prevents stretching
                                children: [
                                  if (isSelected)
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF2E6BFF),
                                        shape: BoxShape.circle,
                                      ),
                                    )
                                  else
                                    const SizedBox(height: 4),

                                  const SizedBox(height: 4),

                                  const SizedBox(height: 0),
                                  Text(
                                    weekDays[date.weekday % 7],
                                    style: const TextStyle(
                                      fontSize: 11.5, // slightly smaller
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600,
                                      height: 1.0, // tighter line height
                                    ),
                                  ),

                                  const SizedBox(height: 3),

                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), // tighter
                                    decoration: BoxDecoration(
                                      color: isSelected ? const Color(0xFF2E6BFF) : Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: isSelected ? const Color(0xFF2E6BFF) : Colors.black12,
                                      ),
                                    ),
                                    child: Text(
                                      date.day.toString().padLeft(2, '0'),
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w700,
                                        color: isSelected ? Colors.white : Colors.black87,
                                        height: 1.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // SECOND HALF: Two activity cards side-by-side
                  const Row(
                    children: [
                      Expanded(
                        child: _ActivityCard(
                          tagColor: Color(0xFF2E6BFF),
                          tagText: "Timed distraction",
                          title: "Unwind",
                          subtitle: "Feeling tired?\nhappy? disturbed?",
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _ActivityCard(
                          tagColor: Color(0xFFFFA336),
                          tagText: "Short activities",
                          title: "Relax",
                          subtitle: "Feeling tired?\nhappy? disturbed?",
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Bottom bar
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
                  child: CustomBottomBar(
                    backgroundColor: Colors.black.withValues(alpha: 0.92),
                    borderRadius: 28,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.home_outlined, color: Colors.white),
                          onPressed: () {},
                          tooltip: "Home",
                        ),
                        IconButton(
                          icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
                          onPressed: () => Navigator.pushNamed(context, '/ai_chat'),
                          tooltip: "AI Chat",
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                          onPressed: () {},
                          tooltip: "Add",
                        ),
                        IconButton(
                          icon: const Icon(Icons.person_outline, color: Colors.white),
                          onPressed: () => Navigator.pushNamed(context, '/profile'),
                          tooltip: "Profile",
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
}

// Glass card helper (no external packages)
class _GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  const _GlassCard({required this.child, this.padding = const EdgeInsets.all(16)});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.7)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

// Activity card with tag pill and glass effect
class _ActivityCard extends StatelessWidget {
  final Color tagColor;
  final String tagText;
  final String title;
  final String subtitle;

  const _ActivityCard({
    required this.tagColor,
    required this.tagText,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Tag(color: tagColor, text: tagText),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black87),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.3),
          ),
        ],
      ),
    );
  }
}

// Little tag chip
class _Tag extends StatelessWidget {
  final Color color;
  final String text;
  const _Tag({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _darken(color)),
          ),
        ],
      ),
    );
  }

  Color _darken(Color c, [double amount = .2]) {
    final hsl = HSLColor.fromColor(c);
    final l = (hsl.lightness - amount).clamp(0.0, 1.0);
    return HSLColor.fromAHSL(hsl.alpha, hsl.hue, hsl.saturation, l).toColor();
    }
}
