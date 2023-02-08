import 'package:medicinadireta/core/models/patient/patient_model.dart';
import 'package:equatable/equatable.dart';

class ResponsePatient extends Equatable {
  final List<PatientModel>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponsePatient(
      {this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
