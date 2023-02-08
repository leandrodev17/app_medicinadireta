import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/infra/models/network/response_exams_ext.dart';


abstract class ExamsDatasource {
  Future<ResponseExamsExt> findAllExamsDatasource(int pacientId, QueryParameters parameters);
}
