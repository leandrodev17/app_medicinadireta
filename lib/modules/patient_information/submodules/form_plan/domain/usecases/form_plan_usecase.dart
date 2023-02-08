import 'package:medicinadireta/modules/patient_information/submodules/form_plan/domain/entities/network/response_form_plan.dart';

import '/core/models/request/query_parameters.dart';
import '/core/network/failures/failures.dart';

import 'package:dartz/dartz.dart';

abstract class FormPlanUsecase {
  Future<Either<Failures, ResponseFormPlan>> findFormPlanUsecase(int pacientId, QueryParameters parameters);
}
