import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/modules/patient_alert/infra/datasources/patient_alert_datasource.dart';
import 'package:medicinadireta/modules/patient_alert/infra/models/netwok/response_patient_alert_model.dart';

class PatientAlertDatasourceImpl implements PatientAlertDatasource {
  final Network _network;
  PatientAlertDatasourceImpl(this._network);

  @override
  Future<ResponsePatientAlertModel> listAlertPatientDatasource(QueryParameters parameters) async {
    try {
      final response = await _network.get(AppUrl.findAllPacienteAviso, body: parameters);
      if (response.statusCode == null) return ResponsePatientAlertModel.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
      var _statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var _statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      return ResponsePatientAlertModel.fromMap(statusCode: _statusCode, data: response.data['value'], statusMessage: _statusMessage);
    } catch (e) {
      return ResponsePatientAlertModel.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: e.toString());
    }
  }
}
