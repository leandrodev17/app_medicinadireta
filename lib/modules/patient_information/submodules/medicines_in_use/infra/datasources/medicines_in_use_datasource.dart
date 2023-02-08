import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/infra/models/network/response_medicines_ext.dart';

abstract class MedicinesInUseDatasource {
  Future<ResponseMedicinesInUseExt> findMedicinesInUseDatasource(QueryParameters parameters, int patientId);
}
