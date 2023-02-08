import 'package:medicinadireta/core/models/profissional/profissional.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/domain/entities/exams_entitie.dart';

class ExamsModel extends ExamsEntitie {
  const ExamsModel({
    super.id,
    super.atendimentoId,
    super.receituario,
    super.descricao,
    super.dataLocal,
    super.status,
    super.versao,
    super.enviado,
    super.editavel,
    super.ativado,
    super.dataUtc,
    super.profissional,
    super.logUsuario,
  });

  factory ExamsModel.fromMap(Map<String, dynamic> json) => ExamsModel(
        id: json['id'],
        descricao: json['descricao'],
        status: json['status'],
        enviado: json['enviado'],
        receituario: json['receituario'],
        versao: json['versao'],
        logUsuario: json['logUsuario'],
        ativado: json['ativado'],
        dataUtc: json['utc'],
        atendimentoId: json['atendimentoId'],
        editavel: json['editavel'],
        dataLocal: json['dataLocal'],
        profissional: json["profissional"] != null ? Profissional.fromMap(json["profissional"]) : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['descricao'] = descricao;
    data['status'] = status;
    data['versao'] = versao;
    data['receituario'] = receituario;
    data['ativado'] = ativado;
    data['logUsuario'] = logUsuario;
    data['ativado'] = ativado;
    data['dataUtc'] = dataUtc;
    data['atendimentoId'] = atendimentoId;
    data['editavel'] = editavel;
    data['dataLocal'] = dataLocal;
    if (profissional != null) {
      data['profissional'] = profissional?.toMap();
    } else {
      data['profissional'] = null;
    }
    return data;
  }
}
