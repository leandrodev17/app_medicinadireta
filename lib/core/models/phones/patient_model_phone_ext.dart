
import 'package:medicinadireta/core/models/phones/patient_model_phone.dart';

class PatientModelPhoneExt extends PatientModelPhone {
  String formatted({bool withDDI = true}) {
    String result = '';
    if (withDDI && ddi != null && ddi!.isNotEmpty) {
      result += '+$ddi ';
    }

    if (ddd != null && ddd!.isNotEmpty) {
      result += '($ddd) ';
    }

    if (numero != null && numero!.isNotEmpty) {
      result += '$numero';
    }

    return result;
  }

  final int? pacienteId;
  final DateTime? data;
  final String? tipo;
  final String? codTipo;
  final String? operadora;
  final String? ddi;
  final String? ddd;
  final String? numero;
  final String? ramal;
  final String? receberSms;
  final String? observacao;
  final String? ativado;
  PatientModelPhoneExt({
    this.pacienteId,
    this.data,
    this.tipo,
    this.codTipo,
    this.operadora,
    this.ddi,
    this.ddd,
    this.numero,
    this.ramal,
    this.receberSms,
    this.observacao,
    this.ativado,
  });

  PatientModelPhoneExt copyWith({
    int? pacienteId,
    DateTime? data,
    String? tipo,
    String? codTipo,
    String? operadora,
    String? ddi,
    String? ddd,
    String? numero,
    String? ramal,
    String? receberSms,
    String? observacao,
    String? ativado,
  }) =>
      PatientModelPhoneExt(
        pacienteId: pacienteId ?? this.pacienteId,
        data: data ?? this.data,
        tipo: tipo ?? this.tipo,
        codTipo: codTipo ?? this.codTipo,
        operadora: operadora ?? this.operadora,
        ddi: ddi ?? this.ddi,
        ddd: ddd ?? this.ddd,
        numero: numero ?? this.numero,
        ramal: ramal ?? this.ramal,
        receberSms: receberSms ?? this.receberSms,
        observacao: observacao ?? this.observacao,
        ativado: ativado ?? this.ativado,
      );

  factory PatientModelPhoneExt.fromMap(Map<String, dynamic> json) => PatientModelPhoneExt(
        pacienteId: json["pacienteId"],
        data: json["data"] != null ? DateTime.parse(json["data"]) : null,
        tipo: json["tipo"],
        codTipo: json["codTipo"],
        operadora: json["operadora"],
        ddi: json["ddi"],
        ddd: json["ddd"],
        numero: json["numero"],
        ramal: json["ramal"],
        receberSms: json["receberSms"],
        observacao: json["observacao"],
        ativado: json["ativado"],
      );

  Map<String, dynamic> toMap() => {
        "pacienteId": pacienteId,
        "data": data?.toIso8601String() ?? null,
        "tipo": tipo,
        "codTipo": codTipo,
        "operadora": operadora,
        "ddi": ddi,
        "ddd": ddd,
        "numero": numero,
        "ramal": ramal,
        "receberSms": receberSms,
        "observacao": observacao,
        "ativado": ativado,
      };
}
