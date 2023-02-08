import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/params_doctor_commitment.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/params_doctor_commitment_headers.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/network/response_doctor_commitment_ext.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/network/response_patient_ext.dart';

abstract class DoctorCommitmentDatasource {
  Future<ResponseDoctorCommitmentExt> doctorCommitmentDatasource(ParamsDoctorCommitment req, ParamsDoctorCommitmentHeaders headers);
  Future<ResponsePatientExt> patientDatasource(ParamsDoctorCommitment req, int patientId);
}
