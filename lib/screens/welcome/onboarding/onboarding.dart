import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/providers/auth_provider.dart';
import 'package:simplfi/providers/tokens_provider.dart';
import 'package:simplfi/screens/consents/views/screens/list_fips.dart';
import 'package:simplfi/screens/dashboard/provider/budget_provider.dart';
import 'package:simplfi/screens/expense/provider/expense_provider.dart';
import 'package:simplfi/screens/welcome/login/login.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  Future<void> _initializeProviders() async {
    await ref.read(budgetProvider.notifier).initialize();
    await ref.read(tokensProvider.notifier).refreshFinVuToken();
    ref.read(expenseProvider.notifier).initializeExpenses();
    ref.read(authProvider.notifier).syncUser();
  }

  Future<void> _decideRoute() async {
    if (ref.read(authProvider) == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const ListFipScreen()),
          (route) => false);
    }
  }

  _init() async {
    Future.delayed(const Duration(seconds: 1), () async {
      await _initializeProviders().then((value) async {
        await _decideRoute();
      });
    });
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
