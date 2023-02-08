import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/patient_alert/infra/models/netwok/response_patient_alert_model.dart';

abstract class PatientAlertDatasource {
  Future<ResponsePatientAlertModel> listAlertPatientDatasource(QueryParameters parameters);
}


