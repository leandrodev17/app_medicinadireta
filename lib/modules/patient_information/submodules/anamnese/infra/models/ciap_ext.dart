import 'dart:convert';

import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/ciap.dart';

CiapExt ciapExtFromMap(String str) => CiapExt.fromMap(json.decode(str));

String ciapExtToMap(CiapExt data) => json.encode(data.toMap());

class CiapExt extends Ciap {
  final String? codigo;
  final String? titulo;
  final String? cids10Possiveis;
  final String? cid10MaisFrequente;
  final String? definicao;
  final String? criteriosDeInclusao;
  final String? criteriosDeExclusao;
  final String? considerar;
  final String? nota;

  CiapExt({
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

  CiapExt copyWith({
    String? codigo,
    String? titulo,
    String? cids10Possiveis,
    String? cid10MaisFrequente,
    String? definicao,
    String? criteriosDeInclusao,
    String? criteriosDeExclusao,
    String? considerar,
    String? nota,
  }) =>
      CiapExt(
        codigo: codigo ?? this.codigo,
        titulo: titulo ?? this.titulo,
        cids10Possiveis: cids10Possiveis ?? this.cids10Possiveis,
        cid10MaisFrequente: cid10MaisFrequente ?? this.cid10MaisFrequente,
        definicao: definicao ?? this.definicao,
        criteriosDeInclusao: criteriosDeInclusao ?? this.criteriosDeInclusao,
        criteriosDeExclusao: criteriosDeExclusao ?? this.criteriosDeExclusao,
        considerar: considerar ?? this.considerar,
        nota: nota ?? this.nota,
      );

  factory CiapExt.fromMap(Map<String, dynamic> json) => CiapExt(
        codigo: json["codigo"],
        titulo: json["titulo"],
        cids10Possiveis: json["cids10Possiveis"],
        cid10MaisFrequente: json["cid10MaisFrequente"],
        definicao: json["definicao"],
        criteriosDeInclusao: json["criteriosDeInclusao"],
        criteriosDeExclusao: json["criteriosDeExclusao"],
        considerar: json["considerar"],
        nota: json["nota"],
      );

  Map<String, dynamic> toMap() => {
        "codigo": codigo,
        "titulo": titulo,
        "cids10Possiveis": cids10Possiveis,
        "cid10MaisFrequente": cid10MaisFrequente,
        "definicao": definicao,
        "criteriosDeInclusao": criteriosDeInclusao,
        "criteriosDeExclusao": criteriosDeExclusao,
        "considerar": considerar,
        "nota": nota,
      };
}
