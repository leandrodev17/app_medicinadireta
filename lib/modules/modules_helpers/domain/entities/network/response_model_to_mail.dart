import 'package:medicinadireta/modules/modules_helpers/domain/entities/model_to_mail.dart';
import 'package:equatable/equatable.dart';

class ResponseModelToMail extends Equatable {
  final List<ModelToMail>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseModelToMail({this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
