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
├─ main.dart
├─ core/
│   └─ widgets/         # Reusable UI (backgrounds, navigation)
├─ features/
│   ├─ onboarding/
│   ├─ home/
│   ├─ ai_chat/
│   └─ emotion_recognition/
│       ├─ emotion_recognition_screen.dart
│       ├─ mood_carousel.dart
│       └─ intensity_bar_slider.dart
├─ providers/           # App/session state
├─ services/            # API calls/backends
└─ models/              # Data models (e.g. emotion.dart, chat_message.dart)
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

- REST API calls with `http` or `dio`
- Secure tokens via `flutter_secure_storage`
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
Open an issue or contact [YOUR_EMAIL_HERE]

---

## 💬 Screenshots

Include screenshots/gifs of your app (emotion recognition, AI chat, onboarding...) here to help users understand features!

---

```
**This README.md file covers setup, architecture, key features, and contributor info in one place—just save and edit the usernames/emails as needed!**

[1](https://github.com/webfactorymk/flutter-template/blob/main/README.md)
[2](https://gitlab.com/rafaelanno-labo/template/template-flutter-app/-/blob/main/README.md)
[3](https://www.walturn.com/insights/how-to-create-an-effective-flutter-readme)
[4](https://github.com/zubairehman/flutter-boilerplate-project/blob/master/README.md)
[5](https://pub.dev/packages/readme_helper)
[6](https://dart.dev/tools/pub/writing-package-pages)
[7](https://stackoverflow.com/questions/9331281/how-can-i-test-what-my-readme-md-file-will-look-like-before-committing-to-github)
