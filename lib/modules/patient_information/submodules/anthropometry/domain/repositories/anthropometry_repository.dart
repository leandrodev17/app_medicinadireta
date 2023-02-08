import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anthropometry/domain/entities/network/anthropometry_response.dart';

abstract class AnthropometryRepository {
  Future<Either<Failures, AnthropometryResponse>> findAllAnthropometryRepository(int pacientId);
}
