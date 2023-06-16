import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/models/finvu/consent_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simplfi/screens/consents/provider/consents_provider.dart';

class ConsentsRepo {
  static final _instance = FirebaseFirestore.instance;
  static Future<List<Consent>> getAllConsents(String uid) async {
    final result = <Consent>[];
    await _instance
        .collection('users')
        .doc(uid)
        .collection('consents')
        .get()
        .then((consents) {
      for (var consent in consents.docs) {
        result.add(Consent(
            encryptedConsent: EncryptedConsent.fromJson(
              consent.data(),
            ),
            expiryDate: consent.data()['expiryDate']));
      }
      return result;
    });
    return result;
  }

  static Stream<String> listenConsentStatus(String consentHandle) {
    final snapshots =
        _instance.collection('consents').doc(consentHandle).snapshots();
    return snapshots.map<String>((event) => event.get('status').toString());
  }

  static Future<void> addConsent(String uid, Consent consent) async {
    await _instance
        .collection('consents')
        .doc(consent.encryptedConsent!.consentHandle)
        .set({
      ...consent.toJosn(),
      'status': 'PENDING',
      'expiryDate': '',
      'uid': uid
    });
    await _instance
        .collection('users')
        .doc(uid)
        .collection('consents')
        .doc(consent.encryptedConsent!.consentHandle)
        .set({...consent.toJosn(), 'expiryDate': consent.expiryDate});
  }

  static Future<void> deleteConsent(String uid, String consentHandle) async {
    await _instance.collection('consents').doc(consentHandle).delete();
    await _instance
        .collection('users')
        .doc(uid)
        .collection('consents')
        .doc(consentHandle)
        .delete();
  }
}

final consentsProvider = StateNotifierProvider<ConsentsNotifier, List<Consent>>(
    (ref) => ConsentsNotifier());
