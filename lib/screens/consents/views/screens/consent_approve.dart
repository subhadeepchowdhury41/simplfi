import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/models/finvu/consent_model.dart';
import 'package:simplfi/screens/consents/repo/consents_repo.dart';
import 'package:simplfi/utils/loggs.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ConsentApprovalScreen extends ConsumerStatefulWidget {
  final String redirectUrl;
  const ConsentApprovalScreen(
      {required this.encryptedConsent,
      required this.fipId,
      required this.phone,
      super.key,
      required this.redirectUrl});
  final EncryptedConsent encryptedConsent;
  final String fipId;
  final String phone;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConsentApprovalScreenState();
}

class _ConsentApprovalScreenState extends ConsumerState<ConsentApprovalScreen> {
  final _webController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.white);

  Future<void> handleRedirection(String url) async {
    logWithColor(message: widget.redirectUrl, color: 'blue');
    logWithColor(message: url.split('?')[0], color: 'blue');
    if (url.split('?')[0] != widget.redirectUrl) {
      return;
    }
    ConsentsRepo.listenConsentStatus(widget.encryptedConsent.consentHandle!)
        .listen((event) {
      logWithColor(message: event);
    });
  }

  Future<void> _init() async {
    await _webController
        .setNavigationDelegate(NavigationDelegate(onPageStarted: (url) {
      logWithColor(message: 'Page load started!', color: 'green');
      handleRedirection(url);
    }, onPageFinished: (url) {
      logWithColor(message: 'Page load started!', color: 'green');
    }, onUrlChange: (url) {
      logWithColor(message: url.url);
    }));
    final fip = base64.encode(utf8.encode('BARB0KIMXXX'));
    await _webController.loadRequest(Uri.parse(
        'https://reactjssdk.finvu.in/?ecreq=${widget.encryptedConsent.encryptedRequest}&reqdate=${widget.encryptedConsent.requestDate}&fi=${widget.encryptedConsent.encryptedFiuId}&fip=$fip'));
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: WebViewWidget(controller: _webController))
        ],
      ),
    );
  }
}
