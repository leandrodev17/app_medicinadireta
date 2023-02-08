import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/entities/attachments.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/infra/models/network/response_attachments_ext.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/entities/network/request_attachments_save.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/external/datasource/attachements_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/infra/models/attachments_ext.dart';

import 'camera_gallery_controller.dart';

class AttachmentsController extends GetxController {
  final AttachmentsDatasourceImpl request;
  final CameraGalleryController cameraGallery;

  AttachmentsController({required this.request, required this.cameraGallery});

  final RxList<AttachmentsExt> listAttachments = RxList<AttachmentsExt>();
  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);

  final RxList<AttachmentsExt> listAttachmentsDocuments = RxList<AttachmentsExt>();
  final Rx<AppLoadingStatus> isLoadingDocuments = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);

  final Rx<Uint8List> attachmentUint8List = Rx<Uint8List>(Uint8List(0));

  final RxInt pacienteId = RxInt(0);
  final indexTypeDocuments = 0.obs;

  final RxBool loadingAttachment = RxBool(false);
  final RxString attachmentStringBase64 = RxString('');

  dynamic onValueChanged(int index, int patientId) async {
    indexTypeDocuments.value = index;
    if (index == 1) await getFirstPageDocuments(isFirst: true, patientId: patientId);
  }

  swipeRefresh(int patientId) async {
    if (indexTypeDocuments.value == 0) {
      await getFirstPage(isFirst: true, patientId: patientId);
    } else {
      await getFirstPageDocuments(isFirst: true, patientId: patientId);
    }
  }

  getFirstPageDocuments({isFirst = false, required int patientId}) async {
    if (isFirst) {
      isLoadingDocuments.value = AppLoadingStatus.shimmerLoading;
    } else {
      isLoadingDocuments.value = AppLoadingStatus.fullLoading;
    }
    listAttachmentsDocuments.clear();
    await _getFindAttachmentsDocuments(patientId);
  }

  _getFindAttachmentsDocuments(int patientId) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      var req = const QueryParameters(filter: "tipoArquivo eq 'D'", orderby: "dataInclusao desc");

      final _response = await request.listAttachmentsDatasource(req, patientId);
      if (_response.statusCode != 200) {
        await AppAlert.alertWarning(title: 'Oops!', body: 'Não foi possível listar os documentos');
        isLoadingDocuments.value = AppLoadingStatus.notLoading;
        return;
      }
      if (_response.model!.isNotEmpty) {
        List<AttachmentsExt> model = _response.model as List<AttachmentsExt>;
        listAttachmentsDocuments.addAll(model);
      }
      isLoadingDocuments.value = AppLoadingStatus.notLoading;
    } catch (e) {
      AppLog.d('Não foi possível listar os documentos $e', name: '_getFindAttachmentsDocuments');
      isLoadingDocuments.value = AppLoadingStatus.notLoading;
    }
  }

  getFirstPage({isFirst = false, required int patientId}) async {
    if (isFirst) {
      isLoading.value = AppLoadingStatus.shimmerLoading;
    } else {
      isLoading.value = AppLoadingStatus.fullLoading;
    }
    listAttachments.clear();
    indexTypeDocuments.value = 0;
    await _getFindAttachments(patientId);
  }

  _getFindAttachments(int patientId) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      var req = const QueryParameters(filter: "tipoArquivo eq 'I'", orderby: "dataInclusao desc");

      final _response = await request.listAttachmentsDatasource(req, patientId);
      if (_response.statusCode != 200) {
        await AppAlert.alertWarning(title: 'Oops!', body: 'Não foi possível listar as imagens');
        isLoading.value = AppLoadingStatus.notLoading;
        return;
      }
      if (_response.model!.isNotEmpty) {
        List<AttachmentsExt> model = _response.model as List<AttachmentsExt>;
        listAttachments.addAll(model);
      }
      isLoading.value = AppLoadingStatus.notLoading;
    } catch (e) {
      AppLog.d('Não foi possível listar as imagens $e', name: '_getFindAttachments');
      isLoading.value = AppLoadingStatus.notLoading;
    }
  }

  final RxBool loadingOpenFile = RxBool(false);
  final RxBool failureGeneratorFile = RxBool(false);
  final RxString pathFileToOpen = RxString('');

  Future<String?>? writeFile(String fileServer, String nameFileServer) async {
    try {
      pathFileToOpen.value = '';
      await 1.delay();
      final decodedBytes = base64Decode(fileServer.replaceAll('\n', ''));
      final directory = await getApplicationDocumentsDirectory();
      var fileImg = File('${directory.path}/${nameFileServer.replaceAll(' ', '_')}');
      fileImg.writeAsBytesSync(List.from(decodedBytes));
      if (fileImg.path.isNotEmpty) {
        pathFileToOpen.value = fileImg.path;
        return fileImg.path;
      }
      return null;
    } catch (e) {
      AppLog.d('Não foi possível salvar local e visualizar o arquivo $e', name: 'writeFile');
      return null;
    }
  }

  showModalDialog() {
    Get.defaultDialog(
      title: "Preparando arquivo para ser visualizado.",
      backgroundColor: Colors.white,
      titleStyle: GoogleFonts.openSans(color: ConstColors.blue, fontSize: 20, fontWeight: FontWeight.w500),
      textConfirm: "Visualizar",
      textCancel: "Cancelar",
      onWillPop: () async => await Future.value(false),
      cancelTextColor: ConstColors.blue,
      confirmTextColor: Colors.white,
      buttonColor: ConstColors.blue,
      barrierDismissible: false,
      contentPadding: const EdgeInsets.all(10),
      onConfirm: () async {
        Get.back();
        if (pathFileToOpen.value != '') await OpenFile.open(pathFileToOpen.value);
      },
      radius: 4,
      content: Obx(() {
        return Column(
          children: [
            Visibility(
              visible: failureGeneratorFile.value,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Não foi possível baixar o documento, por favor, tente novamente ou escolha outro documento.",
                      style: GoogleFonts.openSans(color: ConstColors.danger, fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !failureGeneratorFile.value,
              child: Column(
                children: [
                  Visibility(
                    visible: loadingOpenFile.value,
                    child: Row(
                      children: [
                        CupertinoActivityIndicator(),
                        const SizedBox(width: 10),
                        Expanded(child: Text("Aguarde, enquanto o documento fica pronto.", style: GoogleFonts.openSans(color: ConstColors.blue, fontSize: 18, fontWeight: FontWeight.w500))),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !loadingOpenFile.value,
                    child: Row(
                      children: [
                        Icon(Icons.check, color: ConstColors.greenDark),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Clique em vizualizar para abrir o documento.",
                            style: GoogleFonts.openSans(color: ConstColors.greenDark, fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  showOpenFile(int attachmentId, String nameFileServer) async {
    try {
      loadingOpenFile.value = true;
      failureGeneratorFile.value = false;
      showModalDialog();
      await 1.delay();
      if (nameFileServer == '') {
        AppLog.d('Nome do arquivo não chegou até a função nome: $nameFileServer', name: 'showOpenFileErro4');
        failureGeneratorFile.value = true;
        await 10.delay();
        Get.back();
        return;
      }
      AttachmentsExt? _model = await _findAttachmentFile(attachmentId);
      if (_model != null) {
        String? _path = await writeFile(_model.arquivoBase64!, nameFileServer);
        if (_path != null) {
          loadingOpenFile.value = false;
          pathFileToOpen.value = _path;
          // o cancelar nao cancela o evento de abrir o arquivo e o visualizar com abertura auto causa a visualizacao duas vezes
          // await 2.delay();
          // Get.back();
          // await OpenFile.open(_path);
        } else {
          // AppLog.d('Não foi possível converter o arquivo e abrir-lo', name: 'showOpenFileErro1');
          loadingOpenFile.value = false;
          failureGeneratorFile.value = true;
          await 10.delay();
          Get.back();
          return;
        }
      } else {
        // AppLog.d('O retorno da API veio vazio', name: 'showOpenFileErro2');
        loadingOpenFile.value = false;
        failureGeneratorFile.value = true;
        await 10.delay();
        Get.back();
        return;
      }
      loadingOpenFile.value = false;
    } catch (e) {
      loadingOpenFile.value = false;
      failureGeneratorFile.value = true;
      AppLog.d('Não foi possível salvar local e visualizar o arquivo $e', name: 'showOpenFileErro3');
      await 10.delay();
      Get.back();
    }
  }

  Future<AttachmentsExt?>? _findAttachmentFile(int attachmentId) async {
    try {
      final _response = await request.findAttachmentsDatasource(attachmentId);
      if (_response.model != null) {
        AttachmentsExt result = _response.model!.first as AttachmentsExt;
        return result;
      }
      return null;
    } catch (e) {
      AppLog.d('Não foi possível pesquisar arquivo por ID para ser visualizado $e', name: '_findAttachment');
      return null;
    }
  }

  _convertBase64(String data) async {
    if (data != '') {
      Uint8List _bytesImage = Base64Decoder().convert(data);
      attachmentUint8List.value = _bytesImage;
    }
  }

  getAttachment(int attachmentId) async => await _findAttachment(attachmentId);

  _findAttachment(int attachmentId) async {
    try {
      attachmentUint8List.value = Uint8List(0);
      attachmentStringBase64.value = '';
      loadingAttachment.value = true;
      await 1.delay();
      final response = await request.findAttachmentsDatasource(attachmentId);
      loadingAttachment.value = false;

      AttachmentsExt? item = response.model?.first as AttachmentsExt;
      await _convertBase64(item.arquivoBase64 ?? '');
      loadingAttachment.value = false;
    } catch (e) {
      AppLog.d('Não foi possível pesquisar arquivo por ID para ser visualizado $e', name: '_findAttachment');
      loadingAttachment.value = false;
    }
  }

  removeFileFromList(int index) {
    // listFilesBlocked.removeAt(index);
    cameraGallery.listFiles.removeAt(index);
  }

  // loadingSaveAttachments está rodando? : Não permite que o usuário fique clicando em várias fotos;
  // loadingAttachmentsToIndex se for igual o index da lista habilita o loagind;
  // loadingAttachmentsToIndex se for igual o index da lista bloquea o botão para não enviar outra requisição;
  // listFilesBlocked se o index existir dentro na lista seguinifica que foi enviado para o servidor, desabilita o delete e o salvar

  int _indexSaveAttachement = 99999;
  final RxBool loadingSaveAttachments = RxBool(false);
  final RxInt loadingAttachmentsToIndex = RxInt(99999);

  // Para identificar se o item da lista já foi enviado para o servidor
  // Remover ou bloquear o botão para evitar qq ação
  // final RxList listFilesBlocked = RxList();

  // final RxList<File> listFilesSaveing = RxList<File>();

  saveAttachment(int index, int pacientId, dynamic mapLegendaFile) async {
    try {
      loadingAttachmentsToIndex.value = index;
      var _listFiles = cameraGallery.listFiles;
      loadingSaveAttachments.value = true;
      var _legenda = mapLegendaFile[index] != null ? mapLegendaFile[index].toString() : null;

      await 1.delay();

      if (_listFiles.isNotEmpty) {
        final bytes = _listFiles[index].readAsBytesSync();
        String img64 = base64Encode(bytes);

        var requestData = RequestAttachmentsSave(
          hashArquivo: img64,
          legenda: _legenda ?? '${DateTime.now().millisecondsSinceEpoch}',
          nomeArquivo: '${DateTime.now().millisecondsSinceEpoch}.jpeg',
          tipoArquivo: 'I',
        );

        ResponseAttachmentsExt resp = await request.saveAttachmentsDatasource(pacientId, requestData);
        if (resp.statusCode != 201) {
          loadingSaveAttachments.value = false;
          AppAlert.alertWarning(title: 'Oops!', body: 'Não foi possível salvar o anexo');
        }
        if (resp.responseAttachment != null) {
          AttachmentsExt result = resp.responseAttachment as AttachmentsExt;
          listAttachments.insert(0, result);
          AppAlert.alertSuccess(title: 'Sucesso!', body: 'Anexo salvo com sucesso');
          cameraGallery.listFiles.removeAt(index);
        }
      }
      loadingAttachmentsToIndex.value = _indexSaveAttachement;
      loadingSaveAttachments.value = false;
    } catch (e) {
      AppLog.d('Não foi possível salvar o anexo para o paciente$e', name: 'saveAttachment');
      loadingSaveAttachments.value = false;
      loadingAttachmentsToIndex.value = _indexSaveAttachement;
    }
  }
}
