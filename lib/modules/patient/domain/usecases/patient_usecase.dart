import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient/domain/entities/network/response_patient.dart';

import 'package:dartz/dartz.dart';

abstract class PatientUsecase {
  Future<Either<Failures, ResponsePatient>> findByPatient(QueryParameters parameters);
  Future<Either<Failures, ResponsePatient>> findByPatientId(QueryParameters parameters, int patientId);
}
