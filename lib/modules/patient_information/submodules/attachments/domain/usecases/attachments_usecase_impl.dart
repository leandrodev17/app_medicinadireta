import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/core/network/failures/failures_generic.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/entities/network/request_attachments_save.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/entities/network/response_attachments.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/repositories/attachments_repository.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/usecases/attachments_usecase.dart';
import 'package:dartz/dartz.dart';

class AttachmentsUsecaseImpl implements AttachmentsUsecase {
  final AttachmentsRepository repository;

  AttachmentsUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseAttachments>> findByAttachments(int attachmentId) async {
    try {
      return repository.findAttachmentRepository(attachmentId);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponseAttachments>> listAttachments(QueryParameters req, int patientId) async {
    try {
      if (req.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.listAttachmentsRepository(req, patientId);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponseAttachments>> saveByAttachments(int pacienteId, RequestAttachmentsSave request) async {
     try {
      if (pacienteId == 0) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.saveAttachmentRepository(pacienteId, request);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
