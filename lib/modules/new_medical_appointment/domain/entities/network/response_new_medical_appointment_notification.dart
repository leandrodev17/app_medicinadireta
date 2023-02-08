import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/new_medical_appointment_notification.dart';
import 'package:equatable/equatable.dart';

class ResponseNewMedicalAppointmentNotification extends Equatable {
  final NewMedicalAppointmentNotification? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseNewMedicalAppointmentNotification(
      {this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
