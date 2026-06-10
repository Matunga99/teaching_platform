# Teaching Platform

A Flutter-based teaching platform with local storage support for offline learning.

## Features

- 📚 Course Management
- 👥 Student Enrollment
- 📝 Assignments & Quizzes
- 💾 Local Storage for Offline Access
- 📊 Progress Tracking
- 🔔 Notifications

## Tech Stack

- **Framework**: Flutter
- **Storage**: Local Storage (Shared Preferences, Hive)
- **State Management**: Provider / Riverpod
- **Database**: SQLite (for local data)

## Getting Started

### Prerequisites

- Flutter SDK (version 3.0 or higher)
- Dart SDK
- Android Studio / Xcode
- Git

### Installation

```bash
git clone git@github.com:Matunga99/teaching_platform.git
cd teaching_platform
flutter pub get
```

### Running the App

```bash
flutter run
```

### Building

**Android:**
```bash
flutter build apk
```

**iOS:**
```bash
flutter build ios
```

## Project Structure

```
teaching_platform/
├── lib/
│   ├── main.dart
│   ├── models/
│   ├── screens/
│   ├── services/
│   ├── widgets/
│   └── utils/
├── assets/
├── test/
├── pubspec.yaml
└── README.md
```

## Contributing

1. Create a feature branch
2. Commit your changes
3. Push to the branch
4. Create a Pull Request

## License

MIT License - see LICENSE file for details

## Author

Matunga99
