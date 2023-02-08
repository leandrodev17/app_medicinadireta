import 'package:dartz/dartz.dart';

import '/core/models/request/query_parameters.dart';
import '/core/network/failures/failures.dart';
import '/core/network/failures/failures_generic.dart';
import '/modules/patient_information/submodules/allergy/domain/entities/network/response_allergy.dart';
import '/modules/patient_information/submodules/allergy/domain/repositories/allergy_repository.dart';

import './allergy_usecase.dart';

class AllergyUsecaseImpl implements AllergyUsecase {
  final AllergyRepository repository;

  AllergyUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseAllergy>> findAllergysUsecase(int pacientId, QueryParameters parameters) async {
    try {
      if (pacientId == 0) return left(FailureGeneric(message: 'Falha de sistema, não foi possível efetuar a listagem'));
      return repository.findAllergysRepository(pacientId, parameters);
    } catch (e) {
      return left(FailureGeneric(message: 'Falha de sistema, não foi possível efetuar a listagem'));
    }
  }
}
