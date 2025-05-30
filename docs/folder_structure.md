# 📁 Folder Structure

This Flutter project is organized with Clean Architecture and Modular Design in mind. Below is an overview of the main directories and what each one is responsible for.

---

## 🔝 Root Structure

```
lib/
├── _core/           # App-wide core logic (DI, theming, routing, localization)
├── _shared/         # Shared logic (widgets, utilities, services, etc.)
├── modules/         # Feature-based modules (auth, posts, etc.)
├── app.dart         # App widget setup (MaterialApp.router, theming, localization, etc.)
├── main.dart        # App entry point
```

---

## 📦 lib/_core/

Core configuration and services used across the entire app.
```
_core/
├── error/              # Handles cache, network, and connection-related errors
├── layout/             # App layout logic for mobile, tablet, and desktop
├── _bootstrap.dart     # Initializes libraries and modules at app startup
├── __init_module.dart  # Registers and configures all feature modules
├── app_router.dart     # Global route config, guards, and transitions (GoRouter)
├── constants.dart      # App-wide constants and static config values
├── database.dart       # Database setup and initialization (e.g., Hive, Drift)
├── di.dart             # Dependency injection setup and registration (e.g., GetIt)
├── http_client.dart    # HTTP client setup (e.g., Dio instance with interceptors)
├── network_info.dart   # Utility to check internet connectivity status
└── theme.dart          # Light and dark theme configurations
```

---

## ♻️ lib/_shared/

Reusable components and logic shared between modules.
```
_shared/
├── blocs/              # Global BLoC or Cubit classes not tied to any specific module
├── data/               # Shared data services or models
├── domain/             # Shared use cases, entities, and contracts
├── features/           # Shared logic or partial features (non-module-specific)
├── utils/              # Helpers, extensions, formatters
├── widgets/            # Reusable UI components and custom widgets
├── shared_module.dart  # Initialization logic for shared services or state
└── shared_routes.dart  # Shared routes accessible across modules
```

---

## 🔗 lib/modules/

Each module is feature-specific and self-contained.

Example: auth and posts modules
```
modules/
├── auth/
│   ├── bloc/             # BLoC related to authentication (persists throughout the app lifecycle)
│   ├── data/             # DTOs, models, repository implementations
│   ├── domain/           # Entities, use cases, repository contracts
│   ├── features/         # UI components, screens, and local BLoC logic
│   ├── __tests__/        # Unit and integration tests specific to the auth module
│   ├── auth_module.dart  # DI setup and initialization for auth
│   └── auth_routes.dart  # Route definitions specific to auth
│
├── posts/
│   ├── data/
│   ├── domain/
│   ├── features/
│   ├── __tests__/        # Tests scoped to the posts module
│   ├── posts_module.dart
│   └── posts_routes.dart
```
Each module contains everything it needs to function independently.

---

## 🧪 mock (Optional)

A simple local Dart server to mock backend APIs without needing Go or Node servers.

```
mock/
└── server/
    ├── routes/
    │   ├── auth.dart       # Mock auth endpoints
    │   └── posts.dart      # Mock posts endpoints
    └── main.dart           # Entry file to run the mock server

```

---

## 📝 Summary

This structure helps achieve:  
✅ Clear separation of concerns  
✅ Modular and scalable codebase  
✅ Ease of testing and collaboration  
✅ Simplicity in adding/removing features  

Each module can be dropped in or out without tightly coupling it to the rest of the app.

