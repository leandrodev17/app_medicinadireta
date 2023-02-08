import 'package:equatable/equatable.dart';

import '../ciap.dart';

class ResponseCiap extends Equatable {
  final List<Ciap>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseCiap({this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
