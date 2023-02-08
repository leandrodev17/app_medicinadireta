import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/helpers/helpers.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/models/patient/patient_model_ext.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/modules/patient/external/datasource/patient_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/presenter/controller/camera_gallery_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/domain/entities/network/params_general_data.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/external/datasource/general_data_datasource_impl.dart';

class FindDataPatientController extends GetxController {
  final PatientDatasourceImpl patientDatasourceImpl;
  final CheckConnectingNetwork checkConnecting;
  final CameraGalleryController cameraGalleryController;
  final GeneralDataDatasourceImpl generalDataDatasourceImpl;

  FindDataPatientController(this.patientDatasourceImpl, this.checkConnecting, this.cameraGalleryController, this.generalDataDatasourceImpl);

  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);
  final RxList<PatientModelExt> dataPatient = RxList<PatientModelExt>();
  final RxList<File> photoPerfilCamera = RxList<File>();
  final RxBool loadingSaveFotoPerfil = RxBool(false);
  // final RxBool loadingFotoPerfil = RxBool(false);

  final Rx<ParamsToNavigationPage> paramsToNavigationPage = Rx<ParamsToNavigationPage>(ParamsToNavigationPage());

  paramsNavigator(ParamsToNavigationPage params) {
    paramsToNavigationPage.value = params;
  }

  Future<dynamic> getFirstPage(int? patientId) async {
    // loadingFotoPerfil.value = true;
    isLoading.value = AppLoadingStatus.shimmerLoading;
    dataPatient.clear();
    await _getFindPatient(patientId);
  }

  final Rx<Uint8List> photoPerfilFixa = Rx<Uint8List>(Uint8List(0));

  convertBase64(String? data) {
    photoPerfilFixa.value = Uint8List(0);
    if (data != null && data.isNotEmpty) {
      Uint8List _bytesImage = Base64Decoder().convert(data);
      photoPerfilFixa.value = _bytesImage;
    }
  }

  _getFindPatient(int? patientId) async {
    try {
      // await 3.delay();
      final bool _checkConnecting = await checkConnecting.appCheckConnectivity();
      if (!_checkConnecting) {
        await AppAlert.alertWarning(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 5);
        isLoading.value = AppLoadingStatus.notLoading;
        // loadingFotoPerfil.value = false;
        return;
      }
      var _params = QueryParameters(expand: "Telefones(\$filter=ativado eq 'S'; \$orderby=data desc; \$count=true)");

      if (patientId == null) {
        await AppAlert.alertWarning(title: "Oops!", body: "Identificamos um problema nos dados da requisição, por favor, recarregue a tela e tente novamente!", seconds: 5);
        isLoading.value = AppLoadingStatus.notLoading;
        // loadingFotoPerfil.value = false;
        return;
      }

      final _response = await patientDatasourceImpl.findPatientIdDatasource(_params, patientId);
      if (_response.statusCode != 200) {
        await AppAlert.alertWarning(title: 'Oops!', body: _response.errorMessage.toString());
        isLoading.value = AppLoadingStatus.notLoading;
        // loadingFotoPerfil.value = false;
        return;
      }

      if (_response.model != null) {
        dataPatient.addAll(_response.model!);
        if (_response.model?.first.fotoBase64?.isNotEmpty ?? false) {
          convertBase64(_response.model?.first.fotoBase64);
        }
      }

      isLoading.value = AppLoadingStatus.notLoading;
      // loadingFotoPerfil.value = false;
    } catch (e) {
      AppLog.d('Problema para listar os dados do paciente ===> $e', name: 'getFindPatient');
      isLoading.value = AppLoadingStatus.notLoading;
      // loadingFotoPerfil.value = false;
      AppAlert.alertError(title: 'Oops!', body: 'Não foi possível listar os dados do paciente $e');
    }
  }

  _fileToBase64(File? file) {
    if (file == null) return null;
    final bytes = file.readAsBytesSync();
    String _img64 = base64Encode(bytes);
    return _img64;
  }

  _changePhotoUser(ParamsToNavigationPage params, File file) async {
    try {
      loadingSaveFotoPerfil.value = true;
      var _fotoBase64 = _fileToBase64(file);
      var _request = ParamsGeneralData(
        id: params.pacienteId,
        organizacaoId: params.organizacaoId,
        prontuario: params.numeroDoProtuario,
        fotoBase64: _fotoBase64,
      );

      var _photoPerfil = Helpers.convertBase64MemoryImage(_fotoBase64);
      paramsToNavigationPage.value = paramsToNavigationPage.value.copyWith(photoPerfil: _photoPerfil);
      // paramsToNavigationPage.value = params;

      final _response = await generalDataDatasourceImpl.saveGeneralDataDatasource(_request, params.pacienteId!);

      if (_response.statusCode != 200) {
        loadingSaveFotoPerfil.value = false;
        AppAlert.alertWarning(title: 'Oops!', body: 'Não foi possível salvar os dados');
        return;
      }
      loadingSaveFotoPerfil.value = false;
      // await Get.toNamed(Routes.PATIENT_DETAILS, arguments: params);
    } catch (e) {
      loadingSaveFotoPerfil.value = false;
      AppLog.d('Não foi possível salvar os dados: $e', name: '_changePhotoUser');
    }
  }

  changePhoto(ParamsToNavigationPage params) async {
    bool _isExistsPhoto = params.photoPerfil != null && (params.photoPerfil?.isNotEmpty ?? false);
    await Get.defaultDialog(
      radius: 5,
      title: 'choose_image_source'.tr,
      titleStyle: Theme.of(Get.context!).textTheme.subtitle1,
      content: Container(
        height: MediaQuery.of(Get.context!).size.height * .7,
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            _isExistsPhoto ? Expanded(child: Image.memory(params.photoPerfil!, fit: BoxFit.cover)) : Container(),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AppButton(
                    childRaisedButton: Text('camera'.tr),
                    onPressed: () async {
                      Get.back();
                      photoPerfilCamera.clear();
                      var _file = await cameraGalleryController.appFromCamera();
                      if (_file != null) {
                        photoPerfilCamera.add(_file);
                        _changePhotoUser(params, _file);
                      }
                    },
                    colorBackground: ConstColors.blue,
                    height: 30,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: AppButton(
                    childRaisedButton: Text('gallery'.tr),
                    onPressed: () async {
                      Get.back();
                      photoPerfilCamera.clear();
                      var _file = await cameraGalleryController.appFromGallery();
                      if (_file != null) {
                        photoPerfilCamera.add(_file);
                        _changePhotoUser(params, _file);
                      }
                    },
                    colorBackground: ConstColors.blue,
                    height: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
