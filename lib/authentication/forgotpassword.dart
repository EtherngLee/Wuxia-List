import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wuxialist/authentication/Utils.dart';
import 'package:wuxialist/main_pages/main.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Reset Password",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Provide an email to reset password",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    cursorColor: Colors.black87,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText: "Email"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: ((email) =>
                        email != null && !EmailValidator.validate(email)
                            ? "Enter a valid email"
                            : null),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: resetPassword,
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    icon: const Icon(Icons.email_outlined),
                    label: const Text(
                      "Reset Password",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              )),
        ));
  }

  Future resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showsSnackBar("Password Reset Email Sent");
      // ignore: use_build_context_synchronously
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
      Utils.showsSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
