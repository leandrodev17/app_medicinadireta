import 'package:dartz/dartz.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/domain/entities/network/response_exams.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/domain/repositories/exams_repository.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/domain/usecases/exams_usecase.dart';

import '/core/models/request/query_parameters.dart';
import '/core/network/failures/failures.dart';
import '/core/network/failures/failures_generic.dart';



class ExamsUsecaseImpl implements ExamsUsecase {
  final ExamsRepository repository;

  ExamsUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseExams>> findExamsUsecase(int pacientId, QueryParameters parameters) async {
    try {
      if (pacientId == 0) return left(FailureGeneric(message: 'Falha de sistema, não foi possível efetuar a listagem'));
      return repository.findAllExamsRepository(pacientId, parameters);
    } catch (e) {
      return left(FailureGeneric(message: 'Falha de sistema, não foi possível efetuar a listagem'));
    }
  }
}
