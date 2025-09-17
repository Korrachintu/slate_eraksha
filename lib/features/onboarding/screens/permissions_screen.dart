import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/widgets/gradient_background.dart';
import '../../../core/widgets/custom_button.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});
  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  Future<void> requestPermissions() async {
    await [
      Permission.microphone,
      Permission.camera,
      Permission.locationWhenInUse,
    ].request();

    if (!mounted) return;

    // Navigate to next screen regardless of status
    Navigator.pushNamed(context, '/loading');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                /// Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const SizedBox(height: 32),

                        Text(
                          "Permissions Required",
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "To provide the best experience, E-Raksha needs access to:",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 24),

                        Row(
                          children: const [
                            Icon(Icons.mic, color: Colors.blue),
                            SizedBox(width: 10),
                            Text("Microphone (for voice features)"),
                          ],
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: const [
                            Icon(Icons.camera_alt, color: Colors.orange),
                            SizedBox(width: 10),
                            Text("Camera (for mood analysis/images)"),
                          ],
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: const [
                            Icon(Icons.location_on, color: Colors.green),
                            SizedBox(width: 10),
                            Text("Location (for personalized experience)"),
                          ],
                        ),

                        const SizedBox(height: 100), // scroll padding
                      ],
                    ),
                  ),
                ),

                /// Fixed bottom button
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: CustomButton(
                    text: "Allow Permissions",
                    onPressed: requestPermissions,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
