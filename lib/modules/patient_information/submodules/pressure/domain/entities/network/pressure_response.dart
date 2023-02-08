import 'package:equatable/equatable.dart';

import '../pressure_entitie.dart';

class PressureResponse extends Equatable {
  final List<PressureEntitie>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  const PressureResponse({this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
