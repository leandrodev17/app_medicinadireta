import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/new_patient/domain/entities/network/request_new_patient.dart';
import 'package:medicinadireta/modules/new_patient/domain/entities/network/response_new_patient.dart';

import 'package:dartz/dartz.dart';

abstract class NewPatientUsecase {
  Future<Either<Failures, ResponseNewPatient>> saveByNewPatient(RequestNewPatient params);
}
