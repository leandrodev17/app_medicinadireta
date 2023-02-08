import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';

class CameraGalleryController extends GetxController {
  final RxList<File> listFiles = RxList<File>();
  final RxList<File> filePerfil = RxList<File>();
  final ImagePicker _picker = ImagePicker();
  Future<String?> _fromImage() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        return photo.path;
      }
      return null;
    } catch (e) {
      AppLog.d('Não foi possível abrir a câmera $e', name: 'getFromImage');
      return null;
    }
  }

  // TODO Camera no IOS está travado, quando abre uma vez vai com sucesso na segunda não vai
  Future<String?> _fromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) return image.path;
      return null;
    } catch (e) {
      AppLog.d('Não foi possível abrir a galeria $e', name: 'getFromGallery');
      return null;
    }
  }

  // foto da camera para o perfil
  Future<void> getFromImagePerfil() async {
    filePerfil.clear();
    var path = await _fromImage();
    if (path != null) {
      var file = await _cropImage(path);
      if (file != null) filePerfil.add(file);
    }
    // Get.back();
  }

  Future<File?> appFromCamera() async {
    var path = await _fromImage();
    if (path == null) return null;
    var file = await _cropImage(path);
    if (file == null) return null;
    return file;
  }

  // foto da galeria para o perfil
  Future<File?> appFromGallery() async {
    var path = await _fromGallery();
    if (path == null) return null;
    var file = await _cropImage(path);
    if (file == null) return null;
    return file;
  }

  Future<void> getFromGalleryPerfil() async {
    filePerfil.clear();
    var path = await _fromGallery();
    if (path != null) {
      var file = await _cropImage(path);
      if (file != null) filePerfil.add(file);
    }
    Get.back();
  }

  Future<void> getFromImage({bool isEmptyListFiles = true}) async {
    if (isEmptyListFiles) listFiles.clear();
    var path = await _fromImage();
    if (path != null) {
      var file = await _cropImage(path);
      if (file != null) listFiles.insert(0, file);
    }
  }

  Future<void> getFromGallery({bool isEmptyListFiles = true}) async {
    if (isEmptyListFiles) listFiles.clear();
    var path = await _fromGallery();
    if (path != null) {
      var file = await _cropImage(path);
      if (file != null) listFiles.insert(0, file);
    }
  }

  Future<void> deletePhoto(int index) async {
    listFiles.removeAt(index);
  }

  Future<File?> _cropImage(String sourcePath) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: sourcePath,
        compressFormat: ImageCompressFormat.jpg,
        maxHeight: 1080,
        maxWidth: 1920,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'app_name'.tr,
            toolbarColor: Colors.white,
            toolbarWidgetColor: ConstColors.blue,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
            title: 'app_name'.tr,
            doneButtonTitle: 'ok'.tr,
            showCancelConfirmationDialog: true,
            cancelButtonTitle: 'cancel'.tr,
          ),
        ],
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
      );
      if (croppedFile?.path != null) return File(croppedFile!.path);
      return null;
    } catch (e) {
      AppLog.d('Não foi possível recortar a image $e', name: '_cropImage');
      return null;
    }
  }

  showCameraOrGallery() async {
    await Get.defaultDialog(
      radius: 5,
      title: 'choose_image_source'.tr,
      titleStyle: Theme.of(Get.context!).textTheme.subtitle1,
      content: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: AppButton(
                childRaisedButton: Text('camera'.tr),
                onPressed: () async {
                  Get.back();
                  await getFromImagePerfil();
                },
                colorBackground: ConstColors.blue,
                height: 30,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: AppButton(
                childRaisedButton: Text('gallery'.tr),
                onPressed: () async => await getFromGalleryPerfil(),
                colorBackground: ConstColors.blue,
                height: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
