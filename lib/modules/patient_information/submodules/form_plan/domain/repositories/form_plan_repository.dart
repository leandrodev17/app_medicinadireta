import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:medicinadireta/modules/patient_information/submodules/form_plan/domain/entities/network/response_form_plan.dart';

abstract class FormPlanRepository {
  Future<Either<Failures, ResponseFormPlan>> findAllFormPlanRepository(int pacientId, QueryParameters parameters);
}

