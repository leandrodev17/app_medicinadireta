import 'package:medicinadireta/core/models/request/headers.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/domain/entities/response_doctor_schedule_and_patient.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/domain/repositories/doctor_schedule_and_patient_repository.dart';

import '/core/network/failures/failures.dart';
import '/core/network/failures/failures_generic.dart';
import 'package:dartz/dartz.dart';

import 'doctor_schedule_usecase_and_patient.dart';

class DoctorScheduleUsecaseAndPatientImpl implements DoctorScheduleUsecaseAndPatient {
  final DoctorScheduleAndPatientRepository repository;

  DoctorScheduleUsecaseAndPatientImpl(this.repository);
  @override
  Future<Either<Failures, ResponseDoctorScheduleAndPatient>> doctorScheduleAndPatient(QueryParameters req, Headers headers) async {
    try {
      if (req.props.isEmpty) {
        return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      }
      return repository.doctorScheduleAndPatientRepository(req, headers);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
