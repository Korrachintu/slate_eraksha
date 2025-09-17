import 'package:camera/camera.dart';
import 'package:e_raksha/features/emotion_recognition/emotion_result_screen.dart';
import 'package:flutter/material.dart';

class Emotion {
  final String name;
  final String emoji;
  Emotion({required this.name, required this.emoji});
}

class EmotionRecognitionScreen extends StatefulWidget {
  const EmotionRecognitionScreen({super.key});

  @override
  State<EmotionRecognitionScreen> createState() => _EmotionRecognitionScreenState();
}

class _EmotionRecognitionScreenState extends State<EmotionRecognitionScreen> {
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;

  int selectedIntensityIndex = 20; // center by default for 41 divisions
  int selectedMood = 1;

  final List<Emotion> moods = [
    Emotion(name: "Excited", emoji: "😃"),
    Emotion(name: "Exhausted", emoji: "😩"),
    Emotion(name: "Scared", emoji: "😨"),
    Emotion(name: "Happy", emoji: "😊"),
    Emotion(name: "Sad", emoji: "😢"),
    Emotion(name: "Angry", emoji: "😡"),
    Emotion(name: "Calm", emoji: "😌"),
    Emotion(name: "Surprised", emoji: "😱"),
    Emotion(name: "Tired", emoji: "🥱"),
  ];

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );
    _cameraController = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    _initializeControllerFuture = _cameraController!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  double get intensity => selectedIntensityIndex / 40.0; // 0..1 mapped from 0..40

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        // Top dark navy gradient fading into white near mid
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.45, 1.0],
          colors: [
            Color(0xFF101623),
            Color(0xFF1A2333),
            Color(0xFFFFFFFF),
          ],
        ),
      ), // Use a parent gradient container and make Scaffold transparent
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Curved white panel for lower half
            Positioned(
              top: size.height * 0.48,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  // AppBar row
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.more_vert, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                  // Camera region
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Rounded camera with cover fit
                          FutureBuilder(
                            future: _initializeControllerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done && _cameraController != null) {
                                final aspect = _cameraController!.value.previewSize == null
                                    ? 3 / 4
                                    : _cameraController!.value.previewSize!.height /
                                        _cameraController!.value.previewSize!.width;

                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white.withValues(alpha: 0.15),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      clipBehavior: Clip.hardEdge,
                                      child: SizedBox(
                                        width: size.width,
                                        height: size.width / aspect,
                                        child: CameraPreview(_cameraController!),
                                      ),
                                    ),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return const Center(child: Text("Camera error", style: TextStyle(color: Colors.white)));
                              } else {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[50],
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: const Center(child: CircularProgressIndicator()),
                                );
                              }
                            },
                          ),

                          // Face guide (corners)
                          Positioned(
                            top: 48,
                            left: 36,
                            right: 36,
                            bottom: 48,
                            child: CustomPaint(
                              painter: _CornerFramePainter(color: Colors.white.withValues(alpha: 0.9)),
                            ),
                          ),

                          // Instruction text
                          Positioned(
                            bottom: 40,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: const [
                                Text(
                                  "Let us recognize your emotions",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    shadows: [
                                      Shadow(color: Colors.black54, offset: Offset(0, 2), blurRadius: 6),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Align your face to the center",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    shadows: [
                                      Shadow(color: Colors.black54, offset: Offset(0, 2), blurRadius: 6),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                          // Floating next button
                          Positioned(
                            right: 28,
                            bottom: 46,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EmotionResultScreen(
                                      mood: moods[selectedMood].name,
                                      intensity: intensity,
                                      daysExhausted: (intensity * 7).round(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0A2A6B),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF0A2A6B).withValues(alpha: 0.22),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.double_arrow, color: Colors.white, size: 32),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Headline
                  Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 2),
                    child: Text(
                      "How would you describe your mood",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F1522),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Waveform intensity bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: IntensityBarSlider(
                      divisions: 41, // dense waveform
                      selectedIndex: selectedIntensityIndex,
                      onChanged: (idx) => setState(() => selectedIntensityIndex = idx),
                    ),
                  ),

                  // Mood chips
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(moods.length, (idx) {
                          final mood = moods[idx];
                          final isSelected = idx == selectedMood;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ChoiceChip(
                              label: Text(mood.name, style: const TextStyle(fontSize: 15)),
                              selected: isSelected,
                              avatar: Text(mood.emoji, style: const TextStyle(fontSize: 18)),
                              selectedColor: const Color(0xFF0F1830),
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color: isSelected ? Colors.transparent : const Color(0xFFCFD6E3),
                              ),
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                              onSelected: (_) => setState(() => selectedMood = idx),
                              shape: StadiumBorder(
                                side: BorderSide(
                                  color: isSelected ? Colors.transparent : const Color(0xFFCFD6E3),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Corner brackets around face guide
class _CornerFramePainter extends CustomPainter {
  final Color color;
  _CornerFramePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const seg = 26.0;
    final r = Rect.fromLTWH(0, 0, size.width, size.height);

    // Top-left
    canvas.drawLine(Offset(r.left, r.top), Offset(r.left + seg, r.top), paint);
    canvas.drawLine(Offset(r.left, r.top), Offset(r.left, r.top + seg), paint);

    // Top-right
    canvas.drawLine(Offset(r.right, r.top), Offset(r.right - seg, r.top), paint);
    canvas.drawLine(Offset(r.right, r.top), Offset(r.right, r.top + seg), paint);

    // Bottom-left
    canvas.drawLine(Offset(r.left, r.bottom), Offset(r.left + seg, r.bottom), paint);
    canvas.drawLine(Offset(r.left, r.bottom), Offset(r.left, r.bottom - seg), paint);

    // Bottom-right
    canvas.drawLine(Offset(r.right, r.bottom), Offset(r.right - seg, r.bottom), paint);
    canvas.drawLine(Offset(r.right, r.bottom), Offset(r.right, r.bottom - seg), paint);
  }

  @override
  bool shouldRepaint(covariant _CornerFramePainter oldDelegate) => oldDelegate.color != color;
}

// --- Enhanced waveform slider ---
class IntensityBarSlider extends StatefulWidget {
  final int divisions;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const IntensityBarSlider({
    super.key,
    this.divisions = 41,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  State<IntensityBarSlider> createState() => _IntensityBarSliderState();
}

class _IntensityBarSliderState extends State<IntensityBarSlider> {
  @override
  Widget build(BuildContext context) {
    final mid = (widget.divisions - 1) / 2;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (d) => _handleDrag(d.localPosition, context),
      onPanUpdate: (d) => _handleDrag(d.localPosition, context),
      child: SizedBox(
        height: 92,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                // Subtle baseline behind bars
                Positioned.fill(child: CustomPaint(painter: _BaselinePainter())),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.divisions, (idx) {
                    final dist = (idx - mid).abs();
                    final norm = 1.0 - dist / mid; // 0 at edges, 1 at center
                    final base = 28.0;
                    final spread = 52.0;
                    final barHeight = base + norm * spread;

                    final isSelected = idx == widget.selectedIndex;

                    final Gradient grad = LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isSelected
                          ? const [Color(0xFFFFA63B), Color(0xFFFD7E14)]
                          : const [Color(0xFFDEE3EA), Color(0xFFB8C0CC)],
                    );

                    return GestureDetector(
                      onTap: () => widget.onChanged(idx),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: 6.0,
                        height: barHeight,
                        decoration: BoxDecoration(
                          gradient: grad,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFFFFA63B).withValues(alpha: 0.25),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleDrag(Offset localPosition, BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    final barWidth = box.size.width / widget.divisions;
    final idx = (localPosition.dx / barWidth).clamp(0, widget.divisions - 1).round();
    widget.onChanged(idx);
  }
}

class _BaselinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE9EDF3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final y = size.height - 18;
    canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
