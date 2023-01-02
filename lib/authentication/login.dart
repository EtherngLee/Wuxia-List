import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wuxialist/authentication/Utils.dart';
import 'package:wuxialist/authentication/forgotpassword.dart';
import 'package:wuxialist/main_pages/main.dart';

class Login extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const Login({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  bool cen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
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
              TextField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(
                height: 10,
              ),
              Stack(alignment: Alignment(1.0, 0.0), children: <Widget>[
                TextFormField(
                  obscureText: cen ? true : false,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: passwordController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
                Positioned(
                    child: IconButton(
                        icon: cen
                            ? const Icon(Icons.remove_red_eye)
                            : const Icon(Icons.remove_red_eye_outlined),
                        onPressed: () {
                          setState(() {
                            if (cen == true) {
                              cen = false;
                            } else {
                              cen = true;
                            }
                          });
                        }))
              ]),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                  style: (ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50))),
                  onPressed: signIn,
                  icon: const Icon(Icons.lock_open, size: 32),
                  label: const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 24),
                  )),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ForgotPassword())),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                  text: TextSpan(
                      style:
                          const TextStyle(fontSize: 20, color: Colors.black54),
                      text: "No Account? ",
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        text: "Sign Up",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).colorScheme.secondary))
                  ]))
            ],
          ),
        ));
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);

      Utils.showsSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
