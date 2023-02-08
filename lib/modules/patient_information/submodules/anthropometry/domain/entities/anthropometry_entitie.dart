import 'package:equatable/equatable.dart';
import 'package:medicinadireta/core/models/profissional/profissional.dart';

class AnthropometryEntitie extends Equatable {
  final int? id;
  final bool? privacidadeClinica;
  final String? descricao;
  final String? status;
  final String? versao;
  final String? tipoDescricao;
  final dynamic logUsuario;
  final String? ativado;
  final String? logDtInclusao;
  final String? utcEvento;
  final int? atendimentoId;
  final String? editavel;
  final String? dataEvento;
  final String? receituario;
  final dynamic peso;
  final String? pesoUm;
  final dynamic altura;
  final String? alturaUm;
  final dynamic circuferenciaAbdominal;
  final String? abdominalUm;
  final dynamic calcAsc;
  final dynamic calcImc;
  final dynamic calcIca;
  final dynamic calcAct;
  final dynamic calcPgc;

  final dynamic massaMagra;
  final String? massaMagraUm;
  final dynamic massaGorda;
  final String? massaGordaUm;
  final Profissional? profissional;

  const AnthropometryEntitie({
    this.id,
    this.privacidadeClinica,
    this.descricao,
    this.status,
    this.tipoDescricao,
    this.logUsuario,
    this.versao,
    this.ativado,
    this.logDtInclusao,
    this.utcEvento,
    this.atendimentoId,
    this.editavel,
    this.dataEvento,
    this.profissional,
    this.receituario,
    this.peso,
    this.pesoUm,
    this.altura,
    this.alturaUm,
    this.circuferenciaAbdominal,
    this.abdominalUm,
    this.calcAsc,
    this.calcImc,
    this.calcIca,
    this.calcAct,
    this.calcPgc,
    this.massaMagra,
    this.massaMagraUm,
    this.massaGorda,
    this.massaGordaUm,
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
        utcEvento,
        atendimentoId,
        editavel,
        dataEvento,
        profissional,
        receituario,
        peso,
        pesoUm,
        altura,
        alturaUm,
        circuferenciaAbdominal,
        abdominalUm,
        calcAsc,
        calcImc,
        calcIca,
        calcAct,
        calcPgc,
        massaMagra,
        massaMagraUm,
        massaGorda,
        massaGordaUm,
      ];
}
