import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/models/user_model.dart';
import 'package:simplfi/services/firestore/firestore_services.dart';

class UserNotifier extends StateNotifier<UserDetails?> {
  UserNotifier() : super(null);
  Future<void> syncUser(String uid) async {
    await FirestoreServices.fetchUser(uid).then((details) {
      state = details;
    });
  }
}
