import 'package:flutter/material.dart';

import '../profile_data.dart';

/// STEP 0 – STARTING POINT
///
/// A working profile page with NO theming. Every colour and size is
/// hard-coded right where it is used. Run this first and ask the class:
///   "If the client says 'make our brand colour teal', how many places
///    do we have to edit?"  (answer: every single one)
class Step0App extends StatelessWidget {
  const Step0App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Employee Profile',
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Profile'),
        backgroundColor: Colors.deepOrange, // hard-coded
        foregroundColor: Colors.white, // hard-coded
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatar(
              radius: 56,
              backgroundColor: Colors.deepOrange, // hard-coded
              child: Icon(Icons.person, size: 64, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              Profile.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28, // hard-coded
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange, // hard-coded
              ),
            ),
            const Text(
              Profile.role,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50, // hard-coded
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8),
                  Text('✉  ${Profile.email}'),
                  Text('☎  ${Profile.phone}'),
                  Text('⌖  ${Profile.location}'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('About',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text(Profile.bio),
            const SizedBox(height: 24),
            const Text('Skills',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final s in Profile.skills) Chip(label: Text(s)),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.message),
              label: const Text('Send message'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange, // hard-coded
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
