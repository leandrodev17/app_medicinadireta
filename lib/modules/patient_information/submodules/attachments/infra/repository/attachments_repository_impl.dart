import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/datasource_error.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/entities/network/request_attachments_save.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/entities/network/response_attachments.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/repositories/attachments_repository.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/infra/datasources/attachments_datasource.dart';

import 'package:dartz/dartz.dart';

class AttachmentsRepositoryImpl implements AttachmentsRepository {
  final AttachmentsDatasource datasource;

  AttachmentsRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseAttachments>> findAttachmentRepository(int attachmentId) async {
    try {
      final result = await datasource.findAttachmentsDatasource(attachmentId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseAttachments>> listAttachmentsRepository(QueryParameters req, int patientId) async {
    try {
      final result = await datasource.listAttachmentsDatasource(req, patientId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseAttachments>> saveAttachmentRepository(int pacienteId, RequestAttachmentsSave request) async {
    try {
      final result = await datasource.saveAttachmentsDatasource(pacienteId, request);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
