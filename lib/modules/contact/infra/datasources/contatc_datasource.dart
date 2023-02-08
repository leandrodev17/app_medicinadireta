import 'package:medicinadireta/modules/contact/infra/models/network/response_contact_ext.dart';

abstract class ContactDatasource {
  Future<ResponseContactExt> findContactDatasource();
}
