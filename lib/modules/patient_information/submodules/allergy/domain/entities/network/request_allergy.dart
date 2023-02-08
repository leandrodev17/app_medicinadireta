import 'package:equatable/equatable.dart';

class RequestAllergy extends Equatable {
  final int? origem;
  final int? tipo;
  final int? status;
  final int? severidade;
  final int? medicamentoId;
  final String? dataEvento;
  final String? utcEvento;
  final String? confirmacao;
  final String? classificacaoReacao;
  final String? fonteMedicamento;
  final String? medicamento;
  final String? principioAtivo;
  final String? formaFarmaceutica;
  final String? viaAdministracao;
  final String? descricao;
  final String? reacao;
  final String? dataTipo;
  final String? dataInicioOcorrido;
  final String? dataFimOcorrido;
  final String? editavel;

  const RequestAllergy({
    this.dataEvento,
    this.utcEvento,
    this.origem,
    this.tipo,
    this.status,
    this.severidade,
    this.confirmacao,
    this.classificacaoReacao,
    this.fonteMedicamento,
    this.medicamentoId,
    this.medicamento,
    this.principioAtivo,
    this.formaFarmaceutica,
    this.viaAdministracao,
    this.descricao,
    this.reacao,
    this.dataTipo,
    this.dataInicioOcorrido,
    this.dataFimOcorrido,
    this.editavel,
  });

  @override
  List<Object?> get props => [
        dataEvento,
        utcEvento,
        origem,
        tipo,
        status,
        severidade,
        confirmacao,
        classificacaoReacao,
        fonteMedicamento,
        medicamentoId,
        medicamento,
        principioAtivo,
        formaFarmaceutica,
        viaAdministracao,
        descricao,
        reacao,
        dataTipo,
        dataInicioOcorrido,
        dataFimOcorrido,
        editavel,
      ];
}
