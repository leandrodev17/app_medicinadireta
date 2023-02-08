import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/communication_sms.dart';

class ComunicationSmsExt extends ComunicationSms {
  final String? odataContext;
  final int? id;
  final String? assunto;
  final int? smsDe;
  final String? smsPara;
  final String? status;
  final String? mensagem;
  final String? sendRef;
  final String? idFilial;
  final String? smsPaciente;
  final String? guardar;
  final String? dataEnvio;
  final String? horaEnvio;
  final String? dataCriacao;
  final String? horaCriacao;
  final String? usuarioCriacao;
  final String? dataProcessamento;
  final String? msgErro;
  final String? statusCode;
  final String? detailCode;
  final String? idAgenda;
  final String? idCampanha;

  ComunicationSmsExt({
    this.odataContext,
    this.id,
    this.assunto,
    this.smsDe,
    this.smsPara,
    this.status,
    this.mensagem,
    this.sendRef,
    this.idFilial,
    this.smsPaciente,
    this.guardar,
    this.dataEnvio,
    this.horaEnvio,
    this.dataCriacao,
    this.horaCriacao,
    this.usuarioCriacao,
    this.dataProcessamento,
    this.msgErro,
    this.statusCode,
    this.detailCode,
    this.idAgenda,
    this.idCampanha,
  });

  ComunicationSmsExt copyWith({
    String? odataContext,
    int? id,
    String? assunto,
    int? smsDe,
    String? smsPara,
    String? status,
    String? mensagem,
    String? sendRef,
    String? idFilial,
    String? smsPaciente,
    String? guardar,
    String? dataEnvio,
    String? horaEnvio,
    String? dataCriacao,
    String? horaCriacao,
    String? usuarioCriacao,
    String? dataProcessamento,
    String? msgErro,
    String? statusCode,
    String? detailCode,
    String? idAgenda,
    String? idCampanha,
  }) =>
      ComunicationSmsExt(
        odataContext: odataContext ?? this.odataContext,
        id: id ?? this.id,
        assunto: assunto ?? this.assunto,
        smsDe: smsDe ?? this.smsDe,
        smsPara: smsPara ?? this.smsPara,
        status: status ?? this.status,
        mensagem: mensagem ?? this.mensagem,
        sendRef: sendRef ?? this.sendRef,
        idFilial: idFilial ?? this.idFilial,
        smsPaciente: smsPaciente ?? this.smsPaciente,
        guardar: guardar ?? this.guardar,
        dataEnvio: dataEnvio ?? this.dataEnvio,
        horaEnvio: horaEnvio ?? this.horaEnvio,
        dataCriacao: dataCriacao ?? this.dataCriacao,
        horaCriacao: horaCriacao ?? this.horaCriacao,
        usuarioCriacao: usuarioCriacao ?? this.usuarioCriacao,
        dataProcessamento: dataProcessamento ?? this.dataProcessamento,
        msgErro: msgErro ?? this.msgErro,
        statusCode: statusCode ?? this.statusCode,
        detailCode: detailCode ?? this.detailCode,
        idAgenda: idAgenda ?? this.idAgenda,
        idCampanha: idCampanha ?? this.idCampanha,
      );

  factory ComunicationSmsExt.fromMap(Map<String, dynamic> json) => ComunicationSmsExt(
        odataContext: json["@odata.context"],
        id: json["id"],
        assunto: json["assunto"],
        smsDe: json["smsDe"],
        smsPara: json["smsPara"],
        status: json["status"],
        mensagem: json["mensagem"],
        sendRef: json["sendRef"],
        idFilial: json["idFilial"],
        smsPaciente: json["smsPaciente"],
        guardar: json["guardar"],
        dataEnvio: json["dataEnvio"],
        horaEnvio: json["horaEnvio"],
        dataCriacao: json["dataCriacao"],
        horaCriacao: json["horaCriacao"],
        usuarioCriacao: json["usuarioCriacao"],
        dataProcessamento: json["dataProcessamento"],
        msgErro: json["msgErro"],
        statusCode: json["statusCode"],
        detailCode: json["detailCode"],
        idAgenda: json["idAgenda"],
        idCampanha: json["idCampanha"],
      );

  Map<String, dynamic> toMap() => {
        "@odata.context": odataContext,
        "id": id,
        "assunto": assunto,
        "smsDe": smsDe,
        "smsPara": smsPara,
        "status": status,
        "mensagem": mensagem,
        "sendRef": sendRef,
        "idFilial": idFilial,
        "smsPaciente": smsPaciente,
        "guardar": guardar,
        "dataEnvio": dataEnvio,
        "horaEnvio": horaEnvio,
        "dataCriacao": dataCriacao,
        "horaCriacao": horaCriacao,
        "usuarioCriacao": usuarioCriacao,
        "dataProcessamento": dataProcessamento,
        "msgErro": msgErro,
        "statusCode": statusCode,
        "detailCode": detailCode,
        "idAgenda": idAgenda,
        "idCampanha": idCampanha,
      };
}
