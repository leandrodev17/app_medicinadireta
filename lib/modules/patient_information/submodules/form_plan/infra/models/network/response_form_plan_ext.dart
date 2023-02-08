import 'package:medicinadireta/modules/patient_information/submodules/form_plan/domain/entities/network/response_form_plan.dart';
import 'package:medicinadireta/modules/patient_information/submodules/form_plan/infra/models/form_plan_model.dart';



class ResponseFormPlanExt extends ResponseFormPlan {
  const ResponseFormPlanExt({statusCode, statusMessage, errorMessage, required model})
      : super(
          model: model,
          errorMessage: errorMessage,
          statusMessage: statusMessage,
          statusCode: statusCode,
        );

  factory ResponseFormPlanExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage}) {
    return ResponseFormPlanExt(
      model: data?.map<FormPlanModel>((data) => FormPlanModel.fromMap(data)).toList() ?? [],
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
