import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/communication.dart';
import 'package:equatable/equatable.dart';

class ResponseCommunication extends Equatable {
  final Communication? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  const ResponseCommunication({this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
