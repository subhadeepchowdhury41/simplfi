import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/utils/loggs.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FinVuRegistrationScreen extends ConsumerStatefulWidget {
  const FinVuRegistrationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FinVuRegistrationScreenState();
}

class _FinVuRegistrationScreenState
    extends ConsumerState<FinVuRegistrationScreen> {
  final _webController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.white)
    ..setNavigationDelegate(NavigationDelegate(onPageStarted: (url) {
      logWithColor(message: 'Page load started!', color: 'green');
    }, onPageFinished: (url) {
      logWithColor(message: 'Page load started!', color: 'green');
    }))
    ..loadRequest(
        Uri.parse('https://webvwdev.finvu.in/onboarding/webview-register'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 1.8,
              child: WebViewWidget(controller: _webController))
        ],
      ),
    );
  }
}
