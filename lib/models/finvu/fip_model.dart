class FIP {
  final String fipId;
  final String fipName;
  final String? code;
  final String enable;
  final List<String> fiTypes;
  final String? entityIconUri;
  final String? entityLogoUri;
  final String? entityLogoWithNameUri;
  final int? otpLength;

  FIP({
    required this.fipId,
    required this.fipName,
    this.code,
    required this.enable,
    required this.fiTypes,
    this.entityIconUri,
    this.entityLogoUri,
    this.entityLogoWithNameUri,
    this.otpLength,
  });

  factory FIP.fromJson(Map<String, dynamic> json) {
    return FIP(
      fipId: json['fipId'],
      fipName: json['fipName'],
      code: json['code'],
      enable: json['enable'],
      fiTypes: List<String>.from(json['fiTypes'].map((x) => x)),
      entityIconUri: json['entityIconUri'],
      entityLogoUri: json['entityLogoUri'],
      entityLogoWithNameUri: json['entityLogoWithNameUri'],
      otpLength: json['otpLength'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fipId': fipId,
      'fipName': fipName,
      'code': code,
      'enable': enable,
      'fiTypes': List<dynamic>.from(fiTypes.map((x) => x)),
      'entityIconUri': entityIconUri,
      'entityLogoUri': entityLogoUri,
      'entityLogoWithNameUri': entityLogoWithNameUri,
      'otpLength': otpLength,
    };
  }
}