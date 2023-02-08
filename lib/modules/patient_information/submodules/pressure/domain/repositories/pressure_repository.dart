import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:medicinadireta/modules/patient_information/submodules/pressure/domain/entities/network/pressure_response.dart';

abstract class PressureRepository {
  Future<Either<Failures, PressureResponse>> findAllPressureRepository(int pacientId);
}
