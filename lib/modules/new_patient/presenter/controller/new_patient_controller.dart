import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/new_patient/domain/entities/network/request_new_patient.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/domain/entities/network/params_general_data.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:medicinadireta/modules/new_patient/external/datasource/new_patient_datasource_impl.dart';

class NewPatientController extends GetxController {
  final NewPatientDatasourceImpl newPatient;

  NewPatientController({required this.newPatient});

  final RxBool loadingSave = RxBool(false);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dddPhoneController = TextEditingController();
  final birthdayController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    dddPhoneController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  cleanFields() {
    nameController.clear();
    emailController.clear();
    dddPhoneController.clear();
    birthdayController.clear();
    // birthday?.value;
    loadingSave.value = false;
  }

  Rx<DateTime>? birthday;

  RequestNewPatient requestNewPatientParams(ParamsGeneralData params) {
    String? _ddd;
    String? _number;
    String? _birthday;
    String? _email;
    if (params.telCelPatient?.isNotEmpty ?? false) {
      final dddRegex = RegExp('(\(([1-9]+)\))');
      final ddd = dddRegex.firstMatch(params.telCelPatient!)!.group(2);
      final number = params.telCelPatient?.split(' ').last;
      _ddd = ddd.toString();
      _number = number?.replaceAll('-', '').toString();
    }

    if (params.dataNascimento?.isNotEmpty ?? false) _birthday = FormatsDatetime.apiDateFormat.format(DateTime.parse(params.dataNascimento.toString()));
    if (params.email?.isNotEmpty ?? false) _email = params.email;

    var _req = RequestNewPatient(
      ddd: _ddd,
      celular: _number,
      dataNascimento: _birthday,
      email: _email,
      modoCadastro: "APP",
      nome: params.nome,
    );

    return _req;
  }

  saveNewPatient(ParamsGeneralData params) async {
    try {
      loadingSave.value = true;
      await 1.delay();
      var _req = requestNewPatientParams(params);
      final _response = await newPatient.saveNewPatientDatasource(_req);
      loadingSave.value = false;
      if (_response.statusCode != 200) {
        await AppAlert.alertError(title: "Oops!", body: "Não foi possível enviar os dados", seconds: 15);
      }
      if (_response.model != null) {
        AppAlert.alertSuccess(title: "Sucesso!", body: "Solicitação com sucesso!", seconds: 15);
        cleanFields();
      }
    } catch (e, s) {
      AppLog.d("Não foi possível salvar o novo paciente $e", stackTrace: s, name: 'saveNewPatient');
      loadingSave.value = false;
      await AppAlert.alertError(title: "Oops!", body: "Não foi possível enviar os dados", seconds: 5);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
