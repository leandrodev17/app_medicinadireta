import 'package:equatable/equatable.dart';

class PatientProductsServiceNewEvolution extends Equatable {
  final int? id;
  final String? nome;
  final String? descricao;
  final double? preco;
  final String? isAtivo;
  final String? tipoTributacaoMunicipal;
  final String? retemIss;
  final String? nbs;
  final String? lC116;
  final String? isFixarIrrf;
  final String? isFixarIss;
  final String? isFixarCsll;
  final String? isFixarCofins;
  final String? isFixarPis;
  final String? retemIrrf;
  final String? retemPis;
  final String? retemCofins;
  final String? retemCsll;
  final int? consideraAliquotaCsllInformado;
  final int? consideraAliquotaPisInformado;
  final int? consideraAliquotaCofinsInformado;
  final int? consideraAliquotaIrrfInformado;
  final int? consideraAliquotaIssInformado;
  final String? codigoExterno;
  
  PatientProductsServiceNewEvolution({
    this.id,
    this.nome,
    this.descricao,
    this.preco,
    this.isAtivo,
    this.tipoTributacaoMunicipal,
    this.retemIss,
    this.nbs,
    this.lC116,
    this.isFixarIrrf,
    this.isFixarIss,
    this.isFixarCsll,
    this.isFixarCofins,
    this.isFixarPis,
    this.retemIrrf,
    this.retemPis,
    this.retemCofins,
    this.retemCsll,
    this.consideraAliquotaCsllInformado,
    this.consideraAliquotaPisInformado,
    this.consideraAliquotaCofinsInformado,
    this.consideraAliquotaIrrfInformado,
    this.consideraAliquotaIssInformado,
    this.codigoExterno,
  });

  @override
  List<Object?> get props => [
        id,
        nome,
        descricao,
        preco,
        isAtivo,
        tipoTributacaoMunicipal,
        retemIss,
        nbs,
        lC116,
        isFixarIrrf,
        isFixarIss,
        isFixarCsll,
        isFixarCofins,
        isFixarPis,
        retemIrrf,
        retemPis,
        retemCofins,
        retemCsll,
        consideraAliquotaCsllInformado,
        consideraAliquotaPisInformado,
        consideraAliquotaCofinsInformado,
        consideraAliquotaIrrfInformado,
        consideraAliquotaIssInformado,
        codigoExterno,
      ];
}
