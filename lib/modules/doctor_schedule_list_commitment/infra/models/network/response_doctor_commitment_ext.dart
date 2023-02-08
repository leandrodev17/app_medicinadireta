import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/response_doctor_commitment.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/doctor_commitment_ext.dart';

class ResponseDoctorCommitmentExt extends ResponseDoctorCommitment {
  final List<DoctorCommitmentExt> model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseDoctorCommitmentExt({this.statusCode, this.statusMessage, this.errorMessage, required this.model});

  factory ResponseDoctorCommitmentExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseDoctorCommitmentExt(
      model: data != null ? data.map<DoctorCommitmentExt>((data) => DoctorCommitmentExt.fromMap(data)).toList() : [],
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
