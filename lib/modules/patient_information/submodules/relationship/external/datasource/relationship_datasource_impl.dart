import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/domain/entities/network/request_relationship.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/infra/datasources/relationship_datasource.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/infra/models/network/response_relationship_ext.dart';

class RelationshipDatasourceImpl implements RelationshipDatasource {
  final Network _network;
  RelationshipDatasourceImpl(this._network);

  @override
  Future<ResponseRelationshipExt> saveRelationshipDatasource(RequestRelationship req, int patientId) async {
    final response = await _network.put(AppUrl.putSaveRelationship(patientId), body: req);
    if (response.statusCode != 200) {
      var _statusMessage = response.statusMessage;
      var _statusCode = response.statusCode;
      return ResponseRelationshipExt.fromMap(statusCode: _statusCode, statusMessage: _statusMessage, data: null);
    }
    return ResponseRelationshipExt.fromMap(statusCode: response.statusCode, data: null);
  }
}
