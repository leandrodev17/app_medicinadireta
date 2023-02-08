import 'dart:io';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/form/app_text_field.dart';
import 'package:medicinadireta/core/widgets/form/render_when.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/presenter/controller/attachments_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/presenter/widgets/view_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PhotoCameraOrGallery extends StatefulWidget {
  final AttachmentsController controller;
  final int pacienteId;
  PhotoCameraOrGallery({required this.controller, required this.pacienteId, Key? key}) : super(key: key);

  @override
  _PhotoCameraOrGalleryState createState() => _PhotoCameraOrGalleryState();
}

class _PhotoCameraOrGalleryState extends State<PhotoCameraOrGallery> with WidgetsBindingObserver {
  AttachmentsController get _controller => widget.controller;
  int get _pacienteId => widget.pacienteId;

  Map<int, String> _mapLegendaFile = Map<int, String>();
  final _controllerEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapLegendaFile.clear();
      _controller.cameraGallery.listFiles.clear();
      // _controller.listFilesBlocked.clear();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _controllerEC.dispose();
    _mapLegendaFile.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
        title: Text(
          'choose_image_source'.tr,
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
      ),
      body: ResponsiveBuilder(builder: (context, view) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AppButton(
                        childRaisedButton: Text('camera'.tr),
                        onPressed: () async => await _controller.cameraGallery.getFromImage(isEmptyListFiles: false),
                        colorBackground: ConstColors.blue,
                        height: 60,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: AppButton(
                          childRaisedButton: Text('gallery'.tr),
                          onPressed: () async => await _controller.cameraGallery.getFromGallery(isEmptyListFiles: false),
                          colorBackground: ConstColors.blue,
                          height: 60),
                    ),
                  ],
                ),
              ),
              Divider(height: 2, color: ConstColors.border),
              Obx(() {
                _controller.cameraGallery.listFiles.length;
                if (_controller.cameraGallery.listFiles.isEmpty) {
                  return Expanded(
                    child: Container(
                      height: view.localWidgetSize?.height,
                      alignment: Alignment.center,
                      child: AppNotHasdata(
                        message: "choose_image_source".tr,
                        visibleOnPressed: false,
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final File _file = _controller.cameraGallery.listFiles[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => ViewPhoto(file: _file),
                                fullscreenDialog: true,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 40.0,
                              child: ClipRRect(
                                child: Image.file(_file, height: 120, width: 120, fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                          Obx(() {
                            // loadingSaveAttachments está rodando? : Não permite que o usuário fique clicando em várias fotos;
                            // loadingAttachmentsToIndex se for igual o index da lista habilita o loagind;
                            // loadingAttachmentsToIndex se for igual o index da lista bloquea o botão para não enviar outra requisição;
                            // listFilesBlocked se o index existir dentro na lista seguinifica que foi enviado para o servidor, desabilita o delete e o salvar
                            var _isSave = (_controller.loadingSaveAttachments.value || _controller.loadingAttachmentsToIndex.value == index);
                            return Expanded(
                              child: Column(
                                children: [
                                  // P analisar uma solucao: Se usar a controller e enviar o valor para a funcao de salvar a proxima legenda precisa zerar a legenda
                                  // se nao zerar leva o mesmo valor.
                                  // talvez fosse melhor bloquear o proximo campo de legenda e deixar um por vez
                                  Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: AppTextField(
                                      // controller: _controllerEC,
                                      maxLength: 80,
                                      labelText: 'Legenda'.tr,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      enabled: !_isSave,
                                      onChanged: (String? v) {
                                        if (v != null) _mapLegendaFile[index] = v;
                                      },
                                      maxLines: 2,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      AppButton(
                                        key: ValueKey("save_$index"),
                                        childRaisedButton: RenderWhen(text: 'save'.tr, isLoading: _controller.loadingAttachmentsToIndex.value == index),
                                        onPressed: _isSave ? null : () async => await _controller.saveAttachment(index, _pacienteId, _mapLegendaFile),
                                        colorBackground: ConstColors.greenDark,
                                        height: 30,
                                        minWidth: 120,
                                      ),
                                      const SizedBox(width: 8),
                                      AppButton(
                                        key: ValueKey("remove_$index"),
                                        childRaisedButton: Text('delete'.tr),
                                        onPressed: _isSave ? null : () => _controller.removeFileFromList(index),
                                        colorBackground: ConstColors.danger,
                                        height: 30,
                                        minWidth: 120,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: _controller.cameraGallery.listFiles.length,
                  ),
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}
