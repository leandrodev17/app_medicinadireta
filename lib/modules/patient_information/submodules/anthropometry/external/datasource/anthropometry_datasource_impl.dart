import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anthropometry/infra/datasources/anthropometry_datasource.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anthropometry/infra/models/network/anthropometry_response_ext.dart';

class AnthropometryDatasourceImpl implements AnthropometryDatasource {
  final Network _network;
  AnthropometryDatasourceImpl(this._network);

  @override
  Future<AnthropometryResponseExt> findAllAnthropometryDatasource(int pacientId) async {
    try {
      final response = await _network.get(AppUrl.findAllAnthropometryPatientId(pacientId));
      AppLog.w("$response");

      if (response.statusCode == null) {
        return AnthropometryResponseExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT);
      }

      return AnthropometryResponseExt.fromMap(statusCode: response.statusCode, data: response.data['value'] ?? [], statusMessage: response.statusMessage);
    } catch (e, s) {
      AppLog.d("Problema para listar os dados da receita $e", stackTrace: s, name: "_findAllPrescriptionDatasource");
      return AnthropometryResponseExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString());
    }
  }
}
