import 'package:equatable/equatable.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/domain/entities/exams_entitie.dart';



class ResponseExams extends Equatable {
  final List<ExamsEntitie>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  const ResponseExams({this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
