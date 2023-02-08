import 'package:equatable/equatable.dart';

import '../anamnese.dart';

class ResponseAnamnese extends Equatable {
  final List<Anamnese>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseAnamnese({this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}