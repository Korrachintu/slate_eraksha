import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// Dummy Emotion model (replace with your own if needed)
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
  int selectedIntensityIndex = 10; // default to center for 21 bars
  int selectedMood = 0;
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
    _cameraController = CameraController(frontCamera, ResolutionPreset.medium, enableAudio: false);
    _initializeControllerFuture = _cameraController!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  double get intensity => selectedIntensityIndex / 20.0; // Normalized [0,1]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // TOP HALF: Live camera feed
            Expanded(
              flex: 5,
              child: FutureBuilder(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done && _cameraController != null) {
                    return CameraPreview(_cameraController!);
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Camera error"));
                  } else {
                    return Container(
                      color: Colors.blueGrey[50],
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
            // MID: Mood caption
            const SizedBox(height: 10),
            Text(
              "How would you describe your mood",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            // INTENSITY BAR SLIDER (mountain bars)
            IntensityBarSlider(
              divisions: 21,
              selectedIndex: selectedIntensityIndex,
              onChanged: (idx) => setState(() => selectedIntensityIndex = idx),
            ),
            // MOOD CHIPS CAROUSEL
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              child: Row(
                children: List.generate(moods.length, (idx) {
                  final mood = moods[idx];
                  final isSelected = idx == selectedMood;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(mood.name, style: TextStyle(fontSize: 15)),
                      selected: isSelected,
                      avatar: Text(mood.emoji, style: TextStyle(fontSize: 18)),
                      selectedColor: Colors.blue.shade100,
                      onSelected: (_) => setState(() => selectedMood = idx),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 18),
            // FLOATING ">>" BUTTON
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 22),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(18),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    // Show results (replace with your own screen)
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Result"),
                        content: Text(
                          "Mood: ${moods[selectedMood].name}\nIntensity: ${(intensity * 100).round()}%",
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(child: const Text("OK"), onPressed: () => Navigator.pop(context)),
                        ],
                      ),
                    );
                  },
                  child: const Icon(Icons.double_arrow, color: Colors.white, size: 32),
                ),
              ),
            ),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
}

// --- Slider as vertical animated bars ---
class IntensityBarSlider extends StatefulWidget {
  final int divisions;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const IntensityBarSlider({
    super.key,
    this.divisions = 21,
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
      onPanDown: (details) => _handleDrag(details.localPosition, context),
      onPanUpdate: (details) => _handleDrag(details.localPosition, context),
      child: SizedBox(
        height: 70,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.divisions, (idx) {
                final dist = (idx - mid).abs();
                final norm = 1.0 - dist / mid; // mountain
                final barHeight = 25 + norm * 35;
                final isSelected = idx == widget.selectedIndex;
                final color = isSelected ? Colors.orange : Colors.grey[400];

                return GestureDetector(
                  onTap: () => widget.onChanged(idx),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 8,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),
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
