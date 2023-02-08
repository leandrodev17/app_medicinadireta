import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/contact/external/datasource/contact_datasource_impl.dart';
import 'package:medicinadireta/modules/contact/infra/models/contact_ext.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final ContactDatasourceImpl request;

  ContactController(this.request);

  @override
  void onInit() async {
    // await getFirstPage();
    super.onInit();
  }

  Future<List<ContactExt>> getContacts() async {
    List<ContactExt> _list = await _getFindContacts();
    return _list;
  }

  _getFindContacts() async {
    try {
      // final _response = await request.findContactDatasource();
      // if (_response.statusCode != 200) return [];
      // return _response.model;
    } catch (e) {
      AppLog.d('ERROR CONTROLLER CONTACT ===> $e', name: 'CONTACT');
      return [];
    }
  }
}
