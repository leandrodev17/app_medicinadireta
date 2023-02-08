import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/helpers/formats_constants.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/models/patient/patient_model_ext.dart';
import 'package:medicinadireta/core/models/phones/patient_model_phone_ext.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/request_new_phone.dart';
import 'package:medicinadireta/modules/modules_helpers/external/datasource/model_to_mail_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/presenter/controller/camera_gallery_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/domain/entities/network/params_general_data.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/external/datasource/general_data_datasource_impl.dart';
import 'package:medicinadireta/routes/app_pages.dart';

class GeneralDataController extends GetxController {
  final GeneralDataDatasourceImpl request;
  final ModelToMailDatasourceImpl newPhone;
  final SharedPreferencesHelper shared;
  final CameraGalleryController cameraGallery;

  GeneralDataController({required this.newPhone, required this.request, required this.shared, required this.cameraGallery});

  final RxList<PatientModelExt> listGeneralDataPatient = RxList<PatientModelExt>();
  // final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);

  final RxBool loadingFindData = RxBool(false);

  // Controllers
  final namePatientController = TextEditingController();
  final cpfPatientController = TextEditingController();
  final rgPatientController = TextEditingController();
  final telCelDatePatientController = TextEditingController();
  final telResDatePatientController = TextEditingController();
  final telComDatePatientController = TextEditingController();
  final mailDatePatientController = TextEditingController();
  final birthDaysController = TextEditingController();
  final Rx<DateTime> birthDate = Rx<DateTime>(DateTime.now());

  // FocusNode
  final namePatientFocusNode = FocusNode();
  final cpfPatientFocusNode = FocusNode();
  final rgPatientFocusNode = FocusNode();
  final telCelDatePatientFocusNode = FocusNode();
  final telResDatePatientFocusNode = FocusNode();
  final telComDatePatientFocusNode = FocusNode();
  final mailDatePatientFocusNode = FocusNode();
  final birthDayFocusNode = FocusNode();

  // Valores para o request
  final RxInt _organizacaoId = RxInt(0);
  final RxInt _prontuario = RxInt(0);
  // final RxBool _recebeEmail = RxBool(false);
  // final RxBool _recebeSMS = RxBool(false);

  final RxBool loadingSave = RxBool(false);

  // Campos do formulário
  final RxList<String> listGender = <String>['gender_male'.tr, 'gender_female'.tr, 'gender_other'.tr].obs;
  final RxInt indexGender = RxInt(0);

  final RxList<String> listAttendanceType = <String>['private'.tr, 'health_insurance'.tr].obs;
  final RxInt indexAttendanceType = RxInt(0);

  // final RxString namePatient = RxString('');
  // final RxString cpfPatient = RxString('');
  // final RxString rgPatient = RxString('');
  // final RxString telCelPatient = RxString('');
  // final RxString telResPatient = RxString('');
  // final RxString telComPatient = RxString('');
  // final RxString mailPatient = RxString('');
  final RxString patientGender = RxString('');

  // onChange do TextField
  // void setNamePatient(String? value) => namePatient.value = value!;
  // void setCPFPatient(String? value) => cpfPatient.value = value!;

  // void setRGPatient(String? value) => rgPatient.value = value!;
  // void setTelCelPatient(String? value) => telCelPatient.value = value!;
  // void setTelResPatient(String? value) => telResPatient.value = value!;
  // void setTelComPatient(String? value) => telComPatient.value = value!;
  // void setMailPatient(String? value) => mailPatient.value = value!;
  // void setBirthday(DateTime? value) {
  //   if (value != null) {
  //     birthDate.value = value;
  //   }
  // }

  void onChangeGender(int? index) {
    if (index != null) {
      indexGender.value = index;
      patientGender.value = index == 0 ? "M" : (index == 1 ? "F" : "0");
    }
  }

  void onChangeAttendanceType(int? index) => indexAttendanceType.value = index!;

  // Validadores
  // bool get validErrorNameEmpty => namePatient.value != '' && namePatient.value.isNotEmpty;
  // String? get nameError {
  //   if (namePatient.value != '' || validErrorNameEmpty) return null;
  //   return 'requiredField'.tr;
  // }

  // bool get validErrorCPFEmpty => cpfPatient.value != '' && ValidatorCPF.isValid(cpfPatient.value);
  // String? get cpfError {
  //   if (cpfPatient.value == '' || validErrorCPFEmpty) return null;
  //   if (cpfPatient.value.isEmpty) return 'requiredField'.tr;
  //   if (cpfPatient.value != '' && !ValidatorCPF.isValid(cpfPatient.value)) return 'cpf_invalid'.tr;
  //   return null;
  // }

  // bool get validErrorMailEmpty => mailPatient.value != '' && mailPatient.value.isEmail;
  // bool get mailIsNotEmpty => mailPatient.value != '' && mailPatient.value.isNotEmpty;
  // String? get mailError {
  //   if (mailPatient.value == '' || validErrorMailEmpty) {
  //     return null;
  //   } else if (mailPatient.value.isEmpty) {
  //     return 'requiredField'.tr;
  //   } else if (mailPatient.value != '' && !mailPatient.value.isEmail) {
  //     return 'mail_invalid'.tr;
  //   }
  //   return null;
  // }

