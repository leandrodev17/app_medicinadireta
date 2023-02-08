import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/network/response_allergy_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/network/response_medical_ext.dart';

import '../models/network/request_allergy_ext.dart';

abstract class AllergyDatasource {
  Future<ResponseAllergyExt> findAllergysDatasource(int pacientId, QueryParameters parameters);
  Future<ResponseAllergyExt> saveAllergysDatasource(int pacientId, RequestAllergyExt parameters);
  Future<ResponseAllergyExt> updateAllergysDatasource(int allergyId, RequestAllergyExt parameters);
  Future<ResponseMedicalExt> findAllMedicalDatasource(QueryParameters parameters);
  Future<ResponseMedicalExt> findOneMedicalDatasource(QueryParameters? parameters, int medicalId);
}
