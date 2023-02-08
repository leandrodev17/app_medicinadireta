import 'package:equatable/equatable.dart';

import '../../../../../../core/models/profissional/profissional.dart';

class Anamnese extends Equatable {
  final int? id;
  final int? usuarioId;
  final int? atendimentoId;
  final int? pacienteId;
  final String? dataUtc;
  final String? dataSrv;
  final String? dataLocal;
  final String? dataEvento;
  final String? utcEvento;
  final String? codigoTitulo;
  final String? titulo;
  final String? descricao;
  final String? motivoAtendimento;
  final String? descricaoHda;
  final String? descricaoHpp;
  final String? descricaoHabito;
  final String? descricaoVicio;
  final String? historicoMental;
  final String? historicoFamiliar;
  final String? outros;
  final String? justificaRetroativo;
  final String? fonteInformacao;
  final String? triagem;
  final String? terminologiaQueixaPrincipal;
  final String? descricaoQueixaPrincipal;
  final String? codigoQueixaPrincipal;
  final String? editavel;
  final String? ativado;
  final Profissional? profissional;

  const Anamnese({
    this.id,
    this.atendimentoId,
    this.usuarioId,
    this.pacienteId,
    this.dataUtc,
    this.dataSrv,
    this.dataLocal,
    this.dataEvento,
    this.utcEvento,
    this.codigoTitulo,
    this.titulo,
    this.descricao,
    this.motivoAtendimento,
    this.descricaoHda,
    this.descricaoHpp,
    this.descricaoHabito,
    this.descricaoVicio,
    this.historicoMental,
    this.historicoFamiliar,
    this.outros,
    this.justificaRetroativo,
    this.fonteInformacao,
    this.triagem,
    this.terminologiaQueixaPrincipal,
    this.descricaoQueixaPrincipal,
    this.codigoQueixaPrincipal,
    this.editavel,
    this.ativado,
    this.profissional,
  });

  @override
  List<Object?> get props => [
        id,
        atendimentoId,
        usuarioId,
        pacienteId,
        dataUtc,
        dataSrv,
        dataLocal,
        dataEvento,
        utcEvento,
        codigoTitulo,
        titulo,
        descricao,
        motivoAtendimento,
        descricaoHda,
        descricaoHpp,
        descricaoHabito,
        descricaoVicio,
        historicoMental,
        historicoFamiliar,
        outros,
        justificaRetroativo,
        fonteInformacao,
        triagem,
        terminologiaQueixaPrincipal,
        descricaoQueixaPrincipal,
        codigoQueixaPrincipal,
        editavel,
        ativado,
        profissional,
      ];
}
