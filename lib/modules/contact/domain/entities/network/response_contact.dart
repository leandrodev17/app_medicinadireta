import 'package:medicinadireta/modules/contact/domain/entities/contact.dart';
import 'package:equatable/equatable.dart';

class ResponseContact extends Equatable {
  final List<Contact>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseContact({this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
