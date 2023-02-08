import 'package:medicinadireta/modules/infor_med/domain/entities/auth_info_med.dart';

class AuthInfoMedExt extends AuthInfoMed {
  final int? userid;
  final String? token;
  final String? origin;

  AuthInfoMedExt({this.userid, this.token, this.origin});

  factory AuthInfoMedExt.fromMap(Map<String, dynamic> json) => AuthInfoMedExt(
        userid: json["userid"],
        token: json["token"],
        origin: json["origin"],
      );

  Map<String, dynamic> toMap() => {
        "userid": userid,
        "token": token,
        "origin": origin,
      };
}
