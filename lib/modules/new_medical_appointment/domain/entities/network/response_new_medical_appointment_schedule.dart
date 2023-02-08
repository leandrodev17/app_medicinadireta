import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/new_medical_appointment_schedule.dart';
import 'package:equatable/equatable.dart';

class ResponseNewMedicalAppointmentSchedule extends Equatable {
  final NewMedicalAppointmentSchedule? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseNewMedicalAppointmentSchedule(
      {this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
