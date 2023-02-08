
import 'package:medicinadireta/modules/financial/domain/entities/service_order_item.dart';
import 'package:medicinadireta/modules/financial/domain/entities/service_order_status.dart';
import 'package:equatable/equatable.dart';

class ServiceOrder extends Equatable {
  final int? id;
  final int? pacienteId;
  final int? organizacaoId;
  final int? sequencia;
  final int? statusId;
  final DateTime? orcamentoData;
  final double? total;
  final double? pago;
  final double? saldo;
  final double? credito;
  final int? usuarioCadastroId;
  final String? fechado;
  final String? validade;
  final int? formaPagamentoId;
  final int? numeroParcelas;
  final double? valorParcela;
  final int? usuarioAprovacaoId;
  final DateTime? dataAprovacao;
  final ServiceOrderStatus? status;
  final List<ServiceOrderItem>? itens;
  ServiceOrder({
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
    this.status,
    this.itens,
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
    status,
    itens,
  ];

}


