import 'dart:convert';

import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/network/request_communication.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/infra/datasources/communication_datasource.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/infra/models/network/response_communication_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/infra/models/network/response_communication_sms_ext.dart';

class CommunicationDatasourceImpl implements CommunicationDatasource {
  final Network _network;
  CommunicationDatasourceImpl(this._network);

  @override
  Future<ResponseCommunicationExt> saveCommunicationDatasource(RequestCommunication params) async {
    final response = await _network.post(AppUrl.communication, body: params, isAuth: true);
    var statusMessage = response.statusMessage;
    var statusCode = response.statusCode;
    if (statusCode != 201) {
      return ResponseCommunicationExt.fromMap(statusCode: statusCode, statusMessage: statusMessage, data: null);
    }
    return ResponseCommunicationExt.fromMap(statusCode: statusCode, statusMessage: statusMessage, data: response.data);
  }

  @override
  Future<ResponseCommunicationSmsExt> sendSMSCommunicationDatasource(RequestCommunication params) async {
    final response = await _network.post(AppUrl.communicationSms, body: params, isAuth: true);

    var statusMessage = response.statusMessage;
    var statusCode = response.statusCode;
    if (response.statusCode != 200) {
      return ResponseCommunicationSmsExt.fromMap(statusCode: statusCode, statusMessage: statusMessage, data: null);
    }
    return ResponseCommunicationSmsExt.fromMap(statusCode: response.statusCode, data: response.data);
  }
}
