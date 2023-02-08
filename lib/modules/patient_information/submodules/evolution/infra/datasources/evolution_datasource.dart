import 'package:medicinadireta/core/models/request/headers.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/params_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/request_new_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/network/response_evolution_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/network/response_new_evolution_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/network/response_patient_products_model_new_evolution_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/network/response_patient_products_new_evolution_ext.dart';

abstract class EvolutionDatasource {
  Future<ResponseEvolutionExt> evolutionDatasource(ParamsEvolution req, int patientId);

  Future<ResponsePatientProductsNewEvolutionExt> patientProductsDatasource(QueryParameters req, Headers head);
  Future<ResponseNewEvolutionExt> saveNewEvolutionDatasource(RequestNewEvolution req, int patientId);
  Future<ResponseNewEvolutionExt> updateNewEvolutionDatasource(RequestNewEvolution req, int evolutionId);
  Future<ResponsePatientProductsModelNewEvolutionExt> patientProductsModelDatasource();
}
