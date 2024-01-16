import 'package:flutter/material.dart';
import 'package:flutter_nutrition_tracker/screens/login_screen.dart';
import 'package:flutter_nutrition_tracker/screens/signup_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = false;
  @override
  Widget build(BuildContext context) => isLogin
      ? LoginScreen(onClickedSignUp: toggle)
      : SignupScreen(
          onClickedSignIn: toggle,
        );

  void toggle() => setState(() {
        isLogin = !isLogin;
        print(isLogin);
      });
}
