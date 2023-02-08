import 'package:equatable/equatable.dart';
import 'package:medicinadireta/core/models/profissional/profissional.dart';

class ExamsEntitie extends Equatable {
  final int? id;
  final int? atendimentoId;
  final String? descricao;
  final String? dataLocal;
  final String? status;
  final String? versao;
  final String? enviado;
  final String? editavel;
  final String? ativado;
  final String? dataUtc;
  final String? receituario;
  final Profissional? profissional;
  final dynamic logUsuario;

  const ExamsEntitie({
    this.id,
    this.atendimentoId,
    this.descricao,
    this.dataLocal,
    this.status,
    this.versao,
    this.enviado,
    this.editavel,
    this.ativado,
    this.dataUtc,
    this.profissional,
    this.logUsuario,
    this.receituario,
  });

  @override
  List<Object?> get props => [
        id,
        atendimentoId,
        descricao,
        dataLocal,
        receituario,
        status,
        versao,
        enviado,
        editavel,
        ativado,
        dataUtc,
        profissional,
        logUsuario,
      ];
}
