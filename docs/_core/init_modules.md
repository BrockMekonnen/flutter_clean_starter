# 🧩 init_modules.dart

The init_modules.dart file orchestrates the registration of feature modules in the app, ensuring they are initialized at the right time based on whether they require a BuildContext.

---

## 🧠 Purpose

Flutter Clean Starter follows modular design, and this file centralizes the initialization of all app modules (like AuthModule, PostModule, SharedModule, etc.).

Modules are registered in two phases:

✅ initBeforeRunApp()

* Called before runApp()
* Used to initialize modules that do not require BuildContext
* Example: setting up routes, services, or BLoC providers

✅ initAfterRunApp(BuildContext context)

* Called after runApp(), when a BuildContext is available
* Used to initialize modules that need access to UI context (e.g., for navigation tabs)
* Ensures a context-safe modular configuration

---

## 📦 Code Breakdown
```dart
class AppModules {
  static void initBeforeRunApp() {
    registerAuthModule();
    registerSharedModule();
    registerPostModule();
  }

  static void initAfterRunApp(BuildContext context) {
    var navTabs = di<List<AdaptiveDestination>>(instanceName: Constants.navTabsDiKey);
    navTabs.clear();

    registerAuthModuleWithContext(context);
    registerSharedModuleWithContext(context);
    registerPostModuleWithContext(context);

    navTabs.sort();
  }
}
```

---

### 📌 Modular Lifecycle

| Phase     | Method                    | Requires `BuildContext` | Example Use Cases              |
|-----------|---------------------------|--------------------------|--------------------------------|
| Pre-run   | `initBeforeRunApp()`      | ❌ No                    | Register routes, services      |
| Post-run  | `initAfterRunApp(context)`| ✅ Yes                   | Register UI elements like tabs |

---

## 💡 Why This Pattern?

* Separation of concerns: Keeps pre-run and post-run registrations clean and isolated
* Context safety: Prevents premature access to BuildContext
* Extendability: Easy to add new modules without touching the core bootstrap logic

---

## 🧩 Example Modules

Each module typically has two registration functions:
```dart
// Called before runApp
void registerAuthModule();

// Called after runApp with BuildContext
void registerAuthModuleWithContext(BuildContext context);
```
This keeps all logic related to a module encapsulated, following good Clean Architecture practices.

---

## 📦 Related Files

File                | Purpose
--------------------|--------------------------------------------
init_modules.dart   | Initializes modules before/after app starts
auth_module.dart    | Registers Auth-related routes and tabs
post_module.dart    | Registers Post-related routes and tabs
shared_module.dart  | Shared widgets/utils/modules registration
di.dart             | Registers dependencies via GetIt
constants.dart      | Holds DI keys for tab/routing management

