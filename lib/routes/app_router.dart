import 'package:e_raksha/features/chat/screens/ai_chat_screen.dart';
import 'package:e_raksha/features/emotion_recognition/emotion_recognition_screen.dart';
// import 'package:e_raksha/features/chat/screens/voice_chat_screen.dart';
import 'package:e_raksha/features/onboarding/screens/about_yourself_screen.dart';
import 'package:e_raksha/features/onboarding/screens/loading_screen.dart';
import 'package:e_raksha/features/onboarding/screens/parental_code_screen.dart';
import 'package:e_raksha/features/onboarding/screens/permissions_screen.dart';
import 'package:flutter/material.dart';
import '../features/onboarding/screens/phone_verification_screen.dart';
import '../features/onboarding/screens/otp_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/User/user_profile.dart';
import '../models/user.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => PhoneVerificationScreen());
      case '/otp':
        return MaterialPageRoute(builder: (_) => OTPScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/about_yourself':
        return MaterialPageRoute(builder: (_) => const AboutYourselfScreen());
      case '/parental_code':
        return MaterialPageRoute(builder: (_) => const ParentalCodeScreen());
      case '/permission':
        return MaterialPageRoute(builder: (_) => const PermissionsScreen());
      case '/loading':
        return MaterialPageRoute(builder: (_) => const LoadingScreen());
      case '/ai_chat':
        return MaterialPageRoute(builder: (_) => const AIChatScreen());
      case '/emotion_recognition':
        return MaterialPageRoute(
          builder: (_) => const EmotionRecognitionScreen(),
        );
      case '/user_profile':
        return MaterialPageRoute(
          builder: (_) => UserProfilePage(user: User.dummyUser),
        );
      // case '/voiceChat':
      //   return MaterialPageRoute(builder: (_) => const VoiceChatScreen());
      // ... other routes ...
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
