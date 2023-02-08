import 'package:equatable/equatable.dart';

import 'patient_products_order_new_evolution.dart';
import 'patient_products_service_new_evolution.dart';

class PatientProductsNewEvolution extends Equatable {
  final int? id;
  final String? quantidade;
  final PatientProductsServiceNewEvolution? servico;
  final PatientProductsOrderNewEvolution? orcamento;

  PatientProductsNewEvolution({
    this.id,
    this.quantidade,
    this.servico,
    this.orcamento,
  });

  @override
  List<Object?> get props => [
        id,
        quantidade,
        servico,
        orcamento,
      ];
}
