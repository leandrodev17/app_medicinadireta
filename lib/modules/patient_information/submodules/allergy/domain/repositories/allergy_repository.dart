import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/network/response_allergy.dart';
import 'package:dartz/dartz.dart';

abstract class AllergyRepository {
  Future<Either<Failures, ResponseAllergy>> findAllergysRepository(int pacientId, QueryParameters parameters);
}
