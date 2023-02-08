import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/evolution.dart';

class ResponseEvolution {
  final List<Evolution>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseEvolution({this.statusCode, this.statusMessage, this.errorMessage, this.model});
}
