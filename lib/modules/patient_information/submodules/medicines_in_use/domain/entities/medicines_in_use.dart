import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/domain/entities/medicines.dart';
import 'package:equatable/equatable.dart';

class MedicinesInUse extends Equatable {
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
  final Medicamento? medicamento;
  MedicinesInUse({
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

  @override
  List<Object?> get props => [
        id,
        pacienteId,
        dataUsoIni,
        dataUsoFim,
        medicamentoId,
        medicamentoDescricao,
        principioAtivo,
        posologia,
        statusUso,
        tipoInformacao,
        logDataInclusao,
        logDataAtualizacao,
        dataEvento,
        logUsuario,
        editavel,
        ativado,
        medicamento,
      ];
}
