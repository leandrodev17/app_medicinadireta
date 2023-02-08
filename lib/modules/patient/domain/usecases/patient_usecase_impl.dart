import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/core/network/failures/failures_generic.dart';
import 'package:medicinadireta/modules/patient/domain/entities/network/response_patient.dart';
import 'package:medicinadireta/modules/patient/domain/repositories/patient_repository.dart';
import 'package:medicinadireta/modules/patient/domain/usecases/patient_usecase.dart';
import 'package:dartz/dartz.dart';

class PatientUsecaseImpl implements PatientUsecase {
  final PatientRepository repository;

  PatientUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponsePatient>> findByPatient(QueryParameters parameters) async {
    try {
      if (parameters.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.findPatientRepository(parameters);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponsePatient>> findByPatientId(QueryParameters parameters, int patientId) async {
    try {
      if (patientId == 0) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.findPatientIdRepository(parameters, patientId);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
