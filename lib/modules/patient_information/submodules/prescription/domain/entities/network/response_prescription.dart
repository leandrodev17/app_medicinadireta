import 'package:equatable/equatable.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/domain/entities/prescription_entitie.dart';



class ResponsePrescription extends Equatable {
  final List<PrescriptionEntitie>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  const ResponsePrescription({this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
