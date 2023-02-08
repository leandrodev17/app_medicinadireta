import 'dart:convert';

import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/classe_terapeutica.dart';

class ClasseTerapeuticaExt extends ClasseTerapeutica {
  const ClasseTerapeuticaExt({super.codigo, super.descricao, super.composto, super.ihh, super.nivel, super.id});

  factory ClasseTerapeuticaExt.fromMap(Map<String, dynamic> map) {
    return ClasseTerapeuticaExt(
      codigo: map['codigo'],
      descricao: map['descricao'],
      composto: map['composto'],
      ihh: map['ihh'],
      nivel: map['nivel']?.toInt(),
      id: map['id']?.toInt(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'descricao': descricao,
      'composto': composto,
      'ihh': ihh,
      'nivel': nivel,
      'id': id,
    };
  }

  ClasseTerapeuticaExt copyWith({
    String? codigo,
    String? descricao,
    String? composto,
    String? ihh,
    int? nivel,
    int? id,
  }) {
    return ClasseTerapeuticaExt(
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      composto: composto ?? this.composto,
      ihh: ihh ?? this.ihh,
      nivel: nivel ?? this.nivel,
      id: id ?? this.id,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClasseTerapeuticaExt.fromJson(String source) => ClasseTerapeuticaExt.fromMap(json.decode(source));
}
