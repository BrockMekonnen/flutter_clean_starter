# Modules Overview

This directory contains the modular components of the application, organized by feature or shared functionality. Each module encapsulates its own dependencies, state management, UI, and business logic to promote scalability and maintainability.

## Structure

- **shared.md**  
  Contains reusable components, widgets, BLoCs/Cubits, utilities, and services shared across multiple modules or the entire app.

- **auth.md**  
  Handles all authentication-related features such as login, registration, session management, and user profile.

- **post.md**  
  Manages the post feature, including creating, updating, listing, and displaying posts.

## Purpose

The modular approach allows:

- Clear separation of concerns between different parts of the app.
- Easier testing and independent development of features.
- Simplified dependency injection and service registration.
- Better code organization and reusability.

## Initialization Lifecycle

Modules are initialized in two phases:

1. **Before App Run**  
   Registers core services, repositories, and non-UI dependencies.

2. **After App Run**  
   Registers UI-related components requiring `BuildContext` (e.g., navigation tabs, theme setup).

The registration logic is centralized in `init_modules.dart` to streamline module setup.

---

Refer to each module's individual documentation (`auth.md`, `post.md`, `shared.md`) for detailed information about its structure, responsibilities, and usage.