# 🌐 HTTP Client

The project uses [Dio](https://pub.dev/packages/dio) as the primary HTTP client for all API interactions. It is wrapped and initialized through a custom `HttpClient` class for consistent configuration and centralized request handling.

---

## 📁 File: `lib/_core/http_client.dart`

```
class HttpClient {
  static Future<void> init() async {
    Dio dio = Dio(BaseOptions(baseUrl: Constants.apiBaseUrl));
    ...
    di.registerLazySingleton(() => dio);
  }
}
```

This class configures and registers Dio with necessary interceptors and a base URL, and integrates it into the app’s dependency injection container (di).

---

## 🔧 Initialization

The HttpClient.init() method is called in bootstrap.dart during app startup.

It does the following:

1.	Sets a base URL from Constants.apiBaseUrl
2.	Adds interceptors for:
	- Automatically attaching authorization tokens
	- Logging requests
	- Handling response and error logic
3.	Registers Dio in DI so it can be used anywhere in the app via di<Dio>()

---

## 🛡️ Interceptors

### 🔑 Request Interceptor

Automatically attaches the bearer token from Hive storage (if present):
```dart
final tokenBox = await Hive.openLazyBox(Constants.tokenBoxName);
final token = await tokenBox.get(Constants.cachedTokenRef);
options.headers['authorization'] = "Bearer $token";
```
Also logs the outgoing request:
```dart
debugPrint("request: ${options.uri}");
```

---

### ✅ Response Interceptor

Only passes successful responses (status code 2xx). Others are converted to a ServerException (placeholder for now):
```dart
if (response.statusCode! >= 200 || response.statusCode! < 300) {
  return handler.next(response);
} else {
  response = ServerException() as Response;
  return handler.next(response);
}
```

---

### ❌ Error Interceptor

Logs the error and continues the chain:
```dart
print('onError: => $e');
```

---

## 🧑‍💻 Accessing Dio Anywhere

Because Dio is registered in the DI container, you can retrieve it from anywhere using:
```dart
final dio = di<Dio>();
```

⸻

## 📦 Related Files

File                   | Purpose
------------------------|--------------------------------------------------------------
constants.dart          | Stores the base URL and Hive box/token keys
di.dart                 | Registers Dio as a lazy singleton
bootstrap.dart          | Calls HttpClient.init() during app startup
error/exceptions.dart   | Contains custom exception classes like ServerException

---

## 🧪 Testing Tips
 - You can replace the real Dio instance in tests with a mock:
```
di.unregister<Dio>();
di.registerLazySingleton<Dio>(() => MockDio());
```


---

🚧 Improvements To Consider

- Use pretty_dio_logger for better request/response logs during development.

