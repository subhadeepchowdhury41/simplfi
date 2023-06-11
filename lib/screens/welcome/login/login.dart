import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/providers/auth_provider.dart';
import 'package:simplfi/screens/dashboard/views/dashboard.dart';
import 'package:simplfi/screens/welcome/signup/signup_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
                    child: const Text("Login"),
                    onPressed: () {
                        ref.read(authProvider.notifier)
                          .signInWithEmailPassword(
                              email: _emailCtrl.text, password: _pswrdCtrl.text)
                          .then((user) {
                        // The user has been signed in successfully.
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Dashboard()),
                            (route) => false);
                      }).catchError((err) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(err.toString())));
                      });
                    },
                  ),
                ),
              ),
              // Don't have an account? Sign up text
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Don't have an account? Sign up.",
                ),
              ),

              // Sign up button
              GestureDetector(
                child: const Text(
                  "Sign up",
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
