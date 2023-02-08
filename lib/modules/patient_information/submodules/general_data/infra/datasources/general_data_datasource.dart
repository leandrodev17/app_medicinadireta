import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/domain/entities/network/params_general_data.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/infra/models/network/response_general_data_ext.dart';

abstract class GeneralDataDatasource {
  Future<ResponseGeneralDataExt> saveGeneralDataDatasource(ParamsGeneralData req, int patientId);
  Future<ResponseGeneralDataExt> findGeneralDataDatasource(int patientId, QueryParameters queryParameters);
}
