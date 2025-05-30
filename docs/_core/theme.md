# 🎨 App Theming

This project uses flex_color_scheme for consistent and customizable light and dark themes. Runtime theme switching is handled with flutter_bloc through a ThemeModeCubit, and preferences are persisted using Hive.

---

## 🌈 Static Themes (light & dark)

Defined in theme.dart using FlexThemeData.light() and FlexThemeData.dark():

```dart
final ThemeData lightTheme = FlexThemeData.light(
  scheme: FlexScheme.deepBlue,
  ...
);

final ThemeData darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.deepBlue,
  ...
);
```

### ✨ Features

-   Based on Material Design 3
-   Custom sub-theme configurations (inputs, dropdowns, navigation rail, etc.)
-   Shared visual density and Cupertino overrides
-   Uses FlexColorScheme.comfortablePlatformDensity for consistency across devices

---

## 🌓 Dynamic Theme Mode

### ThemeModeCubit

Defined in \_shared/blocs/theme_mode_cubit.dart, this cubit allows switching between light, dark, and system modes at runtime and persists the setting with Hive.
```
class ThemeModeCubit extends Cubit<ThemeMode> {
...
}
```
### 💡 Responsibilities

| Method        | Description                                      |
|---------------|--------------------------------------------------|
| `darkMode()`  | Switches to dark mode and saves it in Hive       |
| `lightMode()` | Switches to light mode and saves it in Hive      |
| `systemMode()`| Switches to system mode and saves it in Hive     |
| `loadTheme()` | Loads the theme from Hive and emits it           |

---

## 🖼️ Integration in app.dart

In the root app.dart file, the current ThemeMode is applied via BlocBuilder:
```dart
BlocBuilder<ThemeModeCubit, ThemeMode>(
	builder: (context, themeMode) {
		return MaterialApp.router(
		theme: lightTheme,
		darkTheme: darkTheme,
		themeMode: themeMode, // Controlled by ThemeModeCubit
		...
		);
	},
)
```
This ensures seamless theme switching without restarting the app.

---

## 🧮 Toggle Button

Located in \_shared/widgets/theme_mode_button.dart, this widget allows users to toggle between light and dark modes manually:
```dart
return IconButton(
	tooltip: context.tr('layoutPage.changeTheme'),
	constraints: BoxConstraints(minWidth: radius ?? 44, minHeight: radius ?? 44),
	onPressed: () {
		if (Theme.of(context).brightness == Brightness.dark) {
			context.read<ThemeModeCubit>().lightMode();
		} else {
			context.read<ThemeModeCubit>().darkMode();
		}
	},
	icon: Icon(
		Theme.of(context).brightness == Brightness.dark
			? Icons.light_mode_outlined
			: Icons.dark_mode_outlined,
	),
);
```
🛠️ This button updates automatically based on the current brightness and can be placed in the app bar or settings screen.

---

## 📦 Related Files

| File                                 | Purpose                                        |
|-------------------------------------|------------------------------------------------|
| `theme.dart`                        | Defines static `lightTheme` and `darkTheme`   |
| `_shared/blocs/theme_mode_cubit.dart` | BLoC cubit for managing the active `ThemeMode` |
| `_shared/widgets/theme_mode_button.dart` | UI toggle button for switching themes          |
| `app.dart`                         | Applies the current theme mode via `MaterialApp.router` |
| `utils/global_utils.dart` (optional) | Syncs theme mode for web if needed             |

