import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wuxialist/authentication/Utils.dart';
import 'package:wuxialist/main_pages/home.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isVerified = false;
  bool canResendEmail = true;
  final user = FirebaseAuth.instance.currentUser!;
  Timer? timer;
  @override
  void initState() {
    super.initState();

    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isVerified) {
      sendVerificationEmail();
    }

    timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => checkEmailVerified(),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    debugPrint("11");
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      debugPrint("hj");
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      Utils.showsSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isVerified
      ? const HomePage()
      : Scaffold(
          appBar: AppBar(
            title: const Text("Verify Email"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "A verification email has been sent to ",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Text(
                  user.email!,
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    onPressed: canResendEmail ? sendVerificationEmail : null,
                    icon: const Icon(Icons.email, size: 32),
                    label: const Text(
                      "Resend Email",
                      style: TextStyle(fontSize: 24),
                    )),
                TextButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 24),
                    ))
              ],
            ),
          ),
        );
}
