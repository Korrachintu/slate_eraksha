import 'package:flutter/material.dart';
import '../../../core/widgets/gradient_background.dart';
import '../../../core/widgets/custom_button.dart';

class AboutYourselfScreen extends StatefulWidget {
  const AboutYourselfScreen({super.key});

  @override
  State<AboutYourselfScreen> createState() => _AboutYourselfScreenState();
}

class _AboutYourselfScreenState extends State<AboutYourselfScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2010, 1, 1),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.deepPurple, // header background color
            onPrimary: Colors.white, // header text color
            onSurface: Colors.black, // body text color
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true, // 👈 ensures button shifts above keyboard
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                /// Scrollable form
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

                        /// Header
                        Text(
                          "About yourself",
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Let us personalize your experience",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),

                        /// Inputs
                        const SizedBox(height: 32),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: "Enter Your Name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _dobController,
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: const InputDecoration(
                            labelText: "Date of Birth (DD-MM-YYYY)",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                        ),

                        const SizedBox(height: 100), // extra space for scroll
                      ],
                    ),
                  ),
                ),

                /// Fixed bottom button
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: CustomButton(
                    text: "Continue",
                    onPressed: () {
                      Navigator.pushNamed(context, '/parental_code');
                    },
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
