import 'package:dartz/dartz.dart';
import 'package:medicinadireta/modules/patient_information/submodules/form_plan/domain/entities/network/response_form_plan.dart';
import 'package:medicinadireta/modules/patient_information/submodules/form_plan/domain/repositories/form_plan_repository.dart';
import 'package:medicinadireta/modules/patient_information/submodules/form_plan/domain/usecases/form_plan_usecase.dart';

import '/core/models/request/query_parameters.dart';
import '/core/network/failures/failures.dart';
import '/core/network/failures/failures_generic.dart';



class FormPlanUsecaseImpl implements FormPlanUsecase {
  final FormPlanRepository repository;

  FormPlanUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseFormPlan>> findFormPlanUsecase(int pacientId, QueryParameters parameters) async {
    try {
      if (pacientId == 0) return left(FailureGeneric(message: 'Falha de sistema, não foi possível efetuar a listagem'));
      return repository.findAllFormPlanRepository(pacientId, parameters);
    } catch (e) {
      return left(FailureGeneric(message: 'Falha de sistema, não foi possível efetuar a listagem'));
    }
  }
}
