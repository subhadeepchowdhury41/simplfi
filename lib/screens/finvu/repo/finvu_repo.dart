import 'package:simplfi/services/rest/rest_client.dart';

class FinVuRepo {
  static const _baseUrl =
      'https://dhanaprayoga.fiu.finfactor.in/finsense/API/V1';
  Future<String?> getAccessToken(
      {required String rid, required String ts}) async {
    await RestClient.sendPostReq('$_baseUrl/USer/Login', body: {
      'header': {'rid': rid, 'ts': ts, 'channelId': 'finsense'},
      'body': {'userId': 'channel@dhanaprayoga', 'password': '7777'}
    }).then((resposne) {
      if (resposne == null) {
        throw Exception(['Error getting token']);
      }
      return resposne['body']['token'];
    }).catchError((err) {
      throw err;
    });
    return null;
  }

  Future<String?> sendConsentRequest(
      {required String rid, required String ts}) async {
    const token = '';
    await RestClient.sendPostReq('$_baseUrl/User/Login', body: {
      'header': {'rid': rid, 'ts': ts, 'channelId': 'finsense'},
      'body': {'userId': 'channel@dhanaprayoga', 'password': '7777'}
    }, extraHeaders: {
      'Authorization': 'Bearer: $token'
    }).then((resposne) {
      if (resposne == null) {
        throw Exception(['Error sending request']);
      }
      return resposne['body']['token'];
    }).catchError((err) {
      throw err;
    });
    return null;
  }
}
