
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/patient_products_model_new_evolution.dart';

class PatientProductsModelNewEvolutionExt extends PatientProductsModelNewEvolution{
  final int? id;
  final String? titulo;
  final String? comentario;
  final String? tipo;

  PatientProductsModelNewEvolutionExt({
    this.id,
    this.titulo,
    this.comentario,
    this.tipo,
  });

  factory PatientProductsModelNewEvolutionExt.fromMap(Map<String, dynamic> json) => PatientProductsModelNewEvolutionExt(
        id: json["id"],
        titulo: json["titulo"],
        comentario: json["comentario"],
        tipo: json["tipo"],
      );

  Map<String, dynamic> toMap() => {"id": id, "titulo": titulo, "comentario": comentario, "tipo": tipo};
}
