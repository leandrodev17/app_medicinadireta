import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/infra/datasources/medicines_in_use_datasource.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/infra/models/network/response_medicines_ext.dart';

class MedicinesInUseDatasourceImpl implements MedicinesInUseDatasource {
  final Network _network;
  MedicinesInUseDatasourceImpl(this._network);

  @override
  Future<ResponseMedicinesInUseExt> findMedicinesInUseDatasource(QueryParameters parameters, int patientId) async {
    final response = await _network.get(AppUrl.getMedicineInUse(patientId),body: parameters);
    if (response.statusCode != 200) {
      var _statusMessage = response.statusMessage;
      var _statusCode = response.statusCode;
      return ResponseMedicinesInUseExt.fromMap(statusCode: _statusCode, statusMessage: _statusMessage, data: null);
    }
    return ResponseMedicinesInUseExt.fromMap(statusCode: response.statusCode, data: response.data['value'] ?? null);
  }
}
