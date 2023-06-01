import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

class AccountConnection extends ConsumerStatefulWidget {
  const AccountConnection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AccountConnectionState();
}

class _AccountConnectionState extends ConsumerState<AccountConnection> {
  LinkConfiguration? _configuration = LinkTokenConfiguration(
      token: 'link-sandbox-01740959-c7f1-4b6b-91bd-92cf4d5d6fe3');
  StreamSubscription<LinkEvent>? _streamEvent;
  StreamSubscription<LinkExit>? _streamExit;
  StreamSubscription<LinkSuccess>? _streamSuccess;
  LinkObject? _successObject;
  @override
  void initState() {
    super.initState();
    _streamEvent = PlaidLink.onEvent.listen(_onEvent);
    _streamExit = PlaidLink.onExit.listen(_onExit);
    _streamSuccess = PlaidLink.onSuccess.listen(_onSuccess);
    PlaidLink.open(configuration: _configuration!);
  }

  @override
  void dispose() {
    _streamEvent?.cancel();
    _streamExit?.cancel();
    _streamSuccess?.cancel();
    super.dispose();
  }

  void _createLegacyTokenConfiguration() {
    _configuration = LegacyLinkConfiguration(
      clientName: "SimplFi",
      publicKey: "",
      environment: LinkEnvironment.sandbox,
      products: <LinkProduct>[
        LinkProduct.auth,
      ],
      language: "en",
      countryCodes: ['US'],
      userLegalName: "John Appleseed",
      userEmailAddress: "subha@simplfi.app",
      userPhoneNumber: "+918768715527",
    );
  }

  void _onEvent(LinkEvent event) {
    final name = event.name;
    final metadata = event.metadata.description();
    debugPrint("onEvent: $name, metadata: $metadata");
  }

  void _onSuccess(LinkSuccess event) {
    final token = event.publicToken;
    final metadata = event.metadata.description();
    debugPrint("onSuccess: $token, metadata: $metadata");
    setState(() => _successObject = event);
  }

  void _onExit(LinkExit event) {
    final metadata = event.metadata.description();
    final error = event.error?.description();
    debugPrint("onExit metadata: $metadata, error: $error");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
