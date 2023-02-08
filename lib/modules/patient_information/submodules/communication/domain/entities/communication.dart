import 'package:equatable/equatable.dart';

class Communication extends Equatable {
  final String? odataContext;
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
  Communication({
    this.odataContext,
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

  @override
  List<Object?> get props => [
        odataContext,
        id,
        assunto,
        remetenteId,
        destinatarioId,
        emailPaciente,
        guardar,
        status,
        conteudoMensagem,
        dataCriacao,
        dataEnvio,
        horaEnvio,
        horaCriacao,
        dataProcesamento,
      ];
}
