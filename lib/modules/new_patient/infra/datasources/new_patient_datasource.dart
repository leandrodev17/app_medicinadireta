import 'package:medicinadireta/modules/new_patient/domain/entities/network/request_new_patient.dart';
import 'package:medicinadireta/modules/new_patient/infra/models/network/response_new_patient_ext.dart';

abstract class NewPatientDatasource {
  Future<ResponseNewPatientExt> saveNewPatientDatasource(RequestNewPatient params);
}
