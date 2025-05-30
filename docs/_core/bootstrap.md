
# 🚀 bootstrap.dart

The bootstrap.dart file is the centralized initialization entry point for the app. It sets up all the core services and prepares the application before runApp() is called.

This is typically invoked from the main.dart file during startup.

---

## 🧩 Responsibilities

The Bootstrap.init() method handles the following tasks:

1. Initialize Core DI Tokens

	Registers two empty lists in the dependency injection container (DI) to hold:

	- mainRouesDiKey: All route definitions.
	- navTabsDiKey: Navigation tab destinations (used for adaptive layouts).
```
di.registerSingleton<List<RouteBase>>([], instanceName: Constants.mainRouesDiKey);
di.registerSingleton<List<AdaptiveDestination>>([], instanceName: Constants.navTabsDiKey);
```


2. Initialize Core Services

	Calls initialization methods for essential core services:

	- HttpClient.init(): Configures and registers the Dio HTTP client with interceptors.
	- Database.init(): Initializes the local database (e.g., Hive).
	- InitialAppData.load(): Loads any essential app-wide cached values or configs.


3. Register Network Utilities

	Registers a lazy singleton for NetworkInfo to track internet connection status throughout the app.
```
di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
```

4. Initialize Feature Modules

	Delegates the initialization of all feature modules to AppModules.initBeforeRunApp(). This helps in keeping module-level setup (e.g., auth, post) separate and organized.


5. Register Router

	After all routes have been collected and initialized by the modules, the GoRouter instance is created and registered.
```
di.registerLazySingleton(() => AppRouter(routes: di.get(instanceName: Constants.mainRouesDiKey)));
```

---

✅ Summary

bootstrap.dart is your app’s setup orchestrator. It ensures:

- All dependencies are registered
- All required services are initialized
- Routes and navigation are wired up
- The app is ready to be run

📌 This structure supports modular scalability, clean architecture, and testability by isolating initialization logic from UI components.

