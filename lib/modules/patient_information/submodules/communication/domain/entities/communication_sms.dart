import 'package:equatable/equatable.dart';

class ComunicationSms extends Equatable {
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

  ComunicationSms({
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

  @override
  List<Object?> get props => [
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
      ];
}
