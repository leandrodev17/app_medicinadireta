import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/entities/network/request_attachments_save.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/entities/network/response_attachments.dart';

import 'package:dartz/dartz.dart';

abstract class AttachmentsUsecase {
  Future<Either<Failures, ResponseAttachments>> saveByAttachments(int attachmentId, RequestAttachmentsSave request);
  Future<Either<Failures, ResponseAttachments>> findByAttachments(int attachmentId);
  Future<Either<Failures, ResponseAttachments>> listAttachments(QueryParameters req, int patientId);
}
