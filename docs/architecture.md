# 🏗️ Project Architecture

This project follows a robust Clean Architecture pattern, structured to ensure separation of concerns, modularity, and scalability. What sets this implementation apart is its modular design, where each feature lives in an isolated module with its own layers, routes, and logic.

---

## 🧱 Clean Architecture Layers

Each module and shared component follows the classic Clean Architecture principles:

* Domain Layer — Business logic, entities, and contracts (abstract repositories, use cases)
* Data Layer — Concrete implementations for repositories, local/remote data sources
* Feature Layer — UI, state management (BLoC), and presentation logic

This separation enables each layer to be independently testable, replaceable, and loosely coupled.

---

## 📦 Modular Design

The app is split into independent modules, each responsible for a specific domain (e.g., Auth, Posts, etc.).

## ✅ Why Modules?

- 🧩 Self-contained: Each module contains its own domain, data, and feature layers.
- 👥 Team-friendly: Multiple teams can work on different modules independently.
- ➕ Pluggable: Modules can be easily added or removed without touching the core app.
- 📁 Organized: Cleaner structure and simpler onboarding for new developers.

---

## 🗂️ Module Structure

A typical module (e.g., auth) is structured like this:
```
modules/
└── auth/
    ├── data/       # Data sources, models, repositories
    ├── domain/     # Entities, use cases, repository contracts
    ├── features/   # BLoC, UI, screens
    ├── auth_module.dart     # Module entry (DI and initializations)
    └── auth_routes.dart     # Module routes and nav registration

```
---

## 🔌 Module Registration

Each module registers itself through:

- *_module.dart → Used to initialize dependencies (e.g., repositories, use cases)
- *_routes.dart → Used to register routes and navigation tabs in the global app router

This enables complete decoupling of routing and logic between modules.

---

## 🌐 Shared Components

Common logic is placed in the _shared directory:

- blocs/ — Reusable BLoCs across modules
- widgets/ — Shared widgets
- utils/ — Utility functions
- data/ & domain/ — Shared services and models
- features/ — Shared features not tied to a specific module

---

## 🔁 Module Lifecycle

Each module follows a consistent lifecycle:

1.	✅ Define use cases, entities, and contracts in the domain/
2.	🔗 Implement data sources and repositories in the data/
3.	🎨 Build BLoCs and UI in the features/
4.	🛠️ Initialize dependencies in *_module.dart
5.	🧭 Register routes in *_routes.dart

---

## 🧪 Testability

The separation of layers and modules allows:

- Easy unit testing of business logic and use cases
- Mocking of repositories in isolation
- Clean widget and BLoC testing within each feature

---

## 🧭 Visual Overview
```
lib/
├── _core/           # Core setup (DI, routing, theming)
├── _shared/         # Reusable logic and components
├── modules/         # Feature-based modules (e.g., auth, posts)
├── app.dart         # 
└── main.dart        # Entry point
```

---

## 🎯 Summary

This architecture makes it easy to:

- Scale the app with new features
- Collaborate across large teams
- Maintain and test code reliably
- Customize or remove modules cleanly

You can find example modules like auth and posts in the respective folders. Each one is fully isolated and demonstrates the intended Clean Modular Architecture pattern.

