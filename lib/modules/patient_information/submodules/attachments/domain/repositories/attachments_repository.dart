import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/entities/network/request_attachments_save.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/entities/network/response_attachments.dart';
import 'package:dartz/dartz.dart';

abstract class AttachmentsRepository {
  Future<Either<Failures, ResponseAttachments>> listAttachmentsRepository(QueryParameters req, int patientId);
  Future<Either<Failures, ResponseAttachments>> findAttachmentRepository(int attachmentId);
  Future<Either<Failures, ResponseAttachments>> saveAttachmentRepository(int pacienteId, RequestAttachmentsSave request);
}
