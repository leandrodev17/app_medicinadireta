import 'package:medicinadireta/core/models/profissional/profissional.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/domain/entities/prescription_entitie.dart';

class PrescriptionModel extends PrescriptionEntitie {
  const PrescriptionModel({
    super.id,
    super.privacidadeClinica,
    super.descricao,
    super.status,
    super.logUsuario,
    super.tipoDescricao,
    super.versao,
    super.ativado,
    super.logDtInclusao,
    super.dataUtc,
    super.atendimentoId,
    super.editavel,
    super.dataLocal,
    super.profissional,
    super.receituario,
  });

  factory PrescriptionModel.fromMap(Map<String, dynamic> json) => PrescriptionModel(
        id: json['id'],
        privacidadeClinica: json['privacidadeClinica'],
        descricao: json['descricao'],
        status: json['status'],
        versao: json['versao'],
        tipoDescricao: json['tipoDescricao'],
        logUsuario: json['logUsuario'],
        ativado: json['ativado'],
        logDtInclusao: json['logDtInclusao'],
        dataUtc: json['utc'],
        atendimentoId: json['atendimentoId'],
        editavel: json['editavel'],
        dataLocal: json['dataLocal'],
        profissional: json["profissional"] != null ? Profissional.fromMap(json["profissional"]) : null,
        receituario: json['receituario'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['privacidadeClinica'] = privacidadeClinica;
    data['descricao'] = descricao;
    data['status'] = status;
    data['versao'] = versao;
    data['tipoDescricao'] = tipoDescricao;
    data['logUsuario'] = logUsuario;
    data['ativado'] = ativado;
    data['logDtInclusao'] = logDtInclusao;
    data['utc'] = dataUtc;
    data['atendimentoId'] = atendimentoId;
    data['editavel'] = editavel;
    data['dataLocal'] = dataLocal;
    data['receituario'] = receituario;
    if (profissional != null) {
      data['profissional'] = profissional?.toMap();
    } else {
      data['profissional'] = null;
    }
    return data;
  }
}
