import 'package:equatable/equatable.dart';

import '../../infra/models/response_authentication.dart';

class ResponseServerAuthentication extends Equatable {
  final int? statusCode;
  final String? statusMessage;
  final ResponseAuthentication? model;

  ResponseServerAuthentication({this.statusCode, this.statusMessage, this.model});

  factory ResponseServerAuthentication.fromMap({int? statusCode, String? statusMessage, dynamic data}) {
    return ResponseServerAuthentication(
      statusCode: statusCode,
      statusMessage: statusMessage,
      model: data == null ? null : ResponseAuthentication.fromMap(data),
    );
  }
  @override
  List<Object> get props => [statusCode!, statusMessage!, model!];
}
