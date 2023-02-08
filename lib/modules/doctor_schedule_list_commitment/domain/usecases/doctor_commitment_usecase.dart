import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/params_doctor_commitment.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/params_doctor_commitment_headers.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/response_doctor_commitment.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/response_patient.dart';

import '/core/network/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class DoctorCommitmentUsecase {
  Future<Either<Failures, ResponseDoctorCommitment>> doctorByCommitment(ParamsDoctorCommitment req, ParamsDoctorCommitmentHeaders headers);
  Future<Either<Failures, ResponsePatient>> byPatient(ParamsDoctorCommitment req, int patientId);
}
