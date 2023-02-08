import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/modules/patient_information/submodules/form_plan/infra/datasources/form_plan_datasource.dart';
import 'package:medicinadireta/modules/patient_information/submodules/form_plan/infra/models/network/response_form_plan_ext.dart';

class FormPlanDatasourceImpl implements FormPlanDatasource {
  final Network _network;
  FormPlanDatasourceImpl(this._network);

  @override
  Future<ResponseFormPlanExt> findAllFormPlanDatasource(int pacientId) async {
    try {
      final resp = await _network.get(AppUrl.findAllFormPlanPatientId(pacientId), isAuth: true);
      if (resp.statusCode == null) {
        return ResponseFormPlanExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT);
      }
      return ResponseFormPlanExt.fromMap(statusCode: resp.statusCode, data: resp.data['value'], statusMessage: resp.statusMessage);
    } catch (e) {
      return ResponseFormPlanExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString());
    }
  }
}
