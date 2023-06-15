import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/models/finvu/consent_model.dart';
import 'package:simplfi/screens/consents/repo/consents_repo.dart';

class ConsentsNotifier extends StateNotifier<List<Consent>> {
  ConsentsNotifier() : super([]);
  final consentRepo = ConsentsRepo();
  Future<void> syncConsents(String uid) async {
    await consentRepo.getAllConsents(uid).then((consents) {
      state = consents;
    });
  }

  Future<void> addConsent(String uid, Consent consent) async {
    await consentRepo.addConsent(uid, consent).then((res) {
      state = [...state, consent];
    });
  }

  Future<void> deleteCosent(String uid, String consentId) async {
    await consentRepo.deleteConsent(uid, consentId).then((res) {
      state = state
          .where((consent) =>
              (consent.encryptedConsent!.consentHandle != consentId))
          .toList();
    });
  }
}
