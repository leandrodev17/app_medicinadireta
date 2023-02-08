import 'package:medicinadireta/modules/patient_information/submodules/exams/domain/entities/network/response_exams.dart';

import '/core/models/request/query_parameters.dart';
import '/core/network/failures/failures.dart';

import 'package:dartz/dartz.dart';

abstract class ExamsUsecase {
  Future<Either<Failures, ResponseExams>> findExamsUsecase(int pacientId, QueryParameters parameters);
}
