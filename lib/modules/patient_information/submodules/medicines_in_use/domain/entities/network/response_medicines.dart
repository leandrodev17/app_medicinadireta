import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/domain/entities/medicines_in_use.dart';
import 'package:equatable/equatable.dart';

class ResponseMedicinesInUse extends Equatable {
  final List<MedicinesInUse>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseMedicinesInUse(
      {this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
