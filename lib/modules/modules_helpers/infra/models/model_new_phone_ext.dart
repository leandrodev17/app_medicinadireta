import 'package:medicinadireta/modules/modules_helpers/domain/entities/model_new_phone.dart';

class ModelNewPhoneExt extends ModelNewPhone {
  final int? pacienteId;
  final String? data;
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

  ModelNewPhoneExt({
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

  ModelNewPhoneExt copyWith({
    int? pacienteId,
    String? data,
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
      ModelNewPhoneExt(
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

  factory ModelNewPhoneExt.fromMap(Map<String, dynamic> json) => ModelNewPhoneExt(
        pacienteId: json["pacienteId"],
        data: json["data"],
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
        "data": data,
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
