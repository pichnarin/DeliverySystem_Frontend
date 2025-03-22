import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/user_avatar.png"), // Change path as needed
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Marvis Ighedosa",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Dosamarvis@gmail.com"),
            const SizedBox(height: 8),
            const Text("+234 9011039271"),
            const SizedBox(height: 8),
            const Text("No 15 Uti Street, Off Ovie Palace Road, Effurun, Delta State"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add edit functionality
              },
              child: const Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }
}