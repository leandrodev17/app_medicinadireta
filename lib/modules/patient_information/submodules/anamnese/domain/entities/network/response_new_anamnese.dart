import 'package:equatable/equatable.dart';

class ResponseNewAnamnese extends Equatable {
  final dynamic model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseNewAnamnese(
      {this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}