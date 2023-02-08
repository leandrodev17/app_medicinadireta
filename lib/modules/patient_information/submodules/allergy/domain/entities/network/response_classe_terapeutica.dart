import 'package:equatable/equatable.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/classe_terapeutica.dart';


class ResponseClasseTerapeutica extends Equatable {
  final List<ClasseTerapeutica>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  const ResponseClasseTerapeutica({this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}

