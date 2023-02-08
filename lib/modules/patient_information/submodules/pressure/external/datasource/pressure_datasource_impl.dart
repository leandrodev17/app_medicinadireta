import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/patient_information/submodules/pressure/infra/datasources/pressure_datasource.dart';
import 'package:medicinadireta/modules/patient_information/submodules/pressure/infra/models/network/pressure_response_ext.dart';

class PressureDatasourceImpl implements PressureDatasource {
  final Network _network;
  PressureDatasourceImpl(this._network);

  @override
  Future<PressureResponseExt> findAllPressureDatasource(int pacientId) async {
    try {
      final response = await _network.get(AppUrl.findAllPressurePatientId(pacientId));
      AppLog.w("$response");

      if (response.statusCode == null) {
        return PressureResponseExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT);
      }

      return PressureResponseExt.fromMap(statusCode: response.statusCode, data: response.data['value'] ?? [], statusMessage: response.statusMessage);
    } catch (e, s) {
      AppLog.d("Problema para listar os dados da receita $e", stackTrace: s, name: "_findAllPrescriptionDatasource");
      return PressureResponseExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString());
    }
  }
}
