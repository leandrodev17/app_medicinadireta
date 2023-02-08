import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/patient_products_service_new_evolution.dart';

// ######## O MOTIVO DOS CAMPOS COMENTADOS É PQ NÃO ESTÁ USANDO PARA NADA ########

class PatientProductsServiceNewEvolutionExt extends PatientProductsServiceNewEvolution {
  final int? id;
  final String? nome;
  final String? descricao;
  // final double? preco;
  final String? isAtivo;
  // final String? tipoTributacaoMunicipal;
  // final String? retemIss;
  // final String? nbs;
  // final String? lC116;
  // final String? isFixarIrrf;
  // final String? isFixarIss;
  // final String? isFixarCsll;
  // final String? isFixarCofins;
  // final String? isFixarPis;
  // final String? retemIrrf;
  // final String? retemPis;
  // final String? retemCofins;
  // final String? retemCsll;
  // final int? consideraAliquotaCsllInformado;
  // final int? consideraAliquotaPisInformado;
  // final int? consideraAliquotaCofinsInformado;
  // final int? consideraAliquotaIrrfInformado;
  // final int? consideraAliquotaIssInformado;
  // final String? codigoExterno;
  PatientProductsServiceNewEvolutionExt({
    this.id,
    this.nome,
    this.descricao,
    // this.preco,
    this.isAtivo,
    // this.tipoTributacaoMunicipal,
    // this.retemIss,
    // this.nbs,
    // this.lC116,
    // this.isFixarIrrf,
    // this.isFixarIss,
    // this.isFixarCsll,
    // this.isFixarCofins,
    // this.isFixarPis,
    // this.retemIrrf,
    // this.retemPis,
    // this.retemCofins,
    // this.retemCsll,
    // this.consideraAliquotaCsllInformado,
    // this.consideraAliquotaPisInformado,
    // this.consideraAliquotaCofinsInformado,
    // this.consideraAliquotaIrrfInformado,
    // this.consideraAliquotaIssInformado,
    // this.codigoExterno,
  });
factory PatientProductsServiceNewEvolutionExt.fromMap(Map<String, dynamic> json) => PatientProductsServiceNewEvolutionExt(
        id: json["id"],
        nome: json["nome"],
        descricao: json["descricao"],
        // preco: json["preco"] != null ? double.parse(json["preco"]) : null,
        isAtivo: json["isAtivo"],
        // tipoTributacaoMunicipal: json["tipoTributacaoMunicipal"],
        // retemIss: json["retemISS"],
        // nbs: json["nbs"],
        // lC116: json["lC116"],
        // isFixarIrrf: json["isFixarIRRF"],
        // isFixarIss: json["isFixarISS"],
        // isFixarCsll: json["isFixarCSLL"],
        // isFixarCofins: json["isFixarCofins"],
        // isFixarPis: json["isFixarPIS"],
        // retemIrrf: json["retemIRRF"],
        // retemPis: json["retemPIS"],
        // retemCofins: json["retemCofins"],
        // retemCsll: json["retemCSLL"],
        // consideraAliquotaCsllInformado: json["consideraAliquotaCSLLInformado"],
        // consideraAliquotaPisInformado: json["consideraAliquotaPISInformado"],
        // consideraAliquotaCofinsInformado: json["consideraAliquotaCofinsInformado"],
        // consideraAliquotaIrrfInformado: json["consideraAliquotaIRRFInformado"],
        // consideraAliquotaIssInformado: json["consideraAliquotaISSInformado"],
        // codigoExterno: json["codigoExterno"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
        "descricao": descricao,
        "preco": preco,
        "isAtivo": isAtivo,
    //     "tipoTributacaoMunicipal": tipoTributacaoMunicipal,
    //     "retemISS": retemIss,
    //     "nbs": nbs,
    //     "lC116": lC116,
    //     "isFixarIRRF": isFixarIrrf,
    //     "isFixarISS": isFixarIss,
    //     "isFixarCSLL": isFixarCsll,
    //     "isFixarCofins": isFixarCofins,
    //     "isFixarPIS": isFixarPis,
    //     "retemIRRF": retemIrrf,
    //     "retemPIS": retemPis,
    //     "retemCofins": retemCofins,
    //     "retemCSLL": retemCsll,
    //     "consideraAliquotaCSLLInformado": consideraAliquotaCsllInformado,
    //     "consideraAliquotaPISInformado": consideraAliquotaPisInformado,
    //     "consideraAliquotaCofinsInformado": consideraAliquotaCofinsInformado,
    //     "consideraAliquotaIRRFInformado": consideraAliquotaIrrfInformado,
    //     "consideraAliquotaISSInformado": consideraAliquotaIssInformado,
    //     "codigoExterno": codigoExterno,
    };
}
