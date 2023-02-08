import 'package:medicinadireta/modules/modules_helpers/domain/entities/model_to_sms.dart';

class ModelToSmsExt extends ModelToSms {
  final int? codModeloSms;
  final String? assuntoModeloSms;
  final int? id;
  ModelToSmsExt({this.codModeloSms, this.assuntoModeloSms, this.id});

  ModelToSmsExt copyWith({
    int? codModeloSms,
    String? assuntoModeloSms,
    int? id,
  }) =>
      ModelToSmsExt(
        codModeloSms: codModeloSms ?? this.codModeloSms,
        assuntoModeloSms: assuntoModeloSms ?? this.assuntoModeloSms,
        id: id ?? this.id,
      );

  factory ModelToSmsExt.fromMap(Map<String, dynamic> json) => ModelToSmsExt(
        codModeloSms: json["codModeloSms"],
        assuntoModeloSms: json["assuntoModeloSms"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "codModeloSms": codModeloSms,
        "assuntoModeloSms": assuntoModeloSms,
        "id": id,
      };
}
