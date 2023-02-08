import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/entities/network/response_attachments.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/infra/models/attachments_ext.dart';

class ResponseAttachmentsExt extends ResponseAttachments {
  // final List<AttachmentsExt>? model;
  // final AttachmentsExt? responseAttachment;
  // final int? statusCode;
  // final String? statusMessage;
  // final String? errorMessage;
  // final String? blob;

  ResponseAttachmentsExt({
    super.statusCode,
    super.statusMessage,
    super.errorMessage,
    required super.model,
    super.blob,
    super.responseAttachment,
  });

  factory ResponseAttachmentsExt.fromMap({
    List<dynamic>? data,
    int? statusCode,
    String? statusMessage,
    String? errorMessage,
    String? blob,
    dynamic responseAttachment,
  }) {
    return ResponseAttachmentsExt(
      model: data?.map<AttachmentsExt>((data) => AttachmentsExt.fromMap(data)).toList(),
      responseAttachment: responseAttachment != null ? AttachmentsExt.fromMap(responseAttachment) : null,
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      blob: blob,
    );
  }
}
