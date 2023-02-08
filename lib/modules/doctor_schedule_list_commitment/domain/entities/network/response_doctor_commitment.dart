import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/doctor_commitment.dart';

class ResponseDoctorCommitment {
  final List<DoctorCommitment>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseDoctorCommitment({this.statusCode, this.statusMessage, this.errorMessage, this.model});
}
