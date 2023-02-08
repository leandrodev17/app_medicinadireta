import 'package:medicinadireta/modules/modules_helpers/domain/entities/model_new_phone.dart';
import 'package:equatable/equatable.dart';

class ResponseNewPhone extends Equatable {
  final ModelNewPhone? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseNewPhone({this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}