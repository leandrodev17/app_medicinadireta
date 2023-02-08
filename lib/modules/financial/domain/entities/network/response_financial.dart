import 'package:medicinadireta/core/models/patient/patient_model.dart';
import 'package:equatable/equatable.dart';

class ResponseFinancial extends Equatable {
  final List<PatientModel>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseFinancial(
      {this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
