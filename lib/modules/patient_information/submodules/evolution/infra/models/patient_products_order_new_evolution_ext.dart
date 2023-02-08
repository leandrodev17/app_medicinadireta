import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/patient_products_order_new_evolution.dart';

// ######## O MOTIVO DOS CAMPOS COMENTADOS É PQ NÃO ESTÁ USANDO PARA NADA ########
class PatientProductsOrderNewEvolutionExt extends PatientProductsOrderNewEvolution {
  final int? id;
  final int? pacienteId;
  // final int? organizacaoId;
  final int? sequencia;
  // final int? statusId;
  // final DateTime? orcamentoData;
  // final double? total;
  // final int? pago;
  // final int? saldo;
  // final int? credito;
  // final int? usuarioCadastroId;
  // final String? fechado;
  // final String? validade;
  // final int? formaPagamentoId;
  // final int? numeroParcelas;
  // final int? valorParcela;
  // final int? usuarioAprovacaoId;
  // final DateTime? dataAprovacao;

  PatientProductsOrderNewEvolutionExt({
    this.id,
    this.pacienteId,
    // this.organizacaoId,
    this.sequencia,
    // this.statusId,
    // this.orcamentoData,
    // this.total,
    // this.pago,
    // this.saldo,
    // this.credito,
    // this.usuarioCadastroId,
    // this.fechado,
    // this.validade,
    // this.formaPagamentoId,
    // this.numeroParcelas,
    // this.valorParcela,
    // this.usuarioAprovacaoId,
    // this.dataAprovacao,
  });

  factory PatientProductsOrderNewEvolutionExt.fromMap(Map<String, dynamic> json) => PatientProductsOrderNewEvolutionExt(
        id: json["id"],
        pacienteId: json["pacienteId"],
        // organizacaoId: json["organizacaoId"],
        sequencia: json["sequencia"],
        // statusId: json["statusId"],
        // orcamentoData: DateTime.parse(json["orcamentoData"]),
        // total: json["total"] != null ? double.parse(json["total"]) : null,
        // pago: json["pago"],
        // saldo: json["saldo"],
        // credito: json["credito"],
        // usuarioCadastroId: json["usuarioCadastroId"],
        // fechado: json["fechado"],
        // validade: json["validade"],
        // formaPagamentoId: json["formaPagamentoId"],
        // numeroParcelas: json["numeroParcelas"],
        // valorParcela: json["valorParcela"],
        // usuarioAprovacaoId: json["usuarioAprovacaoId"],
        // dataAprovacao: json["dataAprovacao"] != null ? DateTime.parse(json["dataAprovacao"]) : null,
      );

  Map<String, dynamic> toMap() => {
        // "id": id,
        // "pacienteId": pacienteId,
        // "organizacaoId": organizacaoId,
        "sequencia": sequencia,
        // "statusId": statusId,
        // "orcamentoData": orcamentoData!.toIso8601String(),
        // "total": total,
        // "pago": pago,
        // "saldo": saldo,
        // "credito": credito,
        // "usuarioCadastroId": usuarioCadastroId,
        // "fechado": fechado,
        // "validade": validade,
        // "formaPagamentoId": formaPagamentoId,
        // "numeroParcelas": numeroParcelas,
        // "valorParcela": valorParcela,
        // "usuarioAprovacaoId": usuarioAprovacaoId,
        // "dataAprovacao": dataAprovacao!.toIso8601String(),
      };
}
