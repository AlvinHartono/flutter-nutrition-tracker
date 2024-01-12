import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nutrition_tracker/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordConfirm = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
    _passwordConfirm.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 100, 0, 120),
                    child: const Text(
                      "Nutrition Tracker App",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _password,
                    decoration: const InputDecoration(
                      labelText: "Password",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length <= 8) {
                        return 'Password must be 8 characters or longer';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordConfirm,
                    decoration: const InputDecoration(
                      labelText: "Confirm Password",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length <= 8) {
                        return 'Password must be 8 characters or longer';
                      } else if (_passwordConfirm.text != _password.text) {
                        return 'Password don\'t match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //firebase
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                        },
                        child: const Text("Login"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
