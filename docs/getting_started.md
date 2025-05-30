# 🚀 Getting Started

This guide will help you set up and run the Flutter Clean Starter project on your local machine. The starter is modular, cleanly structured, and supports both web and mobile platforms. You can use:  

- 🔧 A built-in mock API (Dart)  
- 🧩 Optional Go or Node.js APIs (linked below)

---

## ✅ Prerequisites

Before getting started, make sure you have the following installed:

  - Flutter SDK (Install Flutter)
  - Dart SDK (comes with Flutter)
  - A device/emulator or Chrome browser for web
  - Git (for cloning the repo)
  - (Optional) Go and/or Node.js for backend APIs

---

## 📦 Installation  


1. Clone the repository:
```bash
git clone https://github.com/your-username/flutter_clean_starter.git
```
```bash
cd flutter_clean_starter
```

2. Install Flutter dependencies:
```bash
flutter pub get
```

---

## 🖥️ Running the App  
#### Flutter Web (Recommended for Quick Start)  

```bash
flutter run -d chrome
```

#### Flutter Mobile

Ensure a device/emulator is running, then:

```bash
flutter run
```

---

### 🧪 Option 1: Use the Built-in Mock API (Dart)

This project includes a lightweight mock API to simulate backend behavior for local development.

1. Navigate to the mock API directory:
```bash
cd mock
```

2.	Install Dart dependencies:
```bash
dart pub get
```

3.	Run the mock server:
```bash
dart server/main.dart
```

The server will start on: <http://localhost:8080>

The Flutter app will automatically use this mock API when no real API is configured.

---

### 🔁 Option 2: Use Go or Node.js APIs (Optional)

Instead of the mock server, you can run real API servers:

- 👉 [Go API Starter](https://github.com/BrockMekonnen/go-clean-starter)  
- 👉 [Node API Starter (in progress)](https://github.com/BrockMekonnen/node-ts-clean-starter)

Each backend is structured to match the same API contract used in the Flutter app.

---

### 🌱 Optional Feature Branch: Post Module

The branch clean-start-with-post-module includes a full working example of a posts module (UI, domain, data, routes).

To use it:  
```bash
git checkout clean-start-with-post-module
```
```bash
flutter pub get
```
Run the mock API:  
```bash
dart mock/server/main.dart
```
Then launch the app:  
```bash
flutter run -d chrome
```
---


## 🛠️ What’s Next?

- Explore modules in /modules/auth and /modules/posts (in branch)  
- Read the Architecture documentation  
- Replace the mock API with your Go/Node backend  
- Contribute or extend with your own feature module!  

