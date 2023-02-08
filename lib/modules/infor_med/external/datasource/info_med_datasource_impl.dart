import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/network/network_info_med.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/modules/infor_med/infra/datasources/info_med_datasource.dart';
import 'package:medicinadireta/modules/infor_med/infra/models/contents_info_med_ext.dart';
import 'package:medicinadireta/modules/infor_med/infra/models/response_auth_info_med_ext.dart';
import 'package:medicinadireta/modules/infor_med/infra/models/response_contents_html_info_med_ext.dart';
import 'package:medicinadireta/modules/infor_med/infra/models/response_contents_info_med_ext.dart';

class InfoMedDatasourceImpl implements InfoMedDatasource {
  final NetworkInfoMed _network;
  InfoMedDatasourceImpl(this._network);

  @override
  Future<ResponseAuthInfoMedExt> loginInfoMedDatasource(Map<String, dynamic> req) async {
    try {
      final response = await _network.post(AppUrl.authInfoMed, body: req);
      if (response.statusCode == null) return ResponseAuthInfoMedExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
      return ResponseAuthInfoMedExt.fromMap(statusCode: response.statusCode, data: response.data);
    } catch (e) {
      return ResponseAuthInfoMedExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
    }
  }

  @override
  Future<ResponseContentsInfoMedExt> searchInfoMedDatasource(Map<String, dynamic> req) async {
    try {
      final response = await _network.post(AppUrl.contentsInfoMed, body: req, isAuth: true);
      if (response.statusCode == null) return ResponseContentsInfoMedExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
      return ResponseContentsInfoMedExt.fromMap(statusCode: response.statusCode, data: response.data['items']);
    } catch (e) {
      return ResponseContentsInfoMedExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
    }
  }

  @override
  Future<ResponseContentsHTMLInfoMedExt> searchContentsIDInfoMedDatasource(String id) async {
    try {
      final response = await _network.get(AppUrl.searchContentsIDInfoMed(id), isAuth: true);
      if (response.statusCode == null) return ResponseContentsHTMLInfoMedExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
      var _data = ContentsInfoMedExt();
      if (response.data != null) {
        var _encode = response.data;

        _data = ContentsInfoMedExt(
          id: _encode['_id'],
          tipo: _encode['tipo'],
          titulo: _encode['titulo'],
          descricao: _encode['descricao'],
          url: _encode['url'],
          anoPublicacao: _encode['anoPublicacao'] != null ? int.parse(_encode['anoPublicacao'].toString()) : null,
          copyright: _encode['copyright'] != null ? int.parse(_encode['copyright'].toString()) : null,
          conteudoHtml: _encode['conteudoHtml'],
          autores: null,
          conteudo: null,
          minutosLeitura: null,
        );
      }
      return ResponseContentsHTMLInfoMedExt.fromMap(statusCode: response.statusCode, data: _data);
    } catch (e) {
      print("e $e");
      return ResponseContentsHTMLInfoMedExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: null, statusMessage: STATUS_MESSAGE_DEFAULT);
    }
  }
}
