import 'package:medicinadireta/core/models/profissional/profissional.dart';

import '../../domain/entities/pressure_entitie.dart';

class PressureModel extends PressureEntitie {
  const PressureModel({
    super.id,
    super.privacidadeClinica,
    super.descricao,
    super.logUsuario,
    super.utcEvento,
    super.atendimentoId,
    super.editavel,
    super.dataEvento,
    super.receituario,
    super.profissional,
    super.pressaoSistolicaPadrao,
    super.pressaoDistolicaPadrao,
    super.pressaoSistolica,
    super.pressaoDiastolica,
    super.pressaoUm,
    super.forma,
    super.local,
    super.posicao,
    super.assinar,
  });

  factory PressureModel.fromMap(Map<String, dynamic> json) => PressureModel(
        id: json['id'],
        privacidadeClinica: json['privacidadeClinica'],
        descricao: json['descricao'],
        logUsuario: json['logUsuario'],
        utcEvento: json['utcEvento'],
        atendimentoId: json['atendimentoId'],
        editavel: json['editavel'],
        dataEvento: json['dataEvento'],
        receituario: json['receituario'],
        pressaoSistolicaPadrao: json['pressaoSistolicaPadrao'],
        pressaoDistolicaPadrao: json['pressaoDistolicaPadrao'],
        pressaoSistolica: json['pressaoSistolica'],
        pressaoDiastolica: json['pressaoDiastolica'],
        pressaoUm: json['pressaoUm'],
        forma: json['forma'],
        local: json['local'],
        posicao: json['posicao'],
        assinar: json['assinar'],
        profissional: json["profissional"] != null ? Profissional.fromMap(json["profissional"]) : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['privacidadeClinica'] = privacidadeClinica;
    data['descricao'] = descricao;
    data['logUsuario'] = logUsuario;
    data['utcEvento'] = utcEvento;
    data['atendimentoId'] = atendimentoId;
    data['editavel'] = editavel;
    data['dataEvento'] = dataEvento;
    data['receituario'] = receituario;
    data['pressaoSistolicaPadrao'] = pressaoSistolicaPadrao;
    data['pressaoDistolicaPadrao'] = pressaoDistolicaPadrao;
    data['pressaoSistolica'] = pressaoSistolica;
    data['pressaoDiastolica'] = pressaoDiastolica;
    data['pressaoUm'] = pressaoUm;
    data['forma'] = forma;
    data['local'] = local;
    data['posicao'] = posicao;
    data['assinar'] = assinar;
    if (profissional != null) {
      data['profissional'] = profissional?.toMap();
    } else {
      data['profissional'] = null;
    }
    return data;
  }
}
