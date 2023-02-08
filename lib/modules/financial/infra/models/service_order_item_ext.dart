import 'package:medicinadireta/modules/financial/domain/entities/service_order_item.dart';

class ServiceOrderItemExt extends ServiceOrderItem {
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

// {id: 3692698, orcamentoId: 2541206, productId: 13900, quantidade: 1, valorUnidade: 400.0, desconto: 0.0, total: 400.0, acrescimo: 0.0, comissaoProduto: 0, valorProfissional: 0, dataRealizacao: 0001-01-01T00:00:00Z}

  ServiceOrderItemExt({
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

  ServiceOrderItemExt copyWith({
   int? id,
   int? orcamentoId,
   int? productId,
   int? quantidade,
   double? valorUnidade,
   double? desconto,
   double? total,
   double? acrescimo,
   dynamic comissaoProduto,
   dynamic valorProfissional,
   DateTime? dataRealizacao,
  }) =>
      ServiceOrderItemExt(
        id: id ?? this.id,
        orcamentoId: orcamentoId ?? this.orcamentoId,
        productId: productId ?? this.productId,
        quantidade: quantidade ?? this.quantidade,
        valorUnidade: valorUnidade ?? this.valorUnidade,
        desconto: desconto ?? this.desconto,
        total: total ?? this.total,
        acrescimo: acrescimo ?? this.acrescimo,
        comissaoProduto: comissaoProduto ?? this.comissaoProduto,
        valorProfissional: valorProfissional ?? this.valorProfissional,
        dataRealizacao: dataRealizacao ?? this.dataRealizacao,
      );

  factory ServiceOrderItemExt.fromMap(Map<String, dynamic> json) => ServiceOrderItemExt(
    id: json["id"],
    orcamentoId: json["orcamentoId"],
    productId: json["productId"],
    quantidade: json["quantidade"],
    valorUnidade: json["valorUnidade"],
    desconto: json["desconto"],
    total: json["total"],
    acrescimo: json["acrescimo"],
    comissaoProduto: json["comissaoProduto"],
    valorProfissional: json["valorProfissional"],
    dataRealizacao: json["dataRealizacao"] != null ? DateTime.parse(json["dataRealizacao"]) : null,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "orcamentoId": orcamentoId,
    "productId": productId,
    "quantidade": quantidade,
    "valorUnidade": valorUnidade,
    "desconto": desconto,
    "total": total,
    "acrescimo": acrescimo,
    "comissaoProduto": comissaoProduto,
    "valorProfissional": valorProfissional,
    "dataRealizacao": dataRealizacao!.toIso8601String(),
  };
}
