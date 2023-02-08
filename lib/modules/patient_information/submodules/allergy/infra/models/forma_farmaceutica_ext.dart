import 'dart:convert';

import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/forma_farmaceutica.dart';


class FormaFarmaceuticaExt extends FormaFarmaceutica {
  const FormaFarmaceuticaExt({super.codigo, super.descricao, super.composto, super.ihh, super.nivel, super.id});

  factory FormaFarmaceuticaExt.fromMap(Map<String, dynamic> map) {
    return FormaFarmaceuticaExt(
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

  FormaFarmaceuticaExt copyWith({
    String? codigo,
    String? descricao,
    String? composto,
    String? ihh,
    int? nivel,
    int? id,
  }) {
    return FormaFarmaceuticaExt(
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      composto: composto ?? this.composto,
      ihh: ihh ?? this.ihh,
      nivel: nivel ?? this.nivel,
      id: id ?? this.id,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormaFarmaceuticaExt.fromJson(String source) => FormaFarmaceuticaExt.fromMap(json.decode(source));
}
