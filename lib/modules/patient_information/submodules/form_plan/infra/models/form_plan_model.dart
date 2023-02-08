import 'package:medicinadireta/core/models/profissional/profissional.dart';
import 'package:medicinadireta/modules/patient_information/submodules/form_plan/domain/entities/form_plan_entitie.dart';

class FormPlanModel extends FormPlanEntitie {
  const FormPlanModel({
    super.id,
    super.atendimentoId,
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
    super.receituario,
    super.tipoDescricao,
  });

  factory FormPlanModel.fromMap(Map<String, dynamic> json) => FormPlanModel(
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
        tipoDescricao: json['tipoDescricao'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['descricao'] = descricao;
    data['status'] = status;
    data['versao'] = versao;
    data['ativado'] = ativado;
    data['logUsuario'] = logUsuario;
    data['ativado'] = ativado;
    data['dataUtc'] = dataUtc;
    data['atendimentoId'] = atendimentoId;
    data['editavel'] = editavel;
    data['receituario'] = receituario;
    data['dataLocal'] = dataLocal;
    if (profissional != null) {
      data['profissional'] = profissional?.toMap();
    } else {
      data['profissional'] = null;
    }
    data['tipoDescricao'] = tipoDescricao;
    return data;
  }
}
