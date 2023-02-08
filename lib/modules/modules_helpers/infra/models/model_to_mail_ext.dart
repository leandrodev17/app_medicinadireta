import 'package:medicinadireta/modules/modules_helpers/domain/entities/model_to_mail.dart';

class ModelToMailExt extends ModelToMail {
  final int? codModeloEmail;
  final int? id;
  final String? assuntoModeloEmail;
  ModelToMailExt({this.codModeloEmail, this.assuntoModeloEmail, this.id});

  ModelToMailExt copyWith({
    int? codModeloEmail,
    String? assuntoModeloEmail,
    int? id,
  }) =>
      ModelToMailExt(
        codModeloEmail: codModeloEmail ?? this.codModeloEmail,
        assuntoModeloEmail: assuntoModeloEmail ?? this.assuntoModeloEmail,
        id: id ?? this.id,
      );

  factory ModelToMailExt.fromMap(Map<String, dynamic> json) => ModelToMailExt(
        codModeloEmail: json["codModeloEmail"],
        assuntoModeloEmail: json["assuntoModeloEmail"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "codModeloEmail": codModeloEmail,
        "assuntoModeloEmail": assuntoModeloEmail,
        "id": id,
      };
}