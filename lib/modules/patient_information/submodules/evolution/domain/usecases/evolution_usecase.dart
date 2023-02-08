import 'package:medicinadireta/core/models/request/headers.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/params_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/request_new_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/response_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/response_new_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/response_patient_products_model_new_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/response_patient_products_new_evolution.dart';

import '/core/network/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class EvolutionUsecase {
  Future<Either<Failures, ResponseEvolution>> findByEvolution(ParamsEvolution req, int patientId);
  Future<Either<Failures, ResponsePatientProductsNewEvolution>> findByPatientProducts(QueryParameters req, Headers head);
  Future<Either<Failures, ResponseNewEvolution>> saveNewEvolution(RequestNewEvolution req, int patientId);
  Future<Either<Failures, ResponseNewEvolution>> updateNewEvolution(RequestNewEvolution req, int evolutionId);
  Future<Either<Failures, ResponsePatientProductsModelNewEvolution>> findByPatientProductsModel();
}
