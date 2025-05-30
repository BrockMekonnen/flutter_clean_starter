# 🧩 Dependency Injection (DI)

The Flutter Clean Starter uses [`get_it`](https://pub.dev/packages/get_it) for dependency injection. This makes it easy to manage and access services, blocs, utilities, and other shared resources throughout the app in a clean and testable way.

---

## 📁 File: `lib/_core/di.dart`

```dart
import 'package:get_it/get_it.dart';

final GetIt di = GetIt.instance;
```
This file exposes a globally available singleton instance of GetIt, referenced as di throughout the app.

---

##🔧 Registering Dependencies

Dependencies are typically registered in the bootstrap.dart or init_modules.dart files, during app initialization.

Example: Registering a singleton

``
di.registerLazySingleton<SomeService>(() => SomeServiceImpl());
``

- registerLazySingleton: The object is created only when first used.
- registerSingleton: The object is created immediately and shared.
- registerFactory: A new instance is created on every retrieval.

Named Registration

You can optionally register dependencies with a name using instanceName:
```dart
di.registerSingleton<SomeTabController>(
  SomeTabController(),
  instanceName: Constants.navTabsDiKey,
);
```
This is helpful for registering multiple instances of the same type for different purposes.

---

## 🧑‍💻 Accessing Dependencies

Anywhere in your app (routes, widgets, blocs, services, etc.), you can retrieve a registered dependency like this:

Example: Basic Access
```dart
final authRepo = di<AuthRepository>();
```
Example: With instanceName
```dart
final navRoutes = di.get<List<AdaptiveDestination>>(
  instanceName: Constants.navTabsDiKey,
);
```
This is used in app_router.dart to retrieve navigation tabs dynamically.

---

## 🔄 Why Use DI?
- Decouples implementation from usage (e.g., blocs don’t need to know how services are built).
- Improves testability by allowing mocks to be injected.
- Centralizes configuration for shared app resources like HTTP clients, local storage, theme managers, etc.


---

## 📚 Related
- get_it on pub.dev
- bootstrap.dart: The main setup point for DI
- init_modules.dart: Registers feature/module-specific services
