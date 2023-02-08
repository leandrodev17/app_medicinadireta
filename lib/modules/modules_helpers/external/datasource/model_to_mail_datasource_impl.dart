import 'dart:convert';

import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/request_new_phone.dart';
import 'package:medicinadireta/modules/modules_helpers/infra/datasources/model_to_mail_datasource.dart';
import 'package:medicinadireta/modules/modules_helpers/infra/models/network/response_model_to_mail_ext.dart';
import 'package:medicinadireta/modules/modules_helpers/infra/models/network/response_model_to_sms_ext.dart';
import 'package:medicinadireta/modules/modules_helpers/infra/models/network/response_new_phone_ext.dart';

class ModelToMailDatasourceImpl implements ModelToMailDatasource {
  final Network _network;
  ModelToMailDatasourceImpl(this._network);

  @override
  Future<ResponseModelToMailExt> findModelToMailDatasource() async {
    final response = await _network.get(AppUrl.emailModels);
    if (response.statusCode != 200) {
      var _statusMessage = response.statusMessage;
      var _statusCode = response.statusCode;
      return ResponseModelToMailExt.fromMap(statusCode: _statusCode, statusMessage: _statusMessage, data: []);
    }
    return ResponseModelToMailExt.fromMap(statusCode: response.statusCode, data: response.data ?? []);
  }

  @override
  Future<ResponseModelToSmsExt> findModelToSmsDatasource() async {
    final response = await _network.get(AppUrl.smsModels);
    if (response.statusCode != 200) {
      var _statusMessage = response.statusMessage;
      var _statusCode = response.statusCode;
      return ResponseModelToSmsExt.fromMap(statusCode: _statusCode, statusMessage: _statusMessage, data: []);
    }
    return ResponseModelToSmsExt.fromMap(statusCode: response.statusCode, data: response.data ?? []);
  }

  @override
  Future<ResponseNewPhoneExt> saveNewPhoneDatasource(RequestNewPhone request, int patientId) async {
    try {
      final response = await _network.post(AppUrl.savePatientPhone(patientId), body: request, isAuth: true);
      if (response.statusCode == null) return ResponseNewPhoneExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);

      dynamic _data;
      dynamic statusMessage;

      if (response.data != null) {
        if (response.statusCode != 200) {
          String _encode = jsonEncode(response.data.toString());
          if (_encode.contains("value")) {
            statusMessage = response.data["value"];
          }
          _data = null;
        } else {
          _data = response.data;
        }
      }

      return ResponseNewPhoneExt.fromMap(statusCode: response.statusCode, data: _data, statusMessage: statusMessage);
    } on Exception catch (e, s) {
      AppLog.d("Problema para salvar o telefone  $e", stackTrace: s, name: 'saveNewPhoneDatasource');
      return ResponseNewPhoneExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
    }
  }
}
