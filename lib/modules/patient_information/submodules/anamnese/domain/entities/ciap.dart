import 'package:equatable/equatable.dart';

class Ciap extends Equatable {
  final String? codigo;
  final String? titulo;
  final String? cids10Possiveis;
  final String? cid10MaisFrequente;
  final String? definicao;
  final String? criteriosDeInclusao;
  final String? criteriosDeExclusao;
  final String? considerar;
  final String? nota;

  Ciap({
    this.codigo,
    this.titulo,
    this.cids10Possiveis,
    this.cid10MaisFrequente,
    this.definicao,
    this.criteriosDeInclusao,
    this.criteriosDeExclusao,
    this.considerar,
    this.nota,
  });

  @override
  List<Object?> get props => [
        this.codigo,
        this.titulo,
        this.cids10Possiveis,
        this.cid10MaisFrequente,
        this.definicao,
        this.criteriosDeInclusao,
        this.criteriosDeExclusao,
        this.considerar,
        this.nota,
      ];
}
