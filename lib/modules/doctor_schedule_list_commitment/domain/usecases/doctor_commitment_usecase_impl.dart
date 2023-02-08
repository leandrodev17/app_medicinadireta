import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/core/network/failures/failures_generic.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/params_doctor_commitment.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/params_doctor_commitment_headers.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/response_doctor_commitment.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/response_patient.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/repositories/doctor_commitment_repository.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/usecases/doctor_commitment_usecase.dart';
import 'package:dartz/dartz.dart';

class DoctorCommitmentUsecaseImpl implements DoctorCommitmentUsecase {
  final DoctorCommitmentRepository repository;

  DoctorCommitmentUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseDoctorCommitment>> doctorByCommitment(ParamsDoctorCommitment req, ParamsDoctorCommitmentHeaders headers) async {
    try {
      if (req.props.isEmpty || headers.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.doctorCommitmentRepository(req, headers);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponsePatient>> byPatient(ParamsDoctorCommitment req, int patientId) async {
   try {
      if (req.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.findPatientRepository(req, patientId);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
