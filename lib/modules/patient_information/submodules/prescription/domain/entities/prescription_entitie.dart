import 'package:equatable/equatable.dart';
import 'package:medicinadireta/core/models/profissional/profissional.dart';

class PrescriptionEntitie extends Equatable {
  final int? id;
  final bool? privacidadeClinica;
  final String? descricao;
  final String? status;
  final String? versao;
  final String? tipoDescricao;
  final dynamic logUsuario;
  final String? ativado;
  final String? logDtInclusao;
  final String? dataUtc;
  final int? atendimentoId;
  final String? editavel;
  final String? dataLocal;
  final String? receituario;
  final Profissional? profissional;

  const PrescriptionEntitie({
    this.id,
    this.privacidadeClinica,
    this.descricao,
    this.status,
    this.tipoDescricao,
    this.logUsuario,
    this.versao,
    this.ativado,
    this.logDtInclusao,
    this.dataUtc,
    this.atendimentoId,
    this.editavel,
    this.dataLocal,
    this.profissional,
    this.receituario,
  });

  @override
  List<Object?> get props => [
        id,
        privacidadeClinica,
        descricao,
        status,
        logUsuario,
        tipoDescricao,
        versao,
        ativado,
        logDtInclusao,
        dataUtc,
        atendimentoId,
        editavel,
        dataLocal,
        profissional,
        receituario,
      ];
}
