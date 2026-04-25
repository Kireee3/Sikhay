# Sikhay 💡
> *Ang tulay mula sa salita patungo sa unawa.*

## Overview

Sikhay is an AI-powered educational platform built with Flutter that bridges the gap between complex textbook definitions and native understanding for Junior High School students (Grades 7-10). 

By combining an interactive Concept Constellation graph with an adaptive AI tutor, Sikhay dynamically translates and simplifies difficult topics across Science, Math, and English into English, Tagalog, and Bisaya in real-time. Whether a student needs the strict academic "ground truth" or an easily digestible "ELI5" (Explain Like I'm 5) analogy, Sikhay adapts to their comprehension level. Complete with robust offline support and text-to-speech capabilities, Sikhay provides a truly inclusive, gamified learning experience.

**Sikhay** is derived from the Filipino word representing enthusiastic hard work, diligence, perseverance, and zeal—capturing the passionate approach students take to achieve their goals.

## Key Features

* **Interactive Concept Constellation:** Visually navigate topics, unlock new nodes, and track mastery progress from 0% to completion.
* **Dynamic Multilingual Support:** Real-time translation of UI and core curriculum into English, Tagalog (TL), and Bisaya (CEB).
* **Adaptive AI Tutor:** Toggle between standard academic definitions and simplified "ELI5" analogies to match the student's learning level.
* **Offline Mode:** Persistent local caching allows students to persevere and learn anywhere, anytime.
* **Accessibility First:** Integrated native text-to-speech functionality for auditory learning and deeper inclusivity.
## Getting Started (Setup & Installation)


To get a local copy of Sikhay up and running, follow these steps:

### Prerequisites
* **Flutter SDK:** Ensure you have the latest stable version of [Flutter](https://docs.flutter.dev/get-started/install) installed.
* **IDE:** [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio) with the Flutter and Dart plugins configured.
* **Firebase Account:** You will need an active Firebase project for authentication and backend services.

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your_username/sikhay.git
   cd sikhay
   ```

2. **Install Flutter dependencies:**
   ```bash
   flutter pub get
   ```

3. **Firebase Configuration:**
   * Create a new project in the [Firebase Console](https://console.firebase.google.com/).
   * Enable **Cloud Firestore** and **Firebase Authentication** (ensure Google Sign-In is enabled).
   * Use the [FlutterFire CLI](https://firebase.flutter.dev/docs/cli/) to link your project and generate the necessary configuration files. Run the following command in your terminal:
     ```bash
     flutterfire configure
     ```
   * *Note: Ensure your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are correctly placed in their respective platform directories if you are setting up manually.*

4. **Run the App:**
   ```bash
   flutter run
   ```

---

## Tech Stack & Credits

This project is built using a modern, scalable technology stack. A huge thank you to the creators, communities, and maintainers of the following frameworks, packages, and tools:

### AI Development Assistants
* **Gemini:** Utilized for AI-assisted coding, brainstorming architecture, and rapid problem-solving during development.
* **Manus AI:** Leveraged to aid in the ideation, structuring, and overall development workflow of the application.

### Frameworks & Architecture
* **[Flutter](https://flutter.dev/):** The core UI framework used for high-performance, cross-platform rendering across Mobile and Web.
* **[Dart](https://dart.dev/):** The foundational programming language powering the application.
* **[Riverpod](https://riverpod.dev/) (`flutter_riverpod`):** Utilized for robust, compile-safe, and scalable state management.

### Backend & Authentication
* **[Firebase](https://firebase.google.com/):**
  * **Cloud Firestore:** Powers real-time database syncing, user profiles, and persistent local caching for offline support.
  * **Firebase Auth:** Handles secure user authentication flows.
  * **Cloud Functions:** Facilitates secure backend logic and AI API integrations.
* **[Google Sign-In](https://pub.dev/packages/google_sign_in):** Provides seamless, cross-platform OAuth integration.

### Artificial Intelligence & Accessibility
* **Manus API Integration:** Powers the real-time text simplification, translation, and adaptive tutoring functions.
* **[Flutter TTS](https://pub.dev/packages/flutter_tts):** Delivers cross-platform, native text-to-speech capabilities to read lessons aloud.
* **[Connectivity Plus](https://pub.dev/packages/connectivity_plus):** Detects network state to seamlessly toggle between live AI generation and cached offline content.

### UI, Animations & Theming
* **[Flutter Animate](https://pub.dev/packages/flutter_animate):** Powers the smooth transitions and interactive feedback within the app.
* **[Google Fonts](https://pub.dev/packages/google_fonts):** Serves the dynamic typography (`Inter` for body readability, `Adriane Text` for headings).
* **[Cached Network Image](https://pub.dev/packages/cached_network_image):** Optimizes asset loading and visual rendering.
* **[FL Chart](https://pub.dev/packages/fl_chart):** Assists in visualizing mastery data and student progress.
