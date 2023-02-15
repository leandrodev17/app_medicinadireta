
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/change_password/domain/entities/network/request_change_password.dart';
import 'package:medicinadireta/modules/change_password/infra/datasources/change_password_datasource.dart';
import 'package:medicinadireta/modules/change_password/infra/models/network/response_change_password_ext.dart';

class ChangePasswordDatasourceImpl implements ChangePasswordDatasource {
  final Network _network;
  ChangePasswordDatasourceImpl(this._network);

  @override
  Future<ResponseChangePasswordExt> saveChangePasswordDatasource(RequestChangePassword req) async {
    final response = await _network.put(AppUrl.auth, body: req);
    if (response.statusCode != 200) {
      return ResponseChangePasswordExt.fromMap(statusCode: response.statusCode, statusMessage: response.statusMessage, data: null);
    }
    return ResponseChangePasswordExt.fromMap(
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      data: response.data,
    );
  }
}
