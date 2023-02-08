import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/infra/datasources/prescription_datasource.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/infra/models/network/response_prescription_ext.dart';

class PrescriptionDatasourceImpl implements PrescriptionDatasource {
  final Network _network;
  PrescriptionDatasourceImpl(this._network);

  @override
  Future<ResponsePrescriptionExt> findAllPrescriptionDatasource(int pacientId) async {
    try {
      final response = await _network.get(AppUrl.findAllPrescriptionPatientId(pacientId));
      // AppLog.w("$response");

      if (response.statusCode == null) {
        return ResponsePrescriptionExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT);
      }

      return ResponsePrescriptionExt.fromMap(statusCode: response.statusCode, data: response.data['value'] ?? [], statusMessage: response.statusMessage);
    } catch (e, s) {
      AppLog.d("Problema para listar os dados da receita $e", stackTrace: s, name: "_findAllPrescriptionDatasource");
      return ResponsePrescriptionExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString());
    }
  }
}
