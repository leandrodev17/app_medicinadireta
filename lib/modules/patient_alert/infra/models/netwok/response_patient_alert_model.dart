import 'package:medicinadireta/modules/patient_alert/domain/entity/network/response_patient_alert_entity.dart';
import 'package:medicinadireta/modules/patient_alert/infra/models/patient_alert_model.dart';

class ResponsePatientAlertModel extends ResponsePatientAlertEntity {
  const ResponsePatientAlertModel({super.statusCode, super.statusMessage, super.errorMessage, super.model});

  factory ResponsePatientAlertModel.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage}) {
    return ResponsePatientAlertModel(
      model: data?.map<PatientAlertModel>((data) => PatientAlertModel.fromMap(data)).toList() ?? [],
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