  // int get idade {
  //   if (birthDate.value != null) {
  //     final daysDiff = DateTime.now().difference(birthDate.value).inDays;
  //     return (daysDiff / 365).floor();
  //   }
  //   return 0;
  // }

  // bool get validBirthDateError => idade < 100;

  // String? get birthDateError {
  //   if (validBirthDateError) return null;
  //   return 'invalid_date_of_birth'.tr;
  // }

  // desbloqueia o bt para salvar os dados
  // bool get isPressedSave => mailIsNotEmpty
  //     ? (validErrorNameEmpty && validErrorCPFEmpty && validErrorMailEmpty && validBirthDateError)
  //     : (validErrorNameEmpty && validErrorCPFEmpty && validBirthDateError);

  @override
  void dispose() {
    super.dispose();
    namePatientController.dispose();
    cpfPatientController.dispose();
    rgPatientController.dispose();
    telCelDatePatientController.dispose();
    telResDatePatientController.dispose();
    telComDatePatientController.dispose();
    mailDatePatientController.dispose();
    birthDaysController.dispose();

    //Focus
    namePatientFocusNode.dispose();
    cpfPatientFocusNode.dispose();
    rgPatientFocusNode.dispose();
    telCelDatePatientFocusNode.dispose();
    telResDatePatientFocusNode.dispose();
    telComDatePatientFocusNode.dispose();
    mailDatePatientFocusNode.dispose();
    birthDayFocusNode.dispose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  findGeneralData(int patientId) async {
    listGeneralDataPatient.clear();
    await _getFindGeneralData(patientId);
  }

  final Rx<Uint8List> photoPerfil = Rx<Uint8List>(Uint8List(0));

  _convertBase64(String data) {
    if (data != '') {
      Uint8List _bytesImage = Base64Decoder().convert(data);
      photoPerfil.value = _bytesImage;
    }
  }

  _getFindGeneralData(int patientId) async {
    try {
      loadingFindData.value = true;
      await 0.5.delay();

      var queryParameters = QueryParameters(expand: "Telefones(\$filter=ativado eq 'S'; \$orderby=data desc; \$count=true)");

      final _response = await request.findGeneralDataDatasource(patientId, queryParameters);
      loadingFindData.value = false;

      if (_response.statusCode != 200) {
        AppAlert.alertWarning(title: 'Oops!', body: 'Não foi possível listar os dados');
        loadingFindData.value = false;
        return;
      }

      /// TODO Tipo de convenio não está sendo salvo ou lido, não sei o que enviar para o servidor
      if (_response.model != null) {
        listGeneralDataPatient.add(_response.model!);
        final _model = _response.model;
        final _phones = _model?.telefones ?? [];

        var _cel = _phones.firstWhere((cel) => cel.tipo == "CEL", orElse: () => PatientModelPhoneExt());
        var _res = _phones.firstWhere((res) => res.tipo == "RES", orElse: () => PatientModelPhoneExt());
        var _com = _phones.firstWhere((com) => com.tipo == "COM", orElse: () => PatientModelPhoneExt());

        if (_cel.numero != null) telCelDatePatientController.text = "(${_cel.ddd}) ${_cel.numero}";
        if (_com.numero != null) telComDatePatientController.text = "(${_com.ddd}) ${_com.numero}";
        if (_res.numero != null) telResDatePatientController.text = "(${_res.ddd}) ${_res.numero}";

        if (_model?.nome != null) namePatientController.text = _model!.nome!;
        if (_model?.cpf != null) cpfPatientController.text = FormatsConstants.cpfMaskFormatter.format(value: _model?.cpf);
        if (_model?.rg != null) rgPatientController.text = _model!.rg!;
        if (_model?.email != null) mailDatePatientController.text = _model!.email!;

        // namePatientController.text = _model?.nome ?? '';
        // cpfPatientController.text = _model?.cpf != null ? FormatsConstants.cpfMaskFormatter.format(value: _model?.cpf) : '';
        // rgPatientController.text = _model?.rg ?? '';
        // mailDatePatientController.text = _model?.email?.toString() ?? '';

        if (_model?.sexo != null) _setGender(_model?.sexo ?? '');

        var _birthDate = _model?.dataNascimento ?? null;

        // dataNascimento: 1900-01-01T00:00:00Z, Data a baixo de 1920 o pacote gerar um error

        // TODO data do usuário vem no formato errada da api, essa foi a solucao para fvalidar se o ano é menor do 1900
        if (_birthDate != null) {
          var _date = DateTime.parse(_birthDate.toString());
          var _year = int.parse(toOriginalFormatString(_date));
          if (_year < 1900) {
            birthDate.value = DateTime.now();
          } else {
            birthDate.value = _date;
          }
        } else {
          birthDate.value = DateTime.now();
        }

        birthDaysController.text = FormatsDatetime.formatDate(birthDate.value, FormatsDatetime.dateFormat);

        // Valores para popular o request
        _organizacaoId.value = _model?.organizacaoId ?? 0;
        _prontuario.value = _model?.prontuario ?? 0;
        _convertBase64(_model?.fotoBase64 ?? '');
      }
    } catch (e) {
      AppLog.d('Não foi possível ler os dados para popular o formulário de edição de dados gerais: $e', name: '_getFindGeneralData');
      loadingFindData.value = false;
    }
  }

  // bool isValidDate(String input) {
  //   try {
  //     final date = DateTime.parse(input);
  //     final originalFormatString = toOriginalFormatString(date);
  //     return input == originalFormatString;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  String toOriginalFormatString(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    // final m = dateTime.month.toString().padLeft(2, '0');
    // final d = dateTime.day.toString().padLeft(2, '0');
    return "$y";
    // return "$y$m$d";
  }

