# Shared Module

The `shared` module contains functionality, data models, utilities, widgets, and BLoCs that are reused across multiple feature modules in the application. It acts as the common ground for cross-cutting concerns and shared logic.

---

## Structure

### 1. Blocs

- Contains non-feature-specific or widely used BLoCs/Cubits, such as:
  - `ThemeModeCubit` for theme management across the app.

### 2. Data Layer
- Houses shared data models and domain abstractions that multiple modules use.
- Example:
  	- `result_page_model.dart` parses paginated API responses for various modules.

```dart
@JsonSerializable(createToJson: false)
class ResultPageModel extends ResultPage {
  ResultPageModel(
    super.current,
    super.pageSize,
    super.totalPages,
    super.totalElements,
    super.first,
    super.last,
  );

  factory ResultPageModel.fromJson(Map<String, dynamic> json) =>
      _$ResultPageModelFromJson(json);
}
```
### 3. Domain Layer

- Contains generic domain abstractions used across modules, such as:
- Sorting, pagination, filtering, and query result types.

	Example from cqrs.dart:
	```dart
	class Sort {
		final String field;
		final String direction;

		Sort(this.field, this.direction);
	}

	class Pagination {
		final int page;
		final int pageSize;

		Pagination(this.page, this.pageSize);
	}
	// Other classes like ResultPage, Query, FilteredQuery, etc.	
	```
These classes facilitate consistent API query building and response handling throughout the app.

### 4. Features Layer

- Contains shared UI pages and components used across the app:
- Error pages (404, 401)
- Home page
- Landing page
- Settings page
- Splash page

### 5. Utils
* Utility functions and helpers used app-wide.
    * Example: GlobalUtils manages web-specific theme mode persistence:

```dart
class GlobalUtils {
  static void setThemeModeForWeb(String mode) {
    if (kIsWeb) {
      final storage = html.window.localStorage;
      if (mode == 'Light') {
        storage.update('theme', (value) => 'light', ifAbsent: () => 'light');
      } else if (mode == 'Dark') {
        storage.update('theme', (value) => 'dark', ifAbsent: () => 'dark');
      }
    }
  }
}
```
### 6. Widgets
- Contains shared reusable widgets utilized in various modules.

---

## Module Registration

The shared module is registered and initialized via:

- shared_module.dart — Handles DI registrations for shared services and BLoCs:
```dart
Future<void> registerSharedModule() async {
  // Register BLoCs
  di.registerSingleton<ThemeModeCubit>(ThemeModeCubit(hive: di())..loadTheme(di()));
  di.registerSingleton<NavigationService>(NavigationService());

  // Register shared routes
  di<List<RouteBase>>(instanceName: Constants.mainRouesDiKey).addAll(sharedRoutes());
}

void registerSharedModuleWithContext(BuildContext context) {
  var navTabs = di<List<AdaptiveDestination>>(instanceName: Constants.navTabsDiKey);
  navTabs.addAll(getSharedNavTabs(context));
}
```
- shared_routes.dart — Defines routes and navigation tabs used by shared features such as home, settings, splash, error pages, and landing.
  	
	- Example navigation tabs:
```dart
List<AdaptiveDestination> getSharedNavTabs(BuildContext context) {
  return <AdaptiveDestination>[
    AdaptiveDestination(
      title: context.tr('layoutPage.home'),
      icon: Icons.home,
      route: '/home',
      navTab: SharedNavTab.home,
      order: 1,
    ),
    AdaptiveDestination(
      title: context.tr('layoutPage.settings'),
      icon: Icons.settings,
      route: '/settings',
      navTab: SharedNavTab.settings,
      order: 40,
    ),
  ];
}
```

    - Example routes:
```dart
List<GoRoute> sharedRoutes() {
	return [
		GoRoute(path: "/", redirect: (_, __) => "/splash"),
		GoRoute(
		path: '/splash',
		redirect: initialRedirect,
		pageBuilder: (context, state) => FadeTransitionPage(child: const SplashPage()),
		),
		// More routes like error 401, landing, home, settings...
	];
}
```

---

## Summary

The shared module centralizes:

- Reusable blocs and state management
- Cross-cutting domain models and query abstractions
- Common utility functions
- Shared UI components and pages
- Routing and navigation tabs used across the app

This modular approach encourages clean separation and reuse, reducing code duplication and easing maintenance.
