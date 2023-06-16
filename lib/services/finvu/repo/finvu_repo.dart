import 'package:intl/intl.dart';
import 'package:simplfi/models/app_tokens.dart';
import 'package:simplfi/models/finvu/consent_model.dart';
import 'package:simplfi/models/finvu/finvu_req_model.dart';
import 'package:simplfi/models/finvu/fip_model.dart';
import 'package:simplfi/services/hive_db/boxes.dart';
import 'package:simplfi/services/rest/rest_client.dart';

class FinVuRepo {
  static const _baseUrl =
      'https://dhanaprayoga.fiu.finfactor.in/finsense/API/V1';
  static final _tokensBox = Boxes.getAppTokenBox();
  static Future<String?> getAccessToken() async {
    await RestClient.sendPostReq('$_baseUrl/User/Login', body: {
      'header': FinVuReqHeader().getHeader(),
      'body': {'userId': 'channel@dhanaprayoga', 'password': '7777'}
    }).then((resposne) async {
      if (resposne == null) {
        throw Exception(['Error getting token']);
      }
      String token = resposne['body']['token'];
      await _tokensBox.put('finVuToken', AppTokens(finVuToken: token));
      return token;
    }).catchError((err) {
      throw err;
    });
    return null;
  }

  static Future<EncryptedConsent?> sendConsentRequest(
      {required String email,
      required String redirectUrl,
      required String userSessionId}) async {
    final token = _tokensBox.get('finVuToken')!.finVuToken;
    EncryptedConsent? result;
    await RestClient.sendPostReq('$_baseUrl/ConsentRequestEncrypt', body: {
      'header': FinVuReqHeader().getHeader(),
      'body': {
        // "custId": "${email.split('@')[0]}@finvu",
        "custId": "8768715527@finvu",
        "consentDescription": "Wealth Management Service",
        "templateName": "FINVUDEMO_TESTING",
        "userSessionId": userSessionId,
        "redirectUrl": redirectUrl
      }
    }, extraHeaders: {
      'Authorization': 'Bearer: $token'
    }).then((resposne) {
      if (resposne == null) {
        return result;
      }
      result = EncryptedConsent.fromJson(resposne['body']);
    }).catchError((err) {
      throw err;
    });
    return result;
  }

  static Future<Consent?> checkConsentStatus(
      {required String consentHandle,
      required String custId,
      required Consent consent}) async {
    Consent? result;
    final token = _tokensBox.get('finVuToken')!.finVuToken;
    await RestClient.sendGetReq(
        '$_baseUrl/ConsentStatus/$consentHandle/$custId',
        extraHeaders: {'Authorization': 'Bearer: $token'}).then((res) {
      if (res == null) {
        return result;
      }
      ConsentStatus status;
      switch (res['body']['consentStatus']) {
        case 'REQUESTED':
          status = ConsentStatus.requested;
          break;
        case 'FAILED':
          status = ConsentStatus.failed;
          break;
        case 'ACCEPTED':
          status = ConsentStatus.accepted;
          break;
        case 'REJECTED':
          status = ConsentStatus.requested;
          break;
        default:
          status = ConsentStatus.failed;
      }
      result = consent.copyWith(status: status, id: res['body']['consentId']);
    });
    return result;
  }

  static Future<Map<String, dynamic>?> getConsentDetails(
      {required String consentId}) async {
    Map<String, dynamic>? result;
    await RestClient.sendGetReq('$_baseUrl/Consent/$consentId').then((consent) {
      if (consent == null) {
        return result;
      }
      result = consent;
    });
    return result;
  }

  static Future<Map<String, dynamic>?> sendFIRequest(
      {required Consent consent, required String email}) async {
    final token = _tokensBox.get('finVuToken')!.finVuToken;
    Map<String, dynamic>? result;
    final now = DateTime.now();
    final ts = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").format(now);
    await RestClient.sendPostReq('$_baseUrl/FIRequest', body: {
      'headers': FinVuReqHeader().getHeader(),
      'body': {
        'custId': '${email.split('@')[0]}@finvu',
        'consentHandleId': consent.encryptedConsent!.consentHandle,
        'consentId': consent.id,
        'dateTimeRangeFrom': ts,
        'dateTimeRangeTo': DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ")
            .format(DateTime.now().add(const Duration(days: 30)))
      }
    }, extraHeaders: {
      'Authorization': 'Bearer: $token'
    }).then((req) {
      if (req == null) {
        return result;
      }
      result = req;
    });
    return result;
  }

  static Future<Map<String, dynamic>?> getFIStatus(
      {required Consent consent, required String email}) async {
    final token = _tokensBox.get('finVuToken')!.finVuToken;
    Map<String, dynamic>? result;
    await RestClient.sendGetReq('$_baseUrl/FIRequest',
        extraHeaders: {'Authorization': 'Bearer: $token'}).then((req) {
      if (req == null) {
        return result;
      }
      result = req;
    });
    return result;
  }

  static Future<Map<String, dynamic>?> getFIData(
      {required Consent consent, required String email}) async {
    final token = _tokensBox.get('finVuToken')!.finVuToken;
    Map<String, dynamic>? result;
    await RestClient.sendGetReq('$_baseUrl/FIRequest',
        extraHeaders: {'Authorization': 'Bearer: $token'}).then((req) {
      if (req == null) {
        return result;
      }
      result = req;
    });
    return result;
  }

  static Future<List<FIP>> getAllFIPs() async {
    List<FIP> result = [];
    final token = _tokensBox.get('finVuToken')!.finVuToken;
    await RestClient.sendGetReq('$_baseUrl/fips/',
        extraHeaders: {'Authorization': 'Bearer: $token'}).then((resposne) {
      if (resposne == null) {
        throw Exception(['Error getting fips']);
      }
      final List<dynamic> fipList = resposne['body'];
      for (var fip in fipList) {
        result.add(FIP.fromJson(fip));
      }
      return result;
    }).catchError((err) {
      throw err;
    });
    return result;
  }
}
