import 'package:medicinadireta/core/models/request/headers.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/core/network/failures/failures_generic.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/params_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/request_new_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/response_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/response_new_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/response_patient_products_model_new_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/response_patient_products_new_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/repositories/evolution_repository.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/usecases/evolution_usecase.dart';
import 'package:dartz/dartz.dart';

class EvolutionUsecaseImpl implements EvolutionUsecase {
  final EvolutionRepository repository;

  EvolutionUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseEvolution>> findByEvolution(ParamsEvolution req, int patientId) async {
    try {
      if (req.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.evolutionRepository(req, patientId);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

   @override
  Future<Either<Failures, ResponsePatientProductsNewEvolution>> findByPatientProducts(QueryParameters req, Headers head) async {
    try {
      if (req.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.patientProductsRepository(req, head);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponsePatientProductsModelNewEvolution>> findByPatientProductsModel() async {
    try {
      return repository.patientProductsModelRepository();
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponseNewEvolution>> saveNewEvolution(RequestNewEvolution req, int patientId) async {
    try {
      if (patientId == 0) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.saveNewEvolution(req, patientId);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponseNewEvolution>> updateNewEvolution(RequestNewEvolution req, int evolutionId) async {
    try {
      if (evolutionId == 0) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.updateNewEvolution(req, evolutionId);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
