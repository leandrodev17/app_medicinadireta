import 'package:equatable/equatable.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/medical.dart';


class ResponseMedical extends Equatable {
  final List<Medical>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final dynamic dataNewMedical;

  const ResponseMedical({this.statusCode, this.statusMessage, this.errorMessage, this.model, this.dataNewMedical});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model,dataNewMedical];
}
