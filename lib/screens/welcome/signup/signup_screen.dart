import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/providers/auth_provider.dart';
import 'package:simplfi/screens/dashboard/views/dashboard.dart';
import '../login/login.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});
  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
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
                  "Signup",
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
                      ref
                          .read(authProvider.notifier)
                          .signUpWithEmailPassword(
                              email: _emailCtrl.text, password: _pswrdCtrl.text)
                          .then((user) {
                        // The user has been signed up successfully.
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
