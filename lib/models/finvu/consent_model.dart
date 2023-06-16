enum ConsentStatus { requested, failed, accepted, rejected }

class EncryptedConsent {
  String? encryptedRequest;
  String? requestDate;
  String? encryptedFiuId;
  String? consentHandle;

  EncryptedConsent(
      {this.encryptedRequest,
      this.requestDate,
      this.encryptedFiuId,
      this.consentHandle});

  factory EncryptedConsent.fromJson(Map<String, dynamic> json) {
    return EncryptedConsent(
        encryptedRequest: json['encryptedRequest'],
        requestDate: json['requestDate'],
        encryptedFiuId: json['encryptedFiuId'],
        consentHandle: json['consentHandle']);
  }
}

class Consent {
  EncryptedConsent? encryptedConsent;
  DateTime? expiryDate;
  ConsentStatus? status;
  String? id;
  Consent({this.encryptedConsent, this.id, this.expiryDate, this.status});

  Consent copyWith(
          {EncryptedConsent? encryptedConsent,
          String? id,
          ConsentStatus? status,
          DateTime? expiryDate}) =>
      Consent(
          encryptedConsent: encryptedConsent ?? this.encryptedConsent,
          id: id ?? this.id,
          status: status ?? this.status,
          expiryDate: expiryDate ?? this.expiryDate);

  Map<String, dynamic> toJosn() => {
        'id': id,
        'encryptedRequest': encryptedConsent!.encryptedRequest,
        'requestDate': encryptedConsent!.requestDate,
        'encryptedFiuId': encryptedConsent!.encryptedFiuId,
        'consentHandle': encryptedConsent!.consentHandle,
        'expiryDate': expiryDate
      };
}
