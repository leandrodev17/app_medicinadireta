
import 'package:medicinadireta/core/models/request/headers.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/domain/entities/response_doctor_schedule_and_patient.dart';

import '/core/network/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class DoctorScheduleAndPatientRepository {
  Future<Either<Failures, ResponseDoctorScheduleAndPatient>> doctorScheduleAndPatientRepository(QueryParameters req, Headers headers);
}
