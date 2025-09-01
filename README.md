# E-Raksha: Mental Wellness Flutter App

A modern Flutter application supporting onboarding, emotion recognition (camera + bar chart slider), AI chat, secure session management, and modular code for easy future expansion.

---

## 🚀 Getting Started

### **Prerequisites**
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (recommend version >=3.7)
- Android Studio or Visual Studio Code (+ Flutter/Dart plugins)
- A mobile device or emulator (camera required for emotion recognition)

---

### **Installation**

**1. Clone the repo:**
```
git clone https://github.com/YOUR_USERNAME/e_raksha.git
cd e_raksha
```

**2. Install dependencies:**
```
flutter pub get
```

---

### **Camera Permissions**

**For Android:** edit `android/app/src/main/AndroidManifest.xml`:
```
<uses-permission android:name="android.permission.CAMERA"/>
```

**For iOS:** edit `ios/Runner/Info.plist`:
```
<key>NSCameraUsageDescription</key>
<string>This app uses the camera for mood recognition.</string>
```

---

### **Run the app**

```
flutter run
```
Or use your IDE's "Run" command.

---

## 📁 Project Structure

```
lib/
├── core/
├── features/
│   ├── chat/
│   │   └── screens/
│   │       ├── voice_chat_screen.dart
│   │       └── ai_chat_screen.dart
│   ├── emotion_recognition/
│   │   ├── widgets/
│   │   │   └── mood_carousel.dart
│   │   ├── emotion_recognition_screen.dart
│   │   └── emotion_result_screen.dart
│   ├── home/
│   │   └── screens/
│   │       └── home_screen.dart
│   └── onboarding/
│       └── screens/
│           ├── about_yourself_screen.dart
│           ├── loading_screen.dart
│           ├── otp_screen.dart
│           ├── parental_code_screen.dart
│           ├── permissions_screen.dart
│           └── phone_verification_screen.dart
├── models/
│   └── emotion.dart
├── routes/
│   └── app_router.dart
└── main.dart

```

---

## 🎨 Key Features

- **Onboarding:** Simple first run, login, and persisted session.
- **Home dashboard:** Quick actions, bottom navigation.
- **AI Chat:** Modern chat bubbles, pill-shaped input, easy backend connect.
- **Emotion Recognition:**  
  - Live front camera preview  
  - "Mountain" shape intensity bar slider (tap/drag to select)  
  - Scrollable mood chips/emojis  
  - Floating action bar (">>") to show result/action
- **State Management:** [Provider](https://pub.dev/packages/provider) (or Riverpod).
- **Secure Session:** Persistent login, automatic routing.

---

## ⚙️ Backend/API Integration

- fastapi 
- Plug your emotion recognition/AI API into the respective features
- Modular architecture is ready for extensions

---

## 🛠 Common Flutter Commands

- **Format:**      `flutter format .`
- **Analyze:**     `flutter analyze`
- **Doctor:**      `flutter doctor`
- **Hot reload:**  Use IDE or CLI `r` key

---

## 📱 Testing Camera & Permissions

- Test on a **real device** for camera features.
- Accept permission prompts on first use.
- If the camera fails: verify project permissions and emulator/device support.

---

## 💡 Contributing

Contributions are welcome!  
- Fork the repo, create a branch, submit a pull request.

---

## 📖 License

MIT

---

## 🙋 Contacts

Questions, ideas, bug reports:  
Open an issue or contact pramodhkorra@gamil.com

---

## 💬 Screenshots

Include screenshots/gifs of your app (emotion recognition, AI chat, onboarding...) here to help users understand features!

---

```

