import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/entities/attachments.dart';

class ResponseAttachments {
  final List<Attachments>? model;
  final Attachments? responseAttachment;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final String? blob;

  ResponseAttachments({this.statusCode, this.statusMessage, this.errorMessage, this.model, this.blob, this.responseAttachment});
}
