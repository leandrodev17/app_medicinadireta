import 'package:equatable/equatable.dart';

class ServiceOrderItem extends Equatable {
  final int? id;
  final int? orcamentoId;
  final int? productId;
  final int? quantidade;
  final double? valorUnidade;
  final double? desconto;
  final double? total;
  final double? acrescimo;
  final dynamic comissaoProduto;
  final dynamic valorProfissional;
  final DateTime? dataRealizacao;
  ServiceOrderItem({
    this.id,
    this.orcamentoId,
    this.productId,
    this.quantidade,
    this.valorUnidade,
    this.desconto,
    this.total,
    this.acrescimo,
    this.comissaoProduto,
    this.valorProfissional,
    this.dataRealizacao,
  });

  @override
  List<Object?> get props => [
    id,
    orcamentoId,
    productId,
    quantidade,
    valorUnidade,
    desconto,
    total,
    acrescimo,
    comissaoProduto,
    valorProfissional,
    dataRealizacao,
  ];

}