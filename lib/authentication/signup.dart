import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wuxialist/authentication/Utils.dart';
import 'package:wuxialist/main_pages/main.dart';

class Signup extends StatefulWidget {
  final Function() onClickedSignIn;

  const Signup({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    password1Controller.dispose();
    password2Controller.dispose();

    super.dispose();
  }

  bool cen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 250,
                      height: 250,
                      child: Image.asset('assets/logo.png')),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: "Email"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && EmailValidator.validate(email)
                            ? null
                            : "Enter a valid email",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: password1Controller,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: "Password"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 8
                        ? "Enter min. 8 characters"
                        : null,
                  ),
                  TextFormField(
                    controller: password2Controller,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration:
                        const InputDecoration(labelText: "Confirm Password"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 8
                        ? "Enter min. 8 characters"
                        : null,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                      style: (ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50))),
                      onPressed: signUp,
                      icon: const Icon(Icons.arrow_circle_right, size: 32),
                      label: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 24),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black54),
                          text: "Already Have an Account? ",
                          children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignIn,
                            text: "Sign In",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Theme.of(context).colorScheme.secondary))
                      ]))
                ],
              ),
            )));
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    if (password1Controller.text.trim() != password2Controller.text.trim()) {
      debugPrint("hi");
      Utils.showsSnackBar("Passwords Don't Match");
    } else {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: password1Controller.text.trim());
      } on FirebaseAuthException catch (e) {
        // ignore: avoid_print
        print(e);

        Utils.showsSnackBar(e.message);
      }
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
