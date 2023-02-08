import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/patient_products_new_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/patient_products_order_new_evolution_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/patient_products_service_new_evolution_ext.dart';

class PatientProductsNewEvolutionExt extends PatientProductsNewEvolution {
  final int? id;
  final String? quantidade;
  final PatientProductsServiceNewEvolutionExt? servico;
  final PatientProductsOrderNewEvolutionExt? orcamento;

  PatientProductsNewEvolutionExt({
    this.id,
    this.quantidade,
    this.servico,
    this.orcamento,
  });

  factory PatientProductsNewEvolutionExt.fromMap(Map<String, dynamic> json) => PatientProductsNewEvolutionExt(
        id: json["id"],
        quantidade: json["quantidade"],
        servico: json["servico"] != null ? PatientProductsServiceNewEvolutionExt.fromMap(json["servico"]) : null,
        orcamento: json["orcamento"] != null ? PatientProductsOrderNewEvolutionExt.fromMap(json["orcamento"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "quantidade": quantidade,
        "servico": servico != null ? servico!.toMap() : null,
        "orcamento": orcamento != null ? orcamento!.toMap() : null,
      };
}
