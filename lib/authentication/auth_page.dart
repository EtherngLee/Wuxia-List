import 'package:flutter/material.dart';
import 'package:wuxialist/authentication/login.dart';
import 'package:wuxialist/authentication/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? Login(onClickedSignUp: toggle)
      : Signup(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