  _setGender(String data) {
    switch (data) {
      case "M":
        indexGender.value = 0;
        patientGender.value = "M";
        break;
      case "F":
        indexGender.value = 1;
        patientGender.value = "F";
        break;
      default:
      // indexGender.value = 2;
      // patientGender.value = "0";
    }
  }

  saveGeneralData(ParamsToNavigationPage params, ParamsGeneralData request) async {
    await _saveGeneralData(params, request);
  }

  _saveNewPhone(int patientId, String newNumberPhone, String typePhone) async {
    try {
      final dddRegex = RegExp('(\(([1-9]+)\))');
      final ddd = dddRegex.firstMatch(newNumberPhone)!.group(2);
      final number = newNumberPhone.split(' ').last;

      var _request = RequestNewPhone(ddd: ddd, numero: number, tipo: typePhone);
      final _response = await newPhone.saveNewPhoneDatasource(_request, patientId);
      bool status = _response.statusCode == 200;

      if (!status) {
        loadingSave.value = false;
        await AppAlert.alertError(title: "Oops!", body: _response.statusMessage ?? 'Problema para atualizar os dados do telefone', seconds: 5);
        return;
      }
    } catch (e) {
      AppLog.d('Não foi possível salvar o número de telefone: $e', name: '_saveNewPhone');
    }
  }

  _fileToBase64() {
    var _listFiles = cameraGallery.filePerfil;
    if (_listFiles.isEmpty) return null;
    final bytes = _listFiles.first.readAsBytesSync();
    String _img64 = base64Encode(bytes);
    return _img64;
  }

  _saveGeneralData(ParamsToNavigationPage params, ParamsGeneralData requestData) async {
    print('esntoou aqui');
    try {
      loadingSave.value = true;
      String? _dataNascimento = requestData.dataNascimento != null ? FormatsDatetime.apiDateFormat.format(DateTime.parse(requestData.dataNascimento!)) : null;
      await 0.5.delay();
      var _request = ParamsGeneralData(
        id: params.pacienteId,
        organizacaoId: _organizacaoId.value,
        prontuario: _prontuario.value,
        nome: requestData.nome,
        cpf: requestData.cpf,
        rg: requestData.rg,
        dataNascimento: _dataNascimento,

        /// TODO esperar a solução do Felipe para resolver esse ponto nao ser preciso o envio de vazio
        email: requestData.email != '' ? requestData.email : '',

        sexo: patientGender.value != '' ? patientGender.value : null,
        fotoBase64: _fileToBase64(),
      );
      print('esntoou aqui 1');

      final _response = await request.saveGeneralDataDatasource(_request, params.pacienteId!);
      AppLog.d(' ${_response.model?.toMap()}', name: '_responsex');
      print('esntoou aqui 3');

      if (requestData.telCelPatient != null) await _saveNewPhone(params.pacienteId!, requestData.telCelPatient!, "CEL");
      if (requestData.telResPatient != null) await _saveNewPhone(params.pacienteId!, requestData.telResPatient!, "RES");
      if (requestData.telComPatient != null) await _saveNewPhone(params.pacienteId!, requestData.telComPatient!, "COM");

      bool status = _response.statusCode == 200;

      if (!status) {
        loadingSave.value = false;
        await AppAlert.alertError(title: "Oops!", body: _response.statusMessage ?? 'Problema para atualizar os dados', seconds: 5);
        return;
      }

      if (_response.model != null) {
        if (_response.model?.idade != null) {
          List<String> _idade = _response.model?.idade != null ? _response.model!.idade!.split(" ").toList() : [];

          params = params.copyWith(idade: _idade.first);
        }

        ///Atualiza o Objeto para refletir no card do paciente.
        params = params.copyWith(nomeDoPaciente: requestData.nome, email: requestData.email, telefone: requestData.telCelPatient);
        log('_responsex ${params.toMap()}');
        AppAlert.alertSuccess(title: 'Sucesso!', body: 'Cadastro editado com sucesso');
      }
      loadingSave.value = false;

      await 1.delay();
      await Get.toNamed(Routes.PATIENT_DETAILS, arguments: params);
    } catch (e) {
      AppLog.d('Não foi possível salvar os dados: $e', name: '_saveGeneralData');
      loadingSave.value = false;
    }
  }
}
