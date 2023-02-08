import 'package:medicinadireta/modules/authentication/domain/entities/authetication_access.dart';

class ResponseAuthenticationAccess extends AutheticationAccess {
  final String? aplicativo;
  final String? platform;
  final String? privateAccess;
  final String? privateInsert;
  final String? privateDelete;
  final String? privateUpdate;
  final String? privateExport;
  final String? privatePrint;
  
  ResponseAuthenticationAccess({
    this.aplicativo,
    this.platform,
    this.privateAccess,
    this.privateInsert,
    this.privateDelete,
    this.privateUpdate,
    this.privateExport,
    this.privatePrint,
  });

  factory ResponseAuthenticationAccess.fromMap(Map<String, dynamic> json) => ResponseAuthenticationAccess(
        aplicativo: json["aplicativo"],
        platform: json["platform"],
        privateAccess: json["privateAccess"],
        privateInsert: json["privateInsert"],
        privateDelete: json["privateDelete"],
        privateUpdate: json["privateUpdate"],
        privateExport: json["privateExport"],
        privatePrint: json["privatePrint"],
      );

  Map<String, dynamic> toMap() => {
        "aplicativo": aplicativo,
        "platform": platform,
        "privateAccess": privateAccess,
        "privateInsert": privateInsert,
        "privateDelete": privateDelete,
        "privateUpdate": privateUpdate,
        "privateExport": privateExport,
        "privatePrint": privatePrint,
      };
}
