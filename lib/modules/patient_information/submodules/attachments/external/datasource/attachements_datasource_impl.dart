import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/entities/network/request_attachments_save.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/infra/datasources/attachments_datasource.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/infra/models/network/response_attachments_ext.dart';

class AttachmentsDatasourceImpl implements AttachmentsDatasource {
  final Network _network;
  AttachmentsDatasourceImpl(this._network);

  @override
  Future<ResponseAttachmentsExt> findAttachmentsDatasource(int attachmentId) async {
    try {
      final response = await _network.get(AppUrl.getFindAttachments(attachmentId));
      if (response.statusCode == null) return ResponseAttachmentsExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: []);
      var _statusMessage = response.statusMessage;
      var _statusCode = response.statusCode;
      return ResponseAttachmentsExt.fromMap(statusCode: _statusCode, statusMessage: _statusMessage, data: response.data);
    } catch (e) {
      AppLog.d('Não foi possível pesquisar o anexos pelo cod informado $e', name: 'findAttachmentsDatasource');
      return ResponseAttachmentsExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: []);
    }
  }

  @override
  Future<ResponseAttachmentsExt> listAttachmentsDatasource(QueryParameters req, int patientId) async {
    try {
      final response = await _network.get(AppUrl.getListAttachments(patientId), body: req);
      if (response.statusCode == null) return ResponseAttachmentsExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: []);
      var _statusMessage = response.statusMessage;
      var _statusCode = response.statusCode;
      return ResponseAttachmentsExt.fromMap(statusCode: _statusCode, statusMessage: _statusMessage, data: response.data['value']);
    } catch (e) {
      AppLog.d('Não foi possível listar os anexos $e', name: 'listAttachmentsDatasource');
      return ResponseAttachmentsExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: []);
    }
  }

  @override
  Future<ResponseAttachmentsExt> saveAttachmentsDatasource(int pacienteId, RequestAttachmentsSave request) async {
    try {
      final response = await _network.post(AppUrl.saveAttachments(pacienteId), body: request, isAuth: true);
      if (response.statusCode == null) {
        return ResponseAttachmentsExt.fromMap(
          statusCode: STATUS_CODE_DEFAULT,
          statusMessage: STATUS_MESSAGE_DEFAULT,
          data: null,
          responseAttachment: null,
          errorMessage: null,
        );
      }
      var statusMessage = response.statusMessage;
      var statusCode = response.statusCode;
      return ResponseAttachmentsExt.fromMap(statusCode: statusCode, statusMessage: statusMessage, responseAttachment: response.data);
    } catch (e, s) {
      AppLog.d('Não foi possível salvar o anexo $e', name: 'saveAttachmentsDatasource', stackTrace: s);
      return ResponseAttachmentsExt.fromMap(
        statusCode: STATUS_CODE_DEFAULT,
        statusMessage: STATUS_MESSAGE_DEFAULT,
        data: null,
        responseAttachment: null,
        errorMessage: null,
      );
    }
  }
}
