import 'dart:convert';

import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';

import '/core/network/network.dart';
import '/modules/authentication/domain/entities/params_authentication.dart';
import '/modules/authentication/infra/datasources/authentication_datasource.dart';
import '/modules/authentication/domain/entities/response_server_authentication.dart';

class AuthenticationDatasourceImpl implements AuthenticationDatasource {
  final Network _network;
  AuthenticationDatasourceImpl(this._network);

  @override
  Future<ResponseServerAuthentication> authenticationDatasource(ParamsAuthentication req) async {
    try {
      final response = await _network.post(AppUrl.auth, body: req);

      if (response.statusCode == null) {
        return ResponseServerAuthentication.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
      }

      dynamic dataResponse;
      String? statusMessage = response.statusMessage;
      int? statusCode = response.statusCode;

      if (response.data != null) {
        var encode = json.encode(response.data.toString());
        if (encode.contains("value")) {
          dataResponse = null;
          statusMessage = response.data["value"];
        } else {
          dataResponse = Map<String, dynamic>.from(response.data);
        }
      }

      return ResponseServerAuthentication.fromMap(statusCode: statusCode, statusMessage: statusMessage, data: dataResponse);
    } catch (e) {
      AppLog.d('Não foi possível efetuar o login $e', name: 'authenticationDatasource');
      return ResponseServerAuthentication.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
    }
  }
}
