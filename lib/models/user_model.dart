class UserDetails {
  String? phone;
  String? fname;
  String? lname;

  UserDetails({this.phone, this.fname, this.lname});

  UserDetails copyWith({String? phone, String? fname, String? lname}) =>
      UserDetails(
          phone: phone ?? this.phone,
          fname: fname ?? this.fname,
          lname: lname ?? this.lname);

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
      phone: json['phone'], fname: json['fname'], lname: json['lname']);
}
