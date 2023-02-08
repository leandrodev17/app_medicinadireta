import 'package:medicinadireta/modules/modules_helpers/domain/entities/model_to_sms.dart';
import 'package:equatable/equatable.dart';

class ResponseModelToSms extends Equatable {
  final List<ModelToSms>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseModelToSms({this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
