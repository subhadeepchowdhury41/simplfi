import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/models/app_tokens.dart';
import 'package:simplfi/services/finvu/repo/finvu_repo.dart';
// import 'package:simplfi/services/hive_db/boxes.dart';
// import 'package:simplfi/utils/loggs.dart';

class AppTokensNotifier extends StateNotifier<AppTokens?> {
  AppTokensNotifier() : super(null);
  // final _tokensBox = Boxes.getAppTokenBox();
  Future<void> refreshFinVuToken() async {
    // final prevToken = _tokensBox.get('finVuToken');
    // if (prevToken != null) {
    //   logWithColor(message: prevToken.finVuToken);
    //   state = prevToken;
    //   return;
    // }
    await FinVuRepo.getAccessToken().then((token) async {
      if (token == null) {
        return;
      }
      state = AppTokens(finVuToken: token);

    });
  }
}

final tokensProvider = StateNotifierProvider<AppTokensNotifier, AppTokens?>(
    (ref) => AppTokensNotifier());
