import 'package:hive/hive.dart';
part 'app_tokens.g.dart';

@HiveType(typeId: 10)
class AppTokens {
  @HiveField(0)
  String? finVuToken;

  AppTokens({this.finVuToken});

  AppTokens copyWith({String? finVuToken}) {
    return AppTokens(finVuToken: finVuToken ?? this.finVuToken);
  }
}
