import '/core/models/request/query_parameters.dart';
import '/core/network/failures/failures.dart';
import '/modules/patient_information/submodules/allergy/domain/entities/network/response_allergy.dart';

import 'package:dartz/dartz.dart';

abstract class AllergyUsecase {
  Future<Either<Failures, ResponseAllergy>> findAllergysUsecase(int pacientId, QueryParameters parameters);
}
