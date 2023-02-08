import 'package:equatable/equatable.dart';

import 'package:medicinadireta/modules/patient_alert/domain/entity/patient_alert_entity.dart';

class ResponsePatientAlertEntity extends Equatable {
  final List<PatientAlertEntity>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  const ResponsePatientAlertEntity({this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
