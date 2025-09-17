import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../core/widgets/gradient_background.dart';
import '../../../core/widgets/custom_button.dart';

class PhoneVerificationScreen extends StatelessWidget {
  const PhoneVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header Section
                const SizedBox(height: 80),
                Text(
                  "Welcome to E-Raksha",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Verify your phone number",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                /// Phone Input Field
                const SizedBox(height: 32),
                IntlPhoneField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  initialCountryCode: 'IN',
                  keyboardType: TextInputType.phone,
                  onChanged: (phone) {
                    debugPrint("Phone entered: ${phone.completeNumber}");
                  },
                ),

                /// Pushes button + link to bottom
                const Spacer(),

                CustomButton(
                  text: "Verify Phone Number",
                  onPressed: () {
                    Navigator.pushNamed(context, '/otp');
                  },
                ),

                const SizedBox(height: 24),

                Center(
                  child: TextButton(
                    onPressed: () {
                      // Logic for 'Use email, instead'
                    },
                    child: Text(
                      "Use email, instead",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height:40), // bottom spacing
              ],
            ),
          ),
        ),
      ),
    );
  }
}
