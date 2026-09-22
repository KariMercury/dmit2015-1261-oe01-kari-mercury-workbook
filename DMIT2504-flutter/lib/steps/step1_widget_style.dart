import 'package:flutter/material.dart';

import '../profile_data.dart';

/// STEP 1 – STYLE A SINGLE WIDGET (two ways)
///
/// Activity 1 from the lesson plan. We focus on ONE widget – the name heading –
/// and style it:
///   1a. with CUSTOM VALUES  (TextStyle(...) with literal numbers/colours)
///   1b. with THEME DATA     (Theme.of(context).textTheme / colorScheme)
///
/// Nothing else on the page changes, so students can see the difference in
/// isolation. Toggle [useThemeData] and hot-reload.
const bool useThemeData = false;

class Step1App extends StatelessWidget {
  const Step1App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Employee Profile',
      debugShowCheckedModeBanner: false,
      // Still the DEFAULT theme – we have not touched MaterialApp.theme yet.
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employee Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatar(
              radius: 56,
              child: Icon(Icons.person, size: 64),
            ),
            const SizedBox(height: 16),

            // ─────────────────────────────────────────────────────────────
            // THE ONE WIDGET WE ARE STYLING
            // ─────────────────────────────────────────────────────────────
            if (!useThemeData)
              // 1a. CUSTOM VALUES – quick, but the numbers live only here.
              const Text(
                Profile.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Color(0xFF00695C), // teal 800
                ),
              )
            else
              // 1b. THEME DATA – ask the theme for the values.
              //     • textTheme.headlineMedium is a named "slot" in the theme.
              //     • colorScheme.primary is the app's brand colour.
              //     • copyWith() lets us tweak the slot without replacing it.
              Text(
                Profile.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            // ─────────────────────────────────────────────────────────────

            Text(
              Profile.role,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            const _ContactCard(),
            const SizedBox(height: 24),
            Text('About', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Text(Profile.bio),
            const SizedBox(height: 24),
            Text('Skills', style: Theme.of(context).textTheme.titleMedium),
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

class _ContactCard extends StatelessWidget {
  const _ContactCard();

  @override
  Widget build(BuildContext context) {
    // A second example of reading theme data lower in the tree:
    // no colours are passed down as constructor parameters.
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: scheme.onPrimaryContainer)),
          const SizedBox(height: 8),
          Text('✉  ${Profile.email}',
              style: TextStyle(color: scheme.onPrimaryContainer)),
          Text('☎  ${Profile.phone}',
              style: TextStyle(color: scheme.onPrimaryContainer)),
          Text('⌖  ${Profile.location}',
              style: TextStyle(color: scheme.onPrimaryContainer)),
        ],
      ),
    );
  }
}
