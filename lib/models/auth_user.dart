import 'package:hive/hive.dart';

part 'auth_user.g.dart';

@HiveType(typeId: 1)
class AuthUser {
  @HiveField(0)
  String? uid;

  @HiveField(1)
  String? email;
  AuthUser({this.email, this.uid});
}
