import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/request_new_phone.dart';
import 'package:medicinadireta/modules/modules_helpers/external/datasource/model_to_mail_datasource_impl.dart';
import 'package:medicinadireta/modules/modules_helpers/infra/models/model_to_mail_ext.dart';
import 'package:get/get.dart';

class ModelToMailController extends GetxController {
  final ModelToMailDatasourceImpl request;

  ModelToMailController(this.request);

  @override
  void onInit() async {
    // await getFirstPage();
    super.onInit();
  }

  Future<List<ModelToMailExt>> getModelToMails() async {
    List<ModelToMailExt> _list = await _getFindModelToMails();
    return _list;
  }

  _getFindModelToMails() async {
    try {
      // final _response = await request.findModelToMailDatasource();
      // if (_response.statusCode != 200) return [];
      // return _response.model;
    } catch (e) {
      AppLog.d('ERROR CONTROLLER MODELO PARA EMAIL ===> $e', name: 'MODELTOMAIL');
      return [];
    }
  }

  Future<bool> saveNewPhone({required int patientId, required String newNumberPhone, required String typePhone}) async {
    return await _saveNewPhone(patientId, newNumberPhone, typePhone);
  }

  Future<bool> _saveNewPhone(int patientId, String newNumberPhone, String typePhone) async {
    try {
      final dddRegex = RegExp('(\(([1-9]+)\))');
      final ddd = dddRegex.firstMatch(newNumberPhone)!.group(2);
      final number = newNumberPhone.split(' ').last;

      var _request = RequestNewPhone(ddd: ddd, numero: number, tipo: typePhone);
      final _response = await request.saveNewPhoneDatasource(_request, patientId);
      if (_response.model != null) {
        return true;
      }
      return false;
    } catch (e) {
      AppLog.d('Não foi possível salvar o número de telefone: $e', name: '_saveNewPhone');
      return false;
    }
  }
}
