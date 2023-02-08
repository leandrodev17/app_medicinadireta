import 'package:medicinadireta/modules/infor_med/infra/models/response_auth_info_med_ext.dart';
import 'package:medicinadireta/modules/infor_med/infra/models/response_contents_html_info_med_ext.dart';
import 'package:medicinadireta/modules/infor_med/infra/models/response_contents_info_med_ext.dart';

abstract class InfoMedDatasource {
  Future<ResponseAuthInfoMedExt> loginInfoMedDatasource(Map<String, dynamic> req);
  Future<ResponseContentsInfoMedExt> searchInfoMedDatasource(Map<String, dynamic> req);
  Future<ResponseContentsHTMLInfoMedExt> searchContentsIDInfoMedDatasource(String id);
}