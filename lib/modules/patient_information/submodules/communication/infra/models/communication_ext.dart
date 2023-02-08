import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/communication.dart';

class CommunicationExt extends Communication {
  final int? id;
  final String? assunto;
  final String? remetenteId;
  final int? destinatarioId;
  final String? emailPaciente;
  final String? guardar;
  final String? status;
  final String? conteudoMensagem;
  final String? dataCriacao;
  final String? dataEnvio;
  final String? horaEnvio;
  final String? horaCriacao;
  final String? dataProcesamento;
  CommunicationExt({
    this.id,
    this.assunto,
    this.remetenteId,
    this.destinatarioId,
    this.emailPaciente,
    this.guardar,
    this.status,
    this.conteudoMensagem,
    this.dataCriacao,
    this.dataEnvio,
    this.horaEnvio,
    this.horaCriacao,
    this.dataProcesamento,
  });

  CommunicationExt copyWith({
    int? id,
    String? assunto,
    dynamic remetenteId,
    int? destinatarioId,
    String? emailPaciente,
    String? guardar,
    String? status,
    String? conteudoMensagem,
    String? dataCriacao,
    String? dataEnvio,
    String? horaEnvio,
    String? horaCriacao,
    String? dataProcesamento,
  }) =>
      CommunicationExt(
        id: id ?? this.id,
        assunto: assunto ?? this.assunto,
        remetenteId: remetenteId ?? this.remetenteId,
        destinatarioId: destinatarioId ?? this.destinatarioId,
        emailPaciente: emailPaciente ?? this.emailPaciente,
        guardar: guardar ?? this.guardar,
        status: status ?? this.status,
        conteudoMensagem: conteudoMensagem ?? this.conteudoMensagem,
        dataCriacao: dataCriacao ?? this.dataCriacao,
        dataEnvio: dataEnvio ?? this.dataEnvio,
        horaEnvio: horaEnvio ?? this.horaEnvio,
        horaCriacao: horaCriacao ?? this.horaCriacao,
        dataProcesamento: dataProcesamento ?? this.dataProcesamento,
      );

  factory CommunicationExt.fromMap(Map<String, dynamic> json) => CommunicationExt(
        id: json["id"],
        assunto: json["assunto"],
        remetenteId: json["remetenteId"],
        destinatarioId: json["destinatarioId"],
        emailPaciente: json["emailPaciente"],
        guardar: json["guardar"],
        status: json["status"],
        conteudoMensagem: json["conteudoMensagem"],
        dataCriacao: json["dataCriacao"],
        dataEnvio: json["dataEnvio"],
        horaEnvio: json["horaEnvio"],
        horaCriacao: json["horaCriacao"],
        dataProcesamento: json["dataProcesamento"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "assunto": assunto,
        "remetenteId": remetenteId,
        "destinatarioId": destinatarioId,
        "emailPaciente": emailPaciente,
        "guardar": guardar,
        "status": status,
        "conteudoMensagem": conteudoMensagem,
        "dataCriacao": dataCriacao,
        "dataEnvio": dataEnvio,
        "horaEnvio": horaEnvio,
        "horaCriacao": horaCriacao,
        "dataProcesamento": dataProcesamento,
      };
}
