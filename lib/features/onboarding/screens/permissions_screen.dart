import 'package:flutter/material.dart';
import '../../../core/widgets/gradient_background.dart';
import '../../../core/widgets/custom_button.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
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
                    "E-Raksha aids your growth and harmony",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "To get started, please allow us to access the following:",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: const [
                      Icon(Icons.access_time),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text("Access to device, school status, etc."),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Icon(Icons.notifications),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text("Access to notifications and alerts"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    text: "Allow Permissions",
                    onPressed: () {
                      Navigator.pushNamed(context, '/loading');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
