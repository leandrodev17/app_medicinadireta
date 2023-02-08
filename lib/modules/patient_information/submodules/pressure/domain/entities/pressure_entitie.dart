import 'package:equatable/equatable.dart';
import 'package:medicinadireta/core/models/profissional/profissional.dart';

class PressureEntitie extends Equatable {
  final int? id;
  final bool? privacidadeClinica;
  final String? descricao;
  final dynamic logUsuario;
  final String? utcEvento;
  final int? atendimentoId;
  final String? editavel;
  final String? dataEvento;
  final String? receituario;

  final Profissional? profissional;

  final dynamic pressaoSistolicaPadrao;
  final dynamic pressaoDistolicaPadrao;
  final dynamic pressaoSistolica;
  final dynamic pressaoDiastolica;
  final dynamic pressaoUm;
  final dynamic forma;
  final dynamic local;
  final dynamic posicao;
  final dynamic assinar;

  const PressureEntitie({
    this.id,
    this.privacidadeClinica,
    this.descricao,
    this.logUsuario,
    this.utcEvento,
    this.atendimentoId,
    this.editavel,
    this.dataEvento,
    this.receituario,
    this.profissional,
    this.pressaoSistolicaPadrao,
    this.pressaoDistolicaPadrao,
    this.pressaoSistolica,
    this.pressaoDiastolica,
    this.pressaoUm,
    this.forma,
    this.local,
    this.posicao,
    this.assinar,
  });

  @override
  List<Object?> get props => [
        id,
        privacidadeClinica,
        descricao,
        logUsuario,
        utcEvento,
        atendimentoId,
        editavel,
        dataEvento,
        receituario,
        profissional,
        pressaoSistolicaPadrao,
        pressaoDistolicaPadrao,
        pressaoSistolica,
        pressaoDiastolica,
        pressaoUm,
        forma,
        local,
        posicao,
        assinar,
      ];
}
