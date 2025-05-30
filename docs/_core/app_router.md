
# 🧭 App Router

This file defines the centralized routing logic for the Flutter Clean Starter project using [`go_router`](https://pub.dev/packages/go_router). It handles route configuration, navigation guards based on authentication state, transitions, and the initial redirect logic.

---

## 🔑 Key Components

### 🔹 `AppRouter`

A wrapper class for initializing the `GoRouter` instance.

- **Constructor**: Accepts a list of `RouteBase` which defines the app's routes.
- **router**: The main `GoRouter` object, configured with:
  - `navigatorKey`: `rootNavigatorKey`
  - `initialLocation`: `/`
  - `errorPageBuilder`: Renders a custom 404 page on unknown routes.
  - `routes`: Your feature/module routes.

```dart
late final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: "/",
  errorPageBuilder: (_, __) => NoTransitionPage<void>(child: const Error404Page()),
  debugLogDiagnostics: false,
  routes: routes,
);
```

---

### 🚦 Route Guards

These functions intercept navigation based on authentication status:

#### 🔐 authRouteGuard(...)

Allows access only if the user is authenticated. Otherwise, redirects to /errors/401.

``
FutureOr<String?> authRouteGuard(BuildContext context, GoRouterState state)
``

#### 🚫 unAuthRouteGuard(...)

Allows access only if the user is unauthenticated. Otherwise, redirects to the default (first) navigation route.

``
FutureOr<String?> unAuthRouteGuard(BuildContext context, GoRouterState state)
``

#### 🧭 initialRedirect(...)

Used to determine the app’s initial landing route based on authentication state.

* Authenticated → first nav route
* Unauthenticated → /landing on web, /login on mobile
* Unknown → stays at / (until auth status is determined)

``
FutureOr<String?> initialRedirect(BuildContext context, GoRouterState state)
``

---

### 🧩 Utilities

#### 🧷 rootNavigatorKey

A GlobalKey<NavigatorState> used by GoRouter to control the top-level navigator.

`
final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
`

---

#### 🧭 getNavRoutes() and firstNavRoute()

Used to fetch the list of primary navigation tabs (AdaptiveDestination) and get the route of the first tab.

``
List<AdaptiveDestination> getNavRoutes()
``

``
String firstNavRoute()
``

---

#### 📌 Notes

- This router file is designed to be modular and adaptive.
- Routing structure is cleanly separated per feature/module.
- Guards are implemented using Bloc-based auth state, allowing reactive redirects.

---

#### 📚 Related Files

- constants.dart: Contains DI keys and static values.
- di.dart: Registers AdaptiveDestination and AuthBloc.
- adaptive_destination.dart: Defines the structure of bottom/tab navigation destinations.
- error_404_page.dart: Custom fallback UI for unknown routes.


