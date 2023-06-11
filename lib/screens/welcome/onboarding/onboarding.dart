import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/providers/auth_provider.dart';
import 'package:simplfi/screens/dashboard/views/dashboard.dart';
import 'package:simplfi/screens/finvu/registration.dart';
import 'package:simplfi/screens/welcome/login/login.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  Future<void> _decideRoute() async {
    ref.read(authProvider.notifier).syncUser();
    if (ref.read(authProvider) == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const FinVuRegistrationScreen()),
          (route) => false);
    }
  }

  _init() async {
    Future.delayed(const Duration(seconds: 1), _decideRoute);
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'SimplFi',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 34),
        ),
      ),
    );
  }
}
