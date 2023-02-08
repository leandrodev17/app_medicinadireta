import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/modules/contact/infra/datasources/contatc_datasource.dart';
import 'package:medicinadireta/modules/contact/infra/models/network/response_contact_ext.dart';

class ContactDatasourceImpl implements ContactDatasource {
  final Network _network;
  ContactDatasourceImpl(this._network);

  @override
  Future<ResponseContactExt> findContactDatasource() async {
    final response = await _network.get(AppUrl.contacts);
    if (response.statusCode != 200) {
      var _statusMessage = response.statusMessage;
      var _statusCode = response.statusCode;
      return ResponseContactExt.fromMap(statusCode: _statusCode, statusMessage: _statusMessage, data: []);
    }
    return ResponseContactExt.fromMap(statusCode: response.statusCode, data: response.data['value'] ?? []);
  }
}
