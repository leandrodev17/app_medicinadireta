import 'package:equatable/equatable.dart';

import '../communication_sms.dart';

class ResponseCommunicationSms extends Equatable {
  final ComunicationSms? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseCommunicationSms(
      {this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
