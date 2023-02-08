import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/domain/entities/network/response_exams.dart';

abstract class ExamsRepository {
  Future<Either<Failures, ResponseExams>> findAllExamsRepository(int pacientId, QueryParameters parameters);
}

