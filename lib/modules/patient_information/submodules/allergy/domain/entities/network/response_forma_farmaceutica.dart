import 'package:equatable/equatable.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/forma_farmaceutica.dart';


class ResponseFormaFarmaceutica extends Equatable {
  final List<FormaFarmaceutica>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  const ResponseFormaFarmaceutica({this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}