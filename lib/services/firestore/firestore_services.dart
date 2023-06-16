import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simplfi/models/user_model.dart';

class FirestoreServices {
  static final _instance = FirebaseFirestore.instance;
  static Future<UserDetails?> fetchUser(String uid) async {
    UserDetails? details;
    await _instance.collection('users').doc(uid).get().then((user) {
      if (user.data() == null) {
        return details;
      }
      details = UserDetails.fromJson(user.data()!);
    });
    return details;
  }
}
