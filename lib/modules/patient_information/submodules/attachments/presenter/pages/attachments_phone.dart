import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/controller_from_initial/verification_access_menu_user.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/enum/paper_access_user.dart';
import 'package:medicinadireta/core/mixin/basic_page_mixin.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/core/widgets/switch_control_widget.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/infra/models/attachments_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/presenter/controller/attachments_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/presenter/widgets/photo_camera_or_gallery.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/presenter/widgets/shimmer_attachments.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/presenter/widgets/view_attachment.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttachmentsPhone extends BasePage {
  AttachmentsPhone({Key? key}) : super(key: key);

  @override
  _AttachmentsPhoneState createState() => _AttachmentsPhoneState();
}

class _AttachmentsPhoneState extends BaseState<AttachmentsPhone> with WidgetsBindingObserver, BasicPage {
  final _controller = Get.find<AttachmentsController>();
  final _access = Get.find<VerificationAccessMenuUser>();
  ParamsToNavigationPage _params = Get.arguments;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.pacienteId.value = _params.pacienteId ?? 0;
      _controller.getFirstPage(isFirst: true, patientId: _params.pacienteId!);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  _areaNewPhoto() async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => PhotoCameraOrGallery(pacienteId: _params.pacienteId ?? 0, controller: _controller),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  String screenName() => 'attachments'.tr;

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  AppBottomNavigationBar? bottomNavigationBar() => const AppBottomNavigationBar();

  @override
  Function()? onPressedLeading() => () => Get.toNamed(Routes.PATIENT_DETAILS, arguments: _params);

  @override
  ParamsToNavigationPage? screenCardPatient() => _params;

  @override
  Widget? floatingActionButton() => null;

  @override
  List<Widget>? actions() => [
        Visibility(
          visible: _access.accessPaper(Routes.ATTACHMENTS, PaperAccessUser.PRIVATE_PRINT),
          child: IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            onPressed: () async => await _areaNewPhoto(),
            icon: const Icon(Icons.camera_alt_rounded, color: ConstColors.blue),
          ),
        ),
      ];

  @override
  Widget body() {
    return _body();
  }

  Widget _body() {
    return ResponsiveBuilder(builder: (context, view) {
      return RefreshIndicator(
        onRefresh: () async => await _controller.swipeRefresh(_params.pacienteId!),
        child: CupertinoScrollbar(
          thumbVisibility: false,
          controller: _scrollController,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            child: AnimatedFromColumn(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Container(
                //   alignment: Alignment.center,
                //   width: MediaQuery.of(context).size.width * .35,
                //   padding: const EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     color: ConstColors.blue,
                //     borderRadius: BorderRadius.circular(4),
                //   ),
                //   child: Text(
                //     "Imagens",
                //     style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                //   ),
                // ),
                Obx(() {
                  return SwitchControlWidget(
                    selectedValue: _controller.indexTypeDocuments.value,
                    controls: {
                      0: Text('images'.tr),
                      1: Container(
                        padding: const EdgeInsets.all(8),
                        child: Text('documents'.tr),
                      ),
                    },
                    onValueChanged: (data) async => await _controller.onValueChanged(data, _params.pacienteId!),
                  );
                }),
                const Divider(),
                Obx(() {
                  if (_controller.indexTypeDocuments.value == 0) {
                    if ((_controller.isLoading.value == AppLoadingStatus.notLoading) || (_controller.isLoading.value == AppLoadingStatus.nextPageLoading)) {
                      if (_controller.listAttachments.isEmpty) {
                        return Container(
                          height: view.localWidgetSize!.height,
                          alignment: Alignment.center,
                          child: AppNotHasdata(loadData: () async => await _controller.swipeRefresh(_params.pacienteId!)),
                        );
                      }
                      return ItemAttachments(controller: _controller, listAttachments: _controller.listAttachments);
                    } else {
                      if (_controller.isLoading.value == AppLoadingStatus.shimmerLoading) {
                        return const ShimmerAttachments();
                      } else {
                        return const Center(child: CupertinoActivityIndicator());
                      }
                    }
                  } else {
                    if ((_controller.isLoadingDocuments.value == AppLoadingStatus.notLoading) || (_controller.isLoadingDocuments.value == AppLoadingStatus.nextPageLoading)) {
                      if (_controller.listAttachmentsDocuments.isEmpty) {
                        return Container(
                          height: view.localWidgetSize!.height,
                          alignment: Alignment.center,
                          child: AppNotHasdata(loadData: () async => await _controller.getFirstPageDocuments(isFirst: true, patientId: _params.pacienteId!)),
                        );
                      }
                      return ItemAttachments(controller: _controller, listAttachments: _controller.listAttachmentsDocuments);
                    } else {
                      if (_controller.isLoadingDocuments.value == AppLoadingStatus.shimmerLoading) {
                        return const ShimmerAttachments();
                      } else {
                        return const Center(child: CupertinoActivityIndicator());
                      }
                    }
                  }
                }),
                Obx(() {
                  return Visibility(
                    visible: _controller.isLoading.value == AppLoadingStatus.nextPageLoading,
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: CupertinoActivityIndicator(),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class ItemAttachments extends StatelessWidget {
  final List<AttachmentsExt> listAttachments;
  final AttachmentsController controller;
  const ItemAttachments({Key? key, required this.listAttachments, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) {
        final AttachmentsExt _modelAttachments = listAttachments[index];
        return Column(
          children: <Widget>[
            ListTile(
              onTap: () async {
                if (controller.indexTypeDocuments.value == 0) {
                  await Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => ViewAttachment(model: _modelAttachments, controller: controller),
                      fullscreenDialog: true,
                    ),
                  );
                }
                if (controller.indexTypeDocuments.value == 1) {
                  controller.loadingOpenFile.value = false;
                  controller.failureGeneratorFile.value = false;
                  await controller.showOpenFile(_modelAttachments.id!, _modelAttachments.nomeArquivo ?? '');
                }
              },
              contentPadding: EdgeInsets.zero, //const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
              title: Text(
                _modelAttachments.legenda ?? '--',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              subtitle: Text(
                _modelAttachments.nomeArquivo ?? '--',
                style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.grey.shade500),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            )
          ],
        );
      },
      itemCount: listAttachments.length,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shrinkWrap: true,
      separatorBuilder: (_, index) => const Divider(height: 0.5),
    );
  }
}
