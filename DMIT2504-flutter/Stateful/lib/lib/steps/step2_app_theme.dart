import 'package:flutter/material.dart';

import '../profile_data.dart';

/// STEP 2 – APP-WIDE THEME
///
/// Activity 2 from the lesson plan:
///   • MaterialApp.theme / darkTheme / themeMode
///   • ColorScheme.fromSeed() – one colour drives the whole look
///   • copyWith() – copy an existing theme and change a few things
///   • a Theme widget that overrides the theme for ONE subtree
///
/// The app is a StatefulWidget so the AppBar toggle can flip [ThemeMode].
class Step2App extends StatefulWidget {
  const Step2App({super.key});

  @override
  State<Step2App> createState() => _Step2AppState();
}

class _Step2AppState extends State<Step2App> {
  ThemeMode _mode = ThemeMode.system;

  void _toggleMode() {
    setState(() {
      _mode = _mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ── 2a. Build a light theme from ONE seed colour ─────────────────────
    //  TRY THIS live: change seedColor to Colors.teal / Colors.pink / a hex
    //  colour and hot-reload. Every Material widget re-colours itself.
    final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepOrange,
        brightness: Brightness.light,
      ),
    );

    // ── 2b. Copy the light theme, change only what dark mode needs ───────
    //  copyWith() keeps every other setting (text theme, shapes, etc.).
    final ThemeData darkTheme = lightTheme.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepOrange,
        brightness: Brightness.dark,
      ),
    );

    // ── 2c. A "brand" variation of the same theme via copyWith ───────────
    //  Show how component themes (AppBarTheme, CardTheme, ...) nest inside
    //  ThemeData. Uncomment and hot-reload to see the difference.
    final ThemeData brandedLight = lightTheme.copyWith(
      appBarTheme: const AppBarTheme(centerTitle: true),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      chipTheme: lightTheme.chipTheme.copyWith(
        shape: const StadiumBorder(),
        side: BorderSide.none,
      ),
    );

    return MaterialApp(
      title: 'Employee Profile',
      debugShowCheckedModeBanner: false,
      theme: brandedLight, // ← swap with lightTheme to compare
      darkTheme: darkTheme,
      themeMode: _mode, // ThemeMode.system | .light | .dark
      home: ProfilePage(onToggleTheme: _toggleMode, mode: _mode),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.onToggleTheme, required this.mode});

  final VoidCallback onToggleTheme;
  final ThemeMode mode;

  @override
  Widget build(BuildContext context) {
    // Grab the theme ONCE at the top of build – tidy and readable.
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Profile'),
        actions: [
          IconButton(
            tooltip: isDark ? 'Switch to light' : 'Switch to dark',
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // No colours here – CircleAvatar reads scheme.primaryContainer.
            const CircleAvatar(radius: 56, child: Icon(Icons.person, size: 64)),
            const SizedBox(height: 16),
            Text(
              Profile.name,
              textAlign: TextAlign.center,
              style: text.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: scheme.primary,
              ),
            ),
            Text(
              Profile.role,
              textAlign: TextAlign.center,
              style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Contact', style: text.titleMedium),
                    const SizedBox(height: 8),
                    const _ContactRow(Icons.email_outlined, Profile.email),
                    const _ContactRow(Icons.phone_outlined, Profile.phone),
                    const _ContactRow(Icons.place_outlined, Profile.location),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('About', style: text.titleMedium),
            const SizedBox(height: 8),
            Text(Profile.bio, style: text.bodyMedium),
            const SizedBox(height: 24),
            Text('Skills', style: text.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final s in Profile.skills) Chip(label: Text(s)),
              ],
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.message),
              label: const Text('Send message'),
            ),
            const SizedBox(height: 12),

            // ── 2d. Override the theme for ONE subtree ────────────────────
            //  Theme() with data: Theme.of(context).copyWith(...) EXTENDS the
            //  parent theme. Only this button turns green; everything else
            //  still follows the app theme.
            Theme(
              data: theme.copyWith(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.green,
                  brightness: theme.brightness,
                ),
              ),
              child: FilledButton.tonalIcon(
                onPressed: () {},
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Mark available'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: scheme.primary),
          const SizedBox(width: 12),
          Text(label),
        ],
      ),
    );
  }
}
