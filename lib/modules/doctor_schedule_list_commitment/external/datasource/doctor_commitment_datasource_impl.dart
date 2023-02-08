import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/params_doctor_commitment.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/params_doctor_commitment_headers.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/datasources/doctor_commitment_datasource.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/network/response_doctor_commitment_ext.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/network/response_patient_ext.dart';

class DoctorCommitmentDatasourceImpl implements DoctorCommitmentDatasource {
  final Network _network;
  DoctorCommitmentDatasourceImpl(this._network);

  @override
  Future<ResponseDoctorCommitmentExt> doctorCommitmentDatasource(ParamsDoctorCommitment req, ParamsDoctorCommitmentHeaders headers) async {
    try {
      final response = await _network.get(AppUrl.schedule, body: req, headers: headers);
      // AppLog.i("response: $response");
      if (response.statusCode == null) return ResponseDoctorCommitmentExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
      return ResponseDoctorCommitmentExt.fromMap(statusCode: response.statusCode, statusMessage: response.statusMessage, data: response.data['value']);
    } catch (e) {
      return ResponseDoctorCommitmentExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
    }
  }

  @override
  Future<ResponsePatientExt> patientDatasource(ParamsDoctorCommitment req, int patientId) async {
    try {
      final response = await _network.get(AppUrl.pacienteTelefone(patientId), body: req);
      if (response.statusCode == null) return ResponsePatientExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
      return ResponsePatientExt.fromMap(statusCode: response.statusCode, statusMessage: response.statusMessage, data: response.data['value']);
    } catch (e) {
      return ResponsePatientExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
    }
  }
}
