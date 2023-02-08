
import 'package:medicinadireta/modules/change_password/domain/entities/change_password.dart';

class ResponseChangePassword {
  final ChangePassword? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseChangePassword({this.statusCode, this.statusMessage, this.errorMessage, this.model});
}
