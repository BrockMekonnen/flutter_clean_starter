# 🔐 Authentication Module

This module handles all user authentication logic using a clean architecture approach, keeping core business rules isolated from external dependencies.

---

## 🧠 Domain Layer

Defines core authentication logic, independent of any frameworks or data sources.

#### user.dart

Entity representing the authenticated user.

```dart
	class User extends Equatable {
		final String id, firstName, lastName, phone, email;
		final bool isEmailVerified;
		final List<String> roles;

		const User({
			required this.id,
			required this.firstName,
			required this.lastName,
			required this.phone,
			required this.email,
			required this.isEmailVerified,
			required this.roles,
		});

		static const empty = User(
			id: '-', firstName: '-', lastName: '-', phone: '-',
			email: '-', isEmailVerified: false, roles: [],
		);

		@override
		List<Object> get props => [id, firstName, lastName, phone, email, isEmailVerified, roles];
	}
```

#### auth_repository.dart

Abstract contract for authentication operations.

```dart
abstract class AuthRepository {
  Stream<User> getUserStream();
  void dispose();

  Future<Either<Failure, void>> isAuthenticated();
  Future<Either<Failure, void>> login({required String email, required String password});
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User?>> getUser();
  Future<Either<Failure, void>> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required bool iAgree,
  });
}
```

#### auth_usecases.dart

Use cases that interact with AuthRepository.

```dart
class AuthUsecases {
  final AuthRepository repo;
  AuthUsecases(this.repo);

  Future<Either<Failure, void>> isAuthenticated() => repo.isAuthenticated();
  Stream<User> getUserStream() => repo.getUserStream();
  Future<Either<Failure, void>> logout() => repo.logout();
  void dispose() => repo.dispose();
}
```

---

## 📦 Data Layer

The data layer provides the concrete implementation of AuthRepository and bridges the domain layer with external systems (network and local storage).

It uses:

- 🛰️ Dio for network calls
- 📦 Hive for local caching
- 🔁 RxDart (BehaviorSubject) for user state streaming

---

#### 🔧 AuthRepositoryImpl

Implements the AuthRepository contract using Dio, Hive, and network info. Key responsibilities:

| Method            | Description                                                      |
|-------------------|------------------------------------------------------------------|
| `login`           | Authenticates via `/users/login`, caches token/user, updates stream |
| `register`        | Sends registration request to `/users`                          |
| `getUser`         | Fetches user from API, updates user stream                      |
| `isAuthenticated` | Checks user stream or loads from cache                          |
| `logout`          | Clears Hive boxes and resets user stream                        |
| `getUserStream()` | Returns reactive stream of current `User`                       |
| `dispose()`       | Closes the stream                                                |

🗃️ Local Helpers:

* \_cacheToken, \_cacheUser, \_getCachedUser, \_clearCache
* \_mapError: maps exceptions to domain Failure objects



<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<details>
<summary>Full Implementation: <code>auth_repository_impl.dart</code></summary>
```dart
class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;
  final HiveInterface hive;
  final NetworkInfo networkInfo;
  final _userController = BehaviorSubject<User>();

  AuthRepositoryImpl({required this.dio, required this.hive, required this.networkInfo});

  @override
  Stream<User> getUserStream() => _userController.stream;

  @override
  Future<Either<Failure, void>> isAuthenticated() async {
    try {
      if (_userController.hasValue) return Right(null);
      final user = await _getCachedUser();
      _userController.add(user);
      return Right(null);
    } catch (_) {
      _userController.add(User.empty);
      return Left(CacheFailure("Failed to load cached user"));
    }
  }

  @override
  Future<Either<Failure, void>> login({required String email, required String password}) async {
    try {
      final res = await dio.post('/users/login', data: {"email": email, "password": password});
      final token = res.data['data']['token'];
      if (token == null) return Left(ServerFailure("Invalid response"));

      await _cacheToken(token);
      final user = await _getUser();
      await _cacheUser(user);
      _userController.add(user);
      return Right(null);
    } catch (e) {
      return Left(_mapError(e));
    }
  }

  @override
  Future<Either<Failure, void>> register({ ... }) async {
    try {
      await dio.post('/users', data: { ... });
      return Right(null);
    } catch (e) {
      return Left(_mapError(e));
    }
  }

  @override
  Future<Either<Failure, User?>> getUser() async {
    try {
      final user = await _getUser();
      _userController.add(user);
      return Right(user);
    } catch (e) {
      return Left(_mapError(e));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _clearCache();
      _userController.add(User.empty);
      return Right(null);
    } catch (_) {
      return Left(CacheFailure("Failed to clear cache"));
    }
  }

  @override
  void dispose() => _userController.close();

  // Helpers
  Future<UserModel> _getUser() async =>
      UserModel.fromJson((await dio.get('/users/me')).data['data']);

  Future<UserModel> _getCachedUser() async =>
      await hive.openLazyBox('userBox').then((b) => b.get('cachedUser') ?? (throw CacheException()));

  Future<void> _cacheToken(String token) async =>
      await hive.openLazyBox('tokenBox').then((b) => b.put('cachedToken', token));

  Future<void> _cacheUser(UserModel user) async =>
      await hive.openLazyBox('userBox').then((b) => b.put('cachedUser', user));

  Future<void> _clearCache() async {
    await hive.openLazyBox('userBox').then((b) => b.clear());
    await hive.openLazyBox('tokenBox').then((b) => b.clear());
  }

  Failure _mapError(dynamic e) {
    if (e is DioException) return ServerFailure(DioExceptions.fromDioError(e).toString());
    if (e is CacheException) return CacheFailure("Caching failed");
    return ServerFailure("Unexpected error");
  }
}
```

