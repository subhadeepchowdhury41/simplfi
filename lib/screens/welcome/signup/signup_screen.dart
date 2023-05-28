import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailCtrl = TextEditingController();
  final _pswrdCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Title
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Email Address Field
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(
                    labelText: "Email Address",
                  ),
                ),
              ),

              // Password Field
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _pswrdCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                ),
              ),

              // Login Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(double.infinity,
                            MediaQuery.of(context).size.height / 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13))),
                    child: const Text("Sign up"),
                    onPressed: () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailCtrl.text, password: _pswrdCtrl.text)
                          .then((user) {
                        // The user has been signed in successfully.
                      });
                    },
                  ),
                ),
              ),
              // Don't have an account? Sign up text
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Already have an account? Sign in.",
                ),
              ),

              // Sign up button
              GestureDetector(
                child: const Text(
                  "Log in",
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
