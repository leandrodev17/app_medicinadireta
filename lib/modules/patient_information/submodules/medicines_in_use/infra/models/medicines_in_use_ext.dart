
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/domain/entities/medicines_in_use.dart';

import 'medicines_ext.dart';

class MedicinesInUseExt extends MedicinesInUse {
  final int? id;
  final int? pacienteId;
  final String? dataUsoIni;
  final String? dataUsoFim;
  final int? medicamentoId;
  final String? medicamentoDescricao;
  final String? principioAtivo;
  final String? posologia;
  final String? statusUso;
  final String? tipoInformacao;
  final String? logDataInclusao;
  final String? logDataAtualizacao;
  final String? dataEvento;
  final int? logUsuario;
  final String? editavel;
  final String? ativado;
  final MedicamentoExt? medicamento;
  MedicinesInUseExt({
    this.id,
    this.pacienteId,
    this.dataUsoIni,
    this.dataUsoFim,
    this.medicamentoId,
    this.medicamentoDescricao,
    this.principioAtivo,
    this.posologia,
    this.statusUso,
    this.tipoInformacao,
    this.logDataInclusao,
    this.logDataAtualizacao,
    this.dataEvento,
    this.logUsuario,
    this.editavel,
    this.ativado,
    this.medicamento,
  });

  MedicinesInUseExt copyWith({
    int? id,
    int? pacienteId,
    String? dataUsoIni,
    String? dataUsoFim,
    int? medicamentoId,
    String? medicamentoDescricao,
    String? principioAtivo,
    String? posologia,
    String? statusUso,
    String? tipoInformacao,
    String? logDataInclusao,
    String? logDataAtualizacao,
    String? dataEvento,
    int? logUsuario,
    String? editavel,
    String? ativado,
    MedicamentoExt? medicamento,
  }) =>
      MedicinesInUseExt(
        id: id ?? this.id,
        pacienteId: pacienteId ?? this.pacienteId,
        dataUsoIni: dataUsoIni ?? this.dataUsoIni,
        dataUsoFim: dataUsoFim ?? this.dataUsoFim,
        medicamentoId: medicamentoId ?? this.medicamentoId,
        medicamentoDescricao: medicamentoDescricao ?? this.medicamentoDescricao,
        principioAtivo: principioAtivo ?? this.principioAtivo,
        posologia: posologia ?? this.posologia,
        statusUso: statusUso ?? this.statusUso,
        tipoInformacao: tipoInformacao ?? this.tipoInformacao,
        logDataInclusao: logDataInclusao ?? this.logDataInclusao,
        logDataAtualizacao: logDataAtualizacao ?? this.logDataAtualizacao,
        dataEvento: dataEvento ?? this.dataEvento,
        logUsuario: logUsuario ?? this.logUsuario,
        editavel: editavel ?? this.editavel,
        ativado: ativado ?? this.ativado,
        medicamento: medicamento ?? this.medicamento,
      );

  factory MedicinesInUseExt.fromMap(Map<String, dynamic> json) => MedicinesInUseExt(
    id: json["id"],
    pacienteId: json["pacienteId"],
    dataUsoIni: json["dataUsoIni"],
    dataUsoFim: json["dataUsoFim"],
    medicamentoId: json["medicamentoId"],
    medicamentoDescricao: json["medicamentoDescricao"],
    principioAtivo: json["principioAtivo"],
    posologia: json["posologia"],
    statusUso: json["statusUso"],
    tipoInformacao: json["tipoInformacao"],
    logDataInclusao: json["logDataInclusao"],
    logDataAtualizacao: json["logDataAtualizacao"],
    dataEvento: json["dataEvento"],
    logUsuario: json["logUsuario"],
    editavel: json["editavel"],
    ativado: json["ativado"],
    medicamento: json["medicamento"] != null ? MedicamentoExt.fromMap(json["medicamento"]) : null,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "pacienteId": pacienteId,
    "dataUsoIni": dataUsoIni,
    "dataUsoFim": dataUsoFim,
    "medicamentoId": medicamentoId,
    "medicamentoDescricao": medicamentoDescricao,
    "principioAtivo": principioAtivo,
    "posologia": posologia,
    "statusUso": statusUso,
    "tipoInformacao": tipoInformacao,
    "logDataInclusao": logDataInclusao,
    "logDataAtualizacao": logDataAtualizacao,
    "dataEvento": dataEvento,
    "logUsuario": logUsuario,
    "editavel": editavel,
    "ativado": ativado,
    "medicamento": medicamento != null ? medicamento!.toMap() : null,
  };
}


