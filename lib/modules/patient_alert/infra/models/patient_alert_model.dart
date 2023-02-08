import 'dart:convert';

import 'package:medicinadireta/modules/patient_alert/domain/entity/patient_alert_entity.dart';

PatientAlertModel patientAlertFromMap(String str) => PatientAlertModel.fromMap(json.decode(str));

String patientAlertToMap(PatientAlertModel data) => json.encode(data.toMap());

class PatientAlertModel extends PatientAlertEntity {
  const PatientAlertModel({
    super.descricao,
    super.alergia,
    super.usuarioId,
    super.usuarioNome,
    super.conselho,
    super.conselhoUf,
    super.conselhoNumero,
    super.dataEvento,
    super.registroId,
    super.avisoTipo,
    super.soap,
    super.pacienteId,
    super.ativado,
    super.editavel,
    super.principioAtivo,
    super.id,
    super.cor,
  });

  PatientAlertModel copyWith({
    int? id,
    int? usuarioId,
    int? conselhoNumero,
    int? registroId,
    int? pacienteId,
    String? avisoTipo,
    String? descricao,
    String? alergia,
    String? usuarioNome,
    String? conselhoUf,
    String? principioAtivo,
    String? dataEvento,
    String? conselho,
    String? soap,
    String? ativado,
    String? editavel,
  }) =>
      PatientAlertModel(
        descricao: descricao ?? descricao,
        alergia: alergia ?? alergia,
        usuarioId: usuarioId ?? usuarioId,
        principioAtivo: principioAtivo ?? principioAtivo,
        usuarioNome: usuarioNome ?? usuarioNome,
        conselho: conselho ?? conselho,
        conselhoUf: conselhoUf ?? conselhoUf,
        conselhoNumero: conselhoNumero ?? conselhoNumero,
        dataEvento: dataEvento ?? dataEvento,
        registroId: registroId ?? registroId,
        avisoTipo: avisoTipo ?? avisoTipo,
        soap: soap ?? soap,
        pacienteId: pacienteId ?? pacienteId,
        ativado: ativado ?? ativado,
        editavel: editavel ?? editavel,
        id: id ?? id,
      );

  factory PatientAlertModel.fromMap(Map<String, dynamic> json) => PatientAlertModel(
        descricao: json["descricao"],
        alergia: json["alergia"],
        usuarioId: json["usuarioId"],
        usuarioNome: json["usuarioNome"],
        conselho: json["conselho"],
        conselhoUf: json["conselhoUf"],
        principioAtivo: json["principioAtivo"],
        conselhoNumero: json["conselhoNumero"],
        dataEvento: json["dataEvento"],
        registroId: json["registroId"],
        avisoTipo: json["avisoTipo"],
        soap: json["soap"],
        pacienteId: json["pacienteId"],
        ativado: json["ativado"],
        editavel: json["editavel"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "descricao": descricao,
        "alergia": alergia,
        "principioAtivo": principioAtivo,
        "usuarioId": usuarioId,
        "usuarioNome": usuarioNome,
        "conselho": conselho,
        "conselhoUf": conselhoUf,
        "conselhoNumero": conselhoNumero,
        "dataEvento": dataEvento,
        "registroId": registroId,
        "avisoTipo": avisoTipo,
        "soap": soap,
        "pacienteId": pacienteId,
        "ativado": ativado,
        "editavel": editavel,
        "id": id,
      };
}
