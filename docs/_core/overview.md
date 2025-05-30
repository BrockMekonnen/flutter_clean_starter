# 🧠 Core Overview

The /lib/_core directory provides foundational building blocks and global configurations used across the entire Flutter application. It ensures a clear separation of concerns, reusability, and centralized management for features like routing, dependency injection, theming, localization, and networking.

The goal is to keep core logic independent of individual modules, while offering global services and bootstrapping mechanisms used app-wide.

---

## 🧱 Folder Structure
```
_core/
├── error/            # Custom error handling (e.g., network/cache errors)
├── layout/           # Layout builders for adaptive design (mobile/tablet/desktop)
├── app_router.dart   # Global route config, guards, transitions
├── bootstrap.dart    # App bootstrap: initializes services and modules
├── constants.dart    # Global constants
├── database.dart     # Database setup (Hive or others)
├── di.dart           # Dependency injection configuration (GetIt)
├── http_client.dart  # Central HTTP client setup (e.g., Dio)
├── network_info.dart # Check for internet connectivity
├── theme.dart        # Light/dark theme configuration

```

---
## 📌 Responsibilities

| File / Folder       | Purpose                                                                                   |
|---------------------|-------------------------------------------------------------------------------------------|
| `bootstrap.dart`    | Entry point before `runApp`. Initializes DI, database, modules, and any pre-run setup.    |
| `__init_modules.dart`| Central place to register all feature modules (auth, posts, etc.).                        |
| `app_router.dart`   | Sets up GoRouter, route guards, and page transitions globally.                            |
| `di.dart`           | Registers global dependencies (like Dio, shared prefs, network utils, etc.).              |
| `database.dart`     | Configures and initializes local databases (Hive, etc.).                          |
| `constants.dart`    | Defines app-wide static values and keys (e.g., token keys, base URLs).                    |
| `http_client.dart`  | A wrapper around Dio or other HTTP clients for consistent API handling.                   |
| `network_info.dart` | Utility to check internet connection status.                                             |
| `theme.dart`        | Sets up app-wide themes including color schemes and text styles.                         |
| `layout/`           | Offers responsive layout builders to handle multiple screen types (mobile/tablet/desktop).|
| `error/`            | Contains error handling for network failures, caching issues, or general exceptions.     |

---

##💡 Why It Matters

- Encourages centralized configuration and reduces redundancy.
- Makes it easier to scale by isolating startup logic and global services.
- Promotes testability and maintainability by keeping core services reusable across modules.
- Acts as the glue between the app’s lifecycle and the feature modules.

---
