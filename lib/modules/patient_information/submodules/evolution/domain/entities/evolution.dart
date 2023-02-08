import 'package:equatable/equatable.dart';
import 'package:medicinadireta/core/models/profissional/profissional.dart';

class Evolution extends Equatable {
  final int? id;
  final int? pacienteId;
  final int? unidade;
  final String? contactado;
  final String? dataInclusao;
  final String? status;
  final String? dataAgenda;
  final String? horaAgenda;
  final String? dataAgendaUtc;
  final String? localAgenda;
  final String? historico;
  final String? tipoEditor;
  final String? idOcorrencias;
  final String? cid;
  final String? cidDescricao;
  final String? tuss;
  final String? tussDescricao;
  final int? logUsuario;
  final String? logDataInclusao;
  final String? logDataAtualizacao;
  final String? dataUtc;
  final String? dataSrv;
  final String? dataLocal;
  final String? editavel;
  final String? ativado;
  final int? atendimentoId;
  final Profissional? profissional;

  const Evolution({
    this.id,
    this.pacienteId,
    this.unidade,
    this.contactado,
    this.dataInclusao,
    this.status,
    this.dataAgenda,
    this.horaAgenda,
    this.dataAgendaUtc,
    this.localAgenda,
    this.historico,
    this.tipoEditor,
    this.idOcorrencias,
    this.cid,
    this.cidDescricao,
    this.tuss,
    this.tussDescricao,
    this.logUsuario,
    this.logDataInclusao,
    this.logDataAtualizacao,
    this.dataUtc,
    this.dataSrv,
    this.dataLocal,
    this.editavel,
    this.ativado,
    this.atendimentoId,
    this.profissional,
  });

  @override
  List<Object?> get props => [
        id,
        pacienteId,
        unidade,
        contactado,
        dataInclusao,
        status,
        dataAgenda,
        horaAgenda,
        dataAgendaUtc,
        localAgenda,
        historico,
        tipoEditor,
        idOcorrencias,
        cid,
        cidDescricao,
        tuss,
        tussDescricao,
        logUsuario,
        logDataInclusao,
        logDataAtualizacao,
        dataUtc,
        dataSrv,
        dataLocal,
        editavel,
        ativado,
        atendimentoId,
        profissional,
      ];
}
