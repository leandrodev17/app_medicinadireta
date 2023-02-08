import 'package:equatable/equatable.dart';

class PatientProductsOrderNewEvolution extends Equatable {
  final int? id;
  final int? pacienteId;
  final int? organizacaoId;
  final int? sequencia;
  final int? statusId;
  final DateTime? orcamentoData;
  final double? total;
  final int? pago;
  final int? saldo;
  final int? credito;
  final int? usuarioCadastroId;
  final String? fechado;
  final String? validade;
  final int? formaPagamentoId;
  final int? numeroParcelas;
  final int? valorParcela;
  final int? usuarioAprovacaoId;
  final DateTime? dataAprovacao;

  PatientProductsOrderNewEvolution({
    this.id,
    this.pacienteId,
    this.organizacaoId,
    this.sequencia,
    this.statusId,
    this.orcamentoData,
    this.total,
    this.pago,
    this.saldo,
    this.credito,
    this.usuarioCadastroId,
    this.fechado,
    this.validade,
    this.formaPagamentoId,
    this.numeroParcelas,
    this.valorParcela,
    this.usuarioAprovacaoId,
    this.dataAprovacao,
  });

  @override
  List<Object?> get props => [
        id,
        pacienteId,
        organizacaoId,
        sequencia,
        statusId,
        orcamentoData,
        total,
        pago,
        saldo,
        credito,
        usuarioCadastroId,
        fechado,
        validade,
        formaPagamentoId,
        numeroParcelas,
        valorParcela,
        usuarioAprovacaoId,
        dataAprovacao,
      ];
}
