import 'package:medicinadireta/core/models/profissional/profissional.dart';

import '../../domain/entities/anthropometry_entitie.dart';

class AnthropometryModel extends AnthropometryEntitie {
  const AnthropometryModel({
    super.id,
    super.privacidadeClinica,
    super.descricao,
    super.status,
    super.logUsuario,
    super.tipoDescricao,
    super.versao,
    super.ativado,
    super.logDtInclusao,
    super.utcEvento,
    super.atendimentoId,
    super.editavel,
    super.dataEvento,
    super.profissional,
    super.receituario,
    super.peso,
    super.pesoUm,
    super.altura,
    super.alturaUm,
    super.circuferenciaAbdominal,
    super.abdominalUm,
    super.calcAsc,
    super.calcImc,
    super.calcIca,
    super.calcAct,
    super.calcPgc,
    super.massaMagra,
    super.massaMagraUm,
    super.massaGorda,
    super.massaGordaUm,
  });

  factory AnthropometryModel.fromMap(Map<String, dynamic> json) => AnthropometryModel(
        id: json['id'],
        privacidadeClinica: json['privacidadeClinica'],
        descricao: json['descricao'],
        status: json['statusAssinatura'].toString().trim().isNotEmpty ? json['statusAssinatura'].toString() : null,
        versao: json['versao'],
        tipoDescricao: json['tipoDescricao'],
        logUsuario: json['logUsuario'],
        ativado: json['ativado'],
        logDtInclusao: json['dataEvento'],
        utcEvento: json['utcEvento'],
        atendimentoId: json['atendimentoId'],
        editavel: json['editavel'],
        dataEvento: json['dataEvento'],
        profissional: json["profissional"] != null ? Profissional.fromMap(json["profissional"]) : null,
        receituario: json['receituario'],
        peso: json['peso'],
        pesoUm: json['pesoUm'],
        altura: json['altura'],
        alturaUm: json['alturaUm'],
        circuferenciaAbdominal: json['circuferenciaAbdominal'],
        abdominalUm: json['abdominalUm'],
        calcAsc: json['calcAsc'],
        calcImc: json['calcImc'],
        calcIca: json['calcIca'],
        calcAct: json['calcAct'],
        calcPgc: json['calcPgc'],
        massaMagra: json['massaMagra'],
        massaMagraUm: json['massaMagraUm'],
        massaGorda: json['massaGorda'],
        massaGordaUm: json['massaGordaUm'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['privacidadeClinica'] = privacidadeClinica;
    data['descricao'] = descricao;
    data['statusAssinatura'] = status;
    data['versao'] = versao;
    data['tipoDescricao'] = tipoDescricao;
    data['logUsuario'] = logUsuario;
    data['ativado'] = ativado;
    data['dataEvento'] = logDtInclusao;
    data['utcEvento'] = utcEvento;
    data['atendimentoId'] = atendimentoId;
    data['editavel'] = editavel;
    data['dataEvento'] = dataEvento;
    data['receituario'] = receituario;
    data['peso'] = peso;
    data['pesoUm'] = pesoUm;
    data['altura'] = altura;
    data['alturaUm'] = alturaUm;
    data['circuferenciaAbdominal'] = circuferenciaAbdominal;
    data['abdominalUm'] = abdominalUm;
    data['calcAsc'] = calcAsc;
    data['calcImc'] = calcImc;
    data['calcIca'] = calcIca;
    data['calcAct'] = calcAct;
    data['calcPgc'] = calcPgc;

    data['massaMagra'] = massaMagra;
    data['massaMagraUm'] = massaMagraUm;
    data['massaGorda'] = massaGorda;
    data['massaGordaUm'] = massaGordaUm;

    if (profissional != null) {
      data['profissional'] = profissional?.toMap();
    } else {
      data['profissional'] = null;
    }
    return data;
  }
}
