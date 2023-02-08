import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/request_delete_principio_ativo.dart';
import 'package:medicinadireta/modules/modules_helpers/infra/models/network/response_principal_active.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/medical_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/network/response_classe_terapeutica_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/network/response_forma_farmaceutica_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/network/response_medical_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/principal_active_ext.dart';

abstract class MedicalDatasource {
  Future<ResponseMedicalExt> registerMedicalDatasource(MedicalExt request);
  Future<ResponseMedicalExt> registerMedicalPrincipalActiveDatasource(PrincipalActiveExt body, int medicalId);
  Future<ResponseFormaFarmaceuticaExt> findAllMedicalFarmaceuticaDatasource(QueryParameters? parameters);
   Future<ResponseClasseTerapeuticaExt> findMedicalAllTerapeuticaDatasource(QueryParameters? parameters);
  Future<ResponsePrincipalActive> findPrincipalActiveDatasource(QueryParameters parameters);
  Future<ResponseMedicalExt> findAllMedicalDatasource(QueryParameters parameters);
  Future<ResponseMedicalExt> findMedicalIdDatasource(QueryParameters parameters, int medicalId);
  Future<ResponseMedicalExt> updateMedicalDatasource(MedicalExt request, int medicalId);
  Future<ResponseMedicalExt> deletePrincipioAtivoDatasource(RequestDeletePrincipioAtivo request, int medicalId);

}
