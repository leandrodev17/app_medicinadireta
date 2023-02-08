import 'package:equatable/equatable.dart';

import '../anthropometry_entitie.dart';

class AnthropometryResponse extends Equatable {
  final List<AnthropometryEntitie>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  const AnthropometryResponse({this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
