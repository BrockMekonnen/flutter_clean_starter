# 🗄️ database.dart

The database.dart file initializes and registers Hive as the local database solution used throughout the app.

---

## ⚙️ Initialization

The Database.init() method is called in bootstrap.dart during app startup. It does two things:

1.	Initializes Hive using Hive.initFlutter() so it can be used in a Flutter environment.
2.	Registers Hive in the Dependency Injection (DI) container so it can be accessed globally via di.get<HiveInterface>().
```dart
class Database {
  static init() async {
    await Hive.initFlutter();
    di.registerLazySingleton<HiveInterface>(() => Hive);
  }
}
```

---

## 💡 Usage Pattern

After initialization, Hive can be accessed through the DI container anywhere in the app using:
```dart
final hive = di<HiveInterface>();
```

---

## 📦 Example: Caching and Retrieving a User

Hive is commonly used to cache lightweight app data such as tokens, user sessions, or preferences. Here’s how it’s used in the AuthRepository:

✅ Caching a User
```dart
Future<void> _cacheUser(UserModel user) async {
  try {
    final userBox = await hive.openLazyBox(Constants.userBoxName);
    userBox.put(Constants.cachedUserRef, user);
  } catch (e) {
    throw CacheException();
  }
}
```
🔄 Retrieving a Cached User
```dart
Future<UserModel> _getCachedUser() async {
  final userBox = await hive.openLazyBox(Constants.userBoxName);
  final user = await userBox.get(Constants.cachedUserRef);
  if (user != null) {
    return user;
  } else {
    throw CacheException();
  }
}
```

---

## ✅ Benefits
- Performance: Hive is a lightweight, fast NoSQL database perfect for local caching.
- Modularity: By registering Hive in DI, you can swap it with another local DB in the future without tightly coupling it to your feature code.
- Scalability: With box-based separation, each module can manage its own storage cleanly.

---

## 📦 Related Files

File            | Purpose
----------------|--------------------------------------------
database.dart   | Initializes and registers Hive via DI
constants.dart  | Contains Hive box and key names
di.dart         | Registers Hive as a lazy singleton
auth_repository | Demonstrates caching/retrieving data via Hive


