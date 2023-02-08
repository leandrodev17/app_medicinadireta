import 'package:medicinadireta/modules/patient_information/submodules/form_plan/infra/models/network/response_form_plan_ext.dart';


abstract class FormPlanDatasource {
  Future<ResponseFormPlanExt> findAllFormPlanDatasource(int pacientId);
}
