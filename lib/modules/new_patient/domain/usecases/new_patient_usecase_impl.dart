import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/core/network/failures/failures_generic.dart';
import 'package:medicinadireta/modules/new_patient/domain/entities/network/request_new_patient.dart';
import 'package:medicinadireta/modules/new_patient/domain/entities/network/response_new_patient.dart';
import 'package:medicinadireta/modules/new_patient/domain/repositories/new_patient_repository.dart';
import 'package:medicinadireta/modules/new_patient/domain/usecases/new_patient_usecase.dart';
import 'package:dartz/dartz.dart';

class NewPatientUsecaseImpl implements NewPatientUsecase {
  final NewPatientRepository repository;

  NewPatientUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseNewPatient>> saveByNewPatient(RequestNewPatient params) async {
    try {
      if (params.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.saveNewPatientRepository(params);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
