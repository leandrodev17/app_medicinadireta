import 'package:medicinadireta/modules/contact/domain/entities/network/response_contact.dart';
import 'package:medicinadireta/modules/contact/infra/models/contact_ext.dart';

class ResponseContactExt extends ResponseContact {
  final List<ContactExt>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final String? odata;

  ResponseContactExt({this.statusCode, this.statusMessage, this.errorMessage, this.odata, required this.model});

  factory ResponseContactExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseContactExt(
      model: data?.map<ContactExt>((data) => ContactExt.fromMap(data)).toList(),
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      odata: odata,
    );
  }
}
