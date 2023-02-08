import 'dart:convert';

import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/cid_sub_categoria.dart';

CidSubCategoriaExt cidSubCategoriaExtFromMap(String str) => CidSubCategoriaExt.fromMap(json.decode(str));

String cidSubCategoriaExtToMap(CidSubCategoriaExt data) => json.encode(data.toMap());

class CidSubCategoriaExt extends CidSubCategoria {
  final String? subCat;
  final String? descricao;

  CidSubCategoriaExt({this.subCat, this.descricao});

  CidSubCategoriaExt copyWith({String? subCat, String? descricao}) => CidSubCategoriaExt(
        subCat: subCat ?? this.subCat,
        descricao: descricao ?? this.descricao,
      );

  factory CidSubCategoriaExt.fromMap(Map<String, dynamic> json) => CidSubCategoriaExt(
        subCat: json["subCat"],
        descricao: json["descricao"],
      );

  Map<String, dynamic> toMap() => {
        "subCat": subCat,
        "descricao": descricao,
      };
}
