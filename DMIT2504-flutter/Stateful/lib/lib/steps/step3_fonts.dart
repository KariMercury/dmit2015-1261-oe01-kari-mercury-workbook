import 'package:flutter/material.dart';

import '../profile_data.dart';

/// STEP 3 – CUSTOM FONTS
///
/// Activity 3 from the lesson plan. Requires the .ttf files in assets/fonts/
/// and the `fonts:` block in pubspec.yaml un-commented (see assets/fonts/README.md).
///
///   3a. Replace the font for the WHOLE app  → ThemeData(fontFamily: ...)
///   3b. Replace the font for ONE widget     → TextStyle(fontFamily: ...)
///
/// Remember: after editing pubspec.yaml you need `flutter pub get` and a
/// FULL RESTART. Hot reload does not load new assets.
class Step3App extends StatelessWidget {
  const Step3App({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(seedColor: Colors.deepOrange);

    return MaterialApp(
      title: 'Employee Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,

        // ── 3a. App-wide font ──────────────────────────────────────────
        //  fontFamily is applied to EVERY TextStyle in the generated
        //  TextTheme. One line, whole app.
        fontFamily: 'Merriweather',

        // Optional: fine-tune individual slots after the family is set.
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontWeight: FontWeight.w700),
          bodyMedium: TextStyle(height: 1.5),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Merriweather',
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Employee Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatar(radius: 56, child: Icon(Icons.person, size: 64)),
            const SizedBox(height: 16),

            // ── 3b. Different font on ONE widget ──────────────────────────
            //  copyWith(fontFamily: ...) overrides just the family; size,
            //  weight and colour still come from the theme slot.
            Text(
              Profile.name,
              textAlign: TextAlign.center,
              style: text.headlineMedium?.copyWith(
                fontFamily: 'Pacifico',
                color: scheme.primary,
              ),
            ),
            Text(
              Profile.role,
              textAlign: TextAlign.center,
              style: text.bodyLarge?.copyWith(
                fontStyle: FontStyle.italic, // uses Merriweather-Italic.ttf
                color: scheme.onSurfaceVariant,
              ),
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
