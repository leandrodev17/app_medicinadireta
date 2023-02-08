import 'package:equatable/equatable.dart';

import '../cid_sub_categoria.dart';

class ResponseCidSubCategory extends Equatable {
  final List<CidSubCategoria>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseCidSubCategory({this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}