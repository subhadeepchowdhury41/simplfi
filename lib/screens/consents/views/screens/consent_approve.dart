import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/models/finvu/consent_model.dart';
import 'package:simplfi/utils/loggs.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ConsentApprovalScreen extends ConsumerStatefulWidget {
  final String redirectUrl;
  const ConsentApprovalScreen(
      {required this.encryptedConsent,
      required this.fipId,
      super.key,
      required this.redirectUrl});
  final EncryptedConsent encryptedConsent;
  final String fipId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConsentApprovalScreenState();
}

class _ConsentApprovalScreenState extends ConsumerState<ConsentApprovalScreen> {
  final _webController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.white);

  Future<void> handleRedirection() async {
    
  }
  Future<void> _init() async {
    await _webController
        .setNavigationDelegate(NavigationDelegate(onPageStarted: (url) {
      logWithColor(message: 'Page load started!', color: 'green');
    }, onPageFinished: (url) {
      logWithColor(message: 'Page load started!', color: 'green');
    }, onUrlChange: (url) {
      logWithColor(message: url.url);
      handleRedirection();
    }));
    await _webController.loadRequest(Uri.parse(
        'https://reactjssdk.finvu.in/?ecreq=${widget.encryptedConsent.encryptedRequest}&reqdate=${widget.encryptedConsent.requestDate}&fi=${widget.fipId}'));
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
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 1,
              child: WebViewWidget(controller: _webController))
        ],
      ),
    );
  }
}
