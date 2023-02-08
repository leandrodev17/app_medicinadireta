import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/infra/models/attachments_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/presenter/controller/attachments_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/presenter/widgets/shimmer_attachments_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ViewAttachment extends StatefulWidget {
  final AttachmentsController controller;
  final AttachmentsExt model;
  ViewAttachment({required this.controller, required this.model, Key? key}) : super(key: key);

  @override
  _ViewAttachmentState createState() => _ViewAttachmentState();
}

class _ViewAttachmentState extends State<ViewAttachment> with WidgetsBindingObserver {
  AttachmentsController get _controller => widget.controller;
  AttachmentsExt get _model => widget.model;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
       _controller.getAttachment(_model.id!);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(
          'attachments'.tr,
          // style: Theme.of(context).appBarTheme.textTheme!.headline6!.copyWith(fontSize: 20),
        ),
      ),
      body: ResponsiveBuilder(builder: (context, view) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (_controller.loadingAttachment.value) {
                return ShimmerAttachmentsView();
              }

              if (_controller.attachmentUint8List.value.isEmpty) {
                return Container(
                  height: view.localWidgetSize!.height,
                  alignment: Alignment.center,
                  child: AppNotHasdata(
                    message: "not_found_image".tr,
                    visibleOnPressed: false,
                  ),
                );
              }

              return Expanded(
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(17),
                      height: view.localWidgetSize?.height,
                      width: view.localWidgetSize?.width,
                      alignment: Alignment.center,
                      child: PhotoView(
                        backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                        imageProvider: MemoryImage(_controller.attachmentUint8List.value),
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        );
      }),
    );
  }
}
