import 'auth_info_med.dart';

class ResponseAuthInfoMed {
  final AuthInfoMed? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseAuthInfoMed({this.statusCode, this.statusMessage, this.errorMessage, this.model});
}