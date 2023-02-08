import 'package:equatable/equatable.dart';
import 'package:medicinadireta/modules/patient_information/submodules/form_plan/domain/entities/form_plan_entitie.dart';



class ResponseFormPlan extends Equatable {
  final List<FormPlanEntitie>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  const ResponseFormPlan({this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
