import 'package:medicinadireta/modules/financial/domain/entities/network/response_service_order.dart';
import 'package:medicinadireta/modules/financial/infra/models/service_order_ext.dart';

class ResponseServiceOrderExt extends ResponseServiceOrder {
  final List<ServiceOrderExt> model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final String? odata;

  ResponseServiceOrderExt({this.statusCode, this.statusMessage, this.errorMessage, this.odata, required this.model});

  factory ResponseServiceOrderExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseServiceOrderExt(
      model: data!.map<ServiceOrderExt>((data) => ServiceOrderExt.fromMap(data)).toList(),
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      odata: odata,
    );
  }
}