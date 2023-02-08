import 'package:equatable/equatable.dart';

import '../allergy.dart';

class ResponseAllergy extends Equatable {
  final List<Allergy>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  const ResponseAllergy({this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
