import 'package:simplfi/models/finvu/consent_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsentsRepo {
  final _instance = FirebaseFirestore.instance;
  Future<List<Consent>> getAllConsents(String uid) async {
    final result = <Consent>[];
    await _instance
        .collection('users')
        .doc(uid)
        .collection('cosents')
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

  Future<void> addConsent(String uid, Consent consent) async {
    await _instance
        .collection('users')
        .doc(uid)
        .collection('consents')
        .doc(consent.encryptedConsent!.consentHandle)
        .set({...consent.toJosn(), 'expiryDate': consent.expiryDate});
  }

  Future<void> deleteConsent(String uid, String consentId) async {
    await _instance
        .collection('users')
        .doc(uid)
        .collection('consents')
        .doc(consentId)
        .delete();
  }
}
