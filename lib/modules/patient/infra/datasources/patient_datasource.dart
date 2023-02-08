import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/patient/infra/models/network/response_patient_ext.dart';

abstract class PatientDatasource {
  Future<ResponsePatientExt> findPatientDatasource(QueryParameters parameters, {int limit = 20, int offset = 0, int id = 0, String nome = "''", String cpf = "''"});
  Future<ResponsePatientExt> listPatientDatasource(QueryParameters parameters, {int limit = 20, int offset = 0, int id = 0, String nome = "''", String cpf = "''"});
  Future<ResponsePatientExt> findPatientIdDatasource(QueryParameters parameters, int patientId);
}
