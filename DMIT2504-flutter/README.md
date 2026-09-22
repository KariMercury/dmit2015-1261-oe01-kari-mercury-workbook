# week_03_profile_theme — live demo project

Companion demo for **DMIT 2504 · Week 3 Day 2 · Themes and Styling**.

## Set up (once, before class)

```bash
flutter create week_03_profile_theme        # generates android/ ios/ web/ etc.
# copy this folder's lib/, pubspec.yaml and assets/ over the generated ones
cd week_03_profile_theme
flutter pub get
flutter run -d chrome        # or an emulator
```

For Step 3, download the fonts first — see `assets/fonts/README.md`.

## Demo script (what to change, in order)

| Stage | File | Change live | Talking point |
|---|---|---|---|
| 0 | `lib/main.dart` | `demoStep = 0` | Hard-coded colours everywhere. "How many edits for a rebrand?" |
| 1a | `steps/step1_widget_style.dart` | `useThemeData = false` | Style ONE widget with literal `TextStyle` values |
| 1b | same | `useThemeData = true` | Same widget, values from `Theme.of(context)` — still default theme |
| 2a | `steps/step2_app_theme.dart` | change `seedColor` | `ColorScheme.fromSeed` re-colours everything |
| 2b | same | tap the AppBar toggle | `darkTheme` + `themeMode`, built with `copyWith` |
| 2c | same | swap `brandedLight` ↔ `lightTheme` | Component themes nested in `ThemeData` |
| 2d | same | point at the green button | `Theme()` widget overrides a subtree |
| 3a | `steps/step3_fonts.dart` | `fontFamily: 'Merriweather'` | Whole-app font — needs **full restart** |
| 3b | same | `fontFamily: 'Pacifico'` on the name | One widget, different font |

Each stage is its own file so you can jump straight to a clean version if a
live edit goes sideways: change `demoStep` in `lib/main.dart` and hot-restart.
