# NIE Audio Learning Platform

Flutter mobile app for the National Institute of Education (NIE), Sri Lanka — audio playlists, recordings, chat, and video calls for teachers and students.

## Overview

Cross-platform Flutter application with Firebase backend, real-time chat, audio playback, calendar-based playlists, and ZegoCloud video calling. Built for educational content delivery and teacher–student communication.

## Features

- User authentication and role-based access (student/teacher)
- Audio player with playlist and recording playback
- Calendar-integrated playlist scheduling
- Real-time chat (Firestore)
- Video/voice calls (ZegoUIKit)
- Push notifications (Firebase Messaging + Awesome Notifications)
- Secure token storage

## Tech Stack

- **Flutter 3** / Dart
- **Firebase** (Core, Firestore, Messaging)
- **ZegoUIKit Prebuilt Call**
- **GetX** state management
- **just_audio** / audioplayers
- **table_calendar**

## Getting Started

```bash
flutter pub get
flutter run
```

Configure Firebase by adding your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS), or update `lib/firebase_options.dart`.

## Project Structure

```
lib/
├── auth/              # Authentication
├── pages/
│   ├── chat/          # Messaging
│   ├── playList/      # Audio playlists
│   ├── playRecoding/  # Recordings
│   └── player/        # Audio player UI
├── services/          # API & Firebase services
└── widgets/           # Reusable components
```

## Author

Kezara Lakshan — [GitHub](https://github.com/Kezara666)
