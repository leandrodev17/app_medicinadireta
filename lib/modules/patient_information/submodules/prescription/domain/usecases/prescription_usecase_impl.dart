import 'package:dartz/dartz.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/domain/entities/network/response_prescription.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/domain/repositories/prescription_repository.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/domain/usecases/prescription_usecase.dart';

import '/core/models/request/query_parameters.dart';
import '/core/network/failures/failures.dart';
import '/core/network/failures/failures_generic.dart';



class PrescriptionUsecaseImpl implements PrescriptionUsecase {
  final PrescriptionRepository repository;

  PrescriptionUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponsePrescription>> findPrescriptionUsecase(int pacientId, QueryParameters parameters) async {
    try {
      if (pacientId == 0) return left(FailureGeneric(message: 'Falha de sistema, não foi possível efetuar a listagem'));
      return repository.findAllPrescriptionRepository(pacientId, parameters);
    } catch (e) {
      return left(FailureGeneric(message: 'Falha de sistema, não foi possível efetuar a listagem'));
    }
  }
}