</details>

---

#### 👤 UserModel

A Hive-compatible, JSON-deserializable implementation of the domain User. Used for:
• parsing /users/me API response
• local caching with Hive

```dart
@HiveType(typeId: 1)
@JsonSerializable(createToJson: false)
class UserModel extends User {
	@HiveField(0) @JsonKey(name: 'id') final String id;
	@HiveField(1) @JsonKey(name: 'firstName') final String firstName;
	@HiveField(2) @JsonKey(name: 'lastName') final String lastName;
	@HiveField(3) @JsonKey(name: 'phone') final String phone;
	@HiveField(4) @JsonKey(name: 'email') final String email;
	@HiveField(5) @JsonKey(name: 'isEmailVerified', defaultValue: false) final bool isEmailVerified;
	@HiveField(6) @JsonKey(name: 'roles') final List<String> roles;

	const UserModel(
		this.id, this.firstName, this.lastName,
		this.phone, this.email, this.isEmailVerified, this.roles
	) : super(
		id: id, firstName: firstName, lastName: lastName,
		phone: phone, email: email, isEmailVerified: isEmailVerified, roles: roles);

	factory UserModel.fromJson(Map<String, dynamic> json) => \_$UserModelFromJson(json);
}
```

## 🎨 Features Layer

The features/ directory holds UI-related logic and presentation for the authentication module. It is organized into feature-specific subfolders:

```
features/
├── login/       # Login screen UI and its BLoC
├── register/    # Sign up screen UI and its BLoC
└── profile/     # Profile screen UI
```

### 🔐 Login Flow Example

#### 📂 features/login/bloc/login_bloc.dart

Handles login logic by invoking the AuthUsecases.login(...) method and emitting states based on the result.

```dart
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthUsecases _authUsecases;

  LoginBloc({required AuthUsecases authUsecases})
      : _authUsecases = authUsecases,
        super(LoginInitial()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    var result = await _authUsecases.login(
      email: event.email,
      password: event.password,
    );
    emit(result.fold(
      (error) => LoginFailure(error: error.getMessage()),
      (_) => LoginSuccess(),
    ));
  }
}
```

#### 📄 features/login/page/login_page.dart

Wraps the login form with a BlocProvider and injects LoginBloc from the dependency injector (di()).

```dart
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => di(),
        child: const Center(child: LoginForm()),
      ),
    );
  }
}
```

#### 🧩 features/login/widgets/login_button.dart

Button that triggers the login submission after validating form data:

```dart
BlocBuilder<LoginBloc, LoginState>(
  builder: (context, state) {
    final isLoading = state is LoginLoading;
    return FilledButton(
      onPressed: !isLoading
          ? () {
              if (formKey.currentState?.saveAndValidate() ?? false) {
                context.read<LoginBloc>().add(LoginSubmitted(
                  email: formKey.currentState?.value['email'],
                  password: formKey.currentState?.value['password'],
                ));
              }
            }
          : null,
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(context.tr("loginPage.signIn")),
    );
  },
);
```

---

## 🧩 Module Registration

#### 🧱 auth_module.dart

This file is responsible for registering all dependencies related to the auth module using GetIt.

```dart
Future<void> registerAuthModule() async {
  // Hive Adapters
  di<HiveInterface>().registerAdapter<UserModel>(UserModelAdapter());

  // Repository & Usecases
  di.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(dio: di(), hive: di(), networkInfo: di()),
  );
  di.registerLazySingleton<AuthUsecases>(() => AuthUsecases(di()));

  // Global AuthBloc
  di.registerLazySingleton(
    () => AuthBloc(userUsecase: di())..add(AuthStatusSubscriptionRequested()),
  );

  // Feature Blocs
  di.registerFactory(() => LoginBloc(authUsecases: di()));
  di.registerFactory(() => RegisterBloc(authUsecases: di()));

  // Routes
  di<List<RouteBase>>(instanceName: Constants.mainRouesDiKey)
      .addAll(authRoutes());
}
```

#### 🧭 Navigation Tabs

Some auth features like Profile are available as tabs in adaptive layouts. Tabs are injected via registerAuthModuleWithContext, which uses BuildContext to access localized labels.

````dart
void registerAuthModuleWithContext(BuildContext context) {
  final navTabs = di<List<AdaptiveDestination>>(
    instanceName: Constants.navTabsDiKey,
  );
  navTabs.addAll(getAuthNavTabs(context));
}
````

#### 🗂️ auth_routes.dart

Defines all routes and navigation tabs for the auth module.

````dart
List<GoRoute> authRoutes() {
  return [
    GoRoute(
      path: "/login",
      redirect: unAuthRouteGuard,
      pageBuilder: (_, __) => const FadeTransitionPage(child: LoginPage()),
    ),
    GoRoute(
      path: "/register",
      redirect: unAuthRouteGuard,
      pageBuilder: (_, __) => const FadeTransitionPage(child: RegisterPage()),
    ),
    GoRoute(
      path: "/profile",
      redirect: authRouteGuard,
      pageBuilder: (_, __) => const FadeTransitionPage(child: ProfilePage()),
    ),
  ];
}
````

### 🧭 getAuthNavTabs

Defines tabs to be injected into the adaptive layout.

````dart
List<AdaptiveDestination> getAuthNavTabs(BuildContext context) {
  return <AdaptiveDestination>[
    AdaptiveDestination(
      title: context.tr('layoutPage.profile'),
      icon: Icons.person,
      route: '/profile',
      navTab: AuthNavTab.profile,
      order: 30,
    ),
  ];
}
````
