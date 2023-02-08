import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/request_new_anamnese.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/infra/models/network/response_anamnese_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/infra/models/network/response_ciap_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/infra/models/network/response_cid_sub_category_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/infra/models/network/response_new_anamnese_ext.dart';

abstract class AnamneseDatasource {
  Future<ResponseAnamneseExt> findAnamneseDatasource(int pacientId, QueryParameters parameters);
  Future<ResponseNewAnamneseExt> saveNewAnamneseDatasource(RequestNewAnamnese params, int pacientId);
  Future<ResponseNewAnamneseExt> updateAnamneseDatasource(RequestNewAnamnese params, int pacientId);
  Future<ResponseCiapExt> findCiapDatasource();
  Future<ResponseCidSubCategoryExt> findCidSubCategoryDatasource();
}
