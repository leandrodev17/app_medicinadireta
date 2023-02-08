import 'package:medicinadireta/modules/financial/domain/entities/service_order.dart';
import 'package:equatable/equatable.dart';

class ResponseServiceOrder extends Equatable {
  final List<ServiceOrder>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseServiceOrder(
      {this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, errorMessage, model];
}
