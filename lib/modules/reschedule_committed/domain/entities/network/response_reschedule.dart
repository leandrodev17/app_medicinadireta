import 'package:equatable/equatable.dart';

class ResponseReschedule extends Equatable {
  final List<dynamic>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseReschedule(
      {this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
