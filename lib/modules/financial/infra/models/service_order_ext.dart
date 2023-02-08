import 'package:medicinadireta/modules/financial/domain/entities/service_order.dart';
import 'package:medicinadireta/modules/financial/infra/models/service_order_item_ext.dart';
import 'package:medicinadireta/modules/financial/infra/models/service_order_status_ext.dart';

class ServiceOrderExt extends ServiceOrder{
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
  final ServiceOrderStatusExt? status;
  final List<ServiceOrderItemExt>? itens;
  ServiceOrderExt({
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

  ServiceOrderExt copyWith({
    int? id,
    int? pacienteId,
    int? organizacaoId,
    int? sequencia,
    int? statusId,
    DateTime? orcamentoData,
    double? total,
    double? pago,
    double? saldo,
    double? credito,
    int? usuarioCadastroId,
    String? fechado,
    String? validade,
    int? formaPagamentoId,
    int? numeroParcelas,
    double? valorParcela,
    int? usuarioAprovacaoId,
    DateTime? dataAprovacao,
    ServiceOrderStatusExt? status,
    List<ServiceOrderItemExt>? itens,
  }) =>
      ServiceOrderExt(
        id: id ?? this.id,
        pacienteId: pacienteId ?? this.pacienteId,
        organizacaoId: organizacaoId ?? this.organizacaoId,
        sequencia: sequencia ?? this.sequencia,
        statusId: statusId ?? this.statusId,
        orcamentoData: orcamentoData ?? this.orcamentoData,
        total: total ?? this.total,
        pago: pago ?? this.pago,
        saldo: saldo ?? this.saldo,
        credito: credito ?? this.credito,
        usuarioCadastroId: usuarioCadastroId ?? this.usuarioCadastroId,
        fechado: fechado ?? this.fechado,
        validade: validade ?? this.validade,
        formaPagamentoId: formaPagamentoId ?? this.formaPagamentoId,
        numeroParcelas: numeroParcelas ?? this.numeroParcelas,
        valorParcela: valorParcela ?? this.valorParcela,
        usuarioAprovacaoId: usuarioAprovacaoId ?? this.usuarioAprovacaoId,
        dataAprovacao: dataAprovacao ?? this.dataAprovacao,
        status: status ?? this.status,
        itens: itens ?? this.itens,
      );

  factory ServiceOrderExt.fromMap(Map<String, dynamic> json) => ServiceOrderExt(
    id: json["id"],
    pacienteId: json["pacienteId"],
    organizacaoId: json["organizacaoId"],
    sequencia: json["sequencia"],
    statusId: json["statusId"],
    orcamentoData: json["orcamentoData"] != null ? DateTime.parse(json["orcamentoData"]): null,
    total: json["total"],
    pago: json["pago"],
    saldo: json["saldo"],
    credito: json["credito"],
    usuarioCadastroId: json["usuarioCadastroId"],
    fechado: json["fechado"],
    validade: json["validade"],
    formaPagamentoId: json["formaPagamentoId"],
    numeroParcelas: json["numeroParcelas"],
    valorParcela: json["valorParcela"],
    usuarioAprovacaoId: json["usuarioAprovacaoId"],
    dataAprovacao: json["dataAprovacao"] != null ? DateTime.parse(json["dataAprovacao"]) : null,
    status: json["status"] != null ? ServiceOrderStatusExt.fromMap(json["status"]) : null,
    itens: json["itens"] != null ? List<ServiceOrderItemExt>.from(json["itens"].map((x) => ServiceOrderItemExt.fromMap(x))) : null,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "pacienteId": pacienteId,
    "organizacaoId": organizacaoId,
    "sequencia": sequencia,
    "statusId": statusId,
    "orcamentoData": orcamentoData!.toIso8601String(),
    "total": total,
    "pago": pago,
    "saldo": saldo,
    "credito": credito,
    "usuarioCadastroId": usuarioCadastroId,
    "fechado": fechado,
    "validade": validade,
    "formaPagamentoId": formaPagamentoId,
    "numeroParcelas": numeroParcelas,
    "valorParcela": valorParcela,
    "usuarioAprovacaoId": usuarioAprovacaoId,
    "dataAprovacao": dataAprovacao!.toIso8601String(),
    "status": status != null ? status!.toMap(): null,
    "itens": itens != null ? List<dynamic>.from(itens!.map((x) => x.toMap())) : null,
  };
}
