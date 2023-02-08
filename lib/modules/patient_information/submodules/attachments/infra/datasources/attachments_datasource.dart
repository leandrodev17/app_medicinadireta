import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/entities/network/request_attachments_save.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/infra/models/network/response_attachments_ext.dart';

abstract class AttachmentsDatasource {
  Future<ResponseAttachmentsExt> listAttachmentsDatasource(QueryParameters req, int patientId);
  Future<ResponseAttachmentsExt> findAttachmentsDatasource(int attachmentId);
  Future<ResponseAttachmentsExt> saveAttachmentsDatasource(int pacienteId, RequestAttachmentsSave request);
}
