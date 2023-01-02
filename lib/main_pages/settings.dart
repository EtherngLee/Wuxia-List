import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wuxialist/authentication/login.dart';
import 'package:wuxialist/authentication/signup.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            color: Colors.blue,
            width: double.infinity,
            child: const Center(
              child: Text(
                "User Data",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const Text(
            "Signed In As",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            user.email!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            width: double.infinity,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)),
                icon: const Icon(Icons.logout),
                label: const Text(
                  "Sign Out",
                ),
                onPressed: () => FirebaseAuth.instance.signOut()),
          )
        ],
      ),
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
    );
  }
}
