import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/controller_from_initial/force_version_controller.dart';
import 'package:medicinadireta/core/controller_from_initial/verification_access_menu_user.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/doctor_schedule/infra/models/doctor_schedule_ext.dart';
import 'package:medicinadireta/modules/doctor_schedule/presenter/controllers/doctor_schedule_controller.dart';
import 'package:medicinadireta/modules/doctor_schedule/presenter/widgets/item_list_doctor_schedule.dart';
import 'package:medicinadireta/modules/doctor_schedule/presenter/widgets/shimmer_doctor_schedule.dart';
import 'package:medicinadireta/modules/websocket/signal_websocket.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';

import '/core/animation/animated_from_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorSchedulePhone extends StatefulWidget {
  const DoctorSchedulePhone({Key? key}) : super(key: key);

  @override
  DoctorSchedulePhoneState createState() => DoctorSchedulePhoneState();
}

class DoctorSchedulePhoneState extends State<DoctorSchedulePhone> with WidgetsBindingObserver {
  final DoctorScheduleController _controller = Get.find<DoctorScheduleController>();
  final _forceApp = Get.find<ForceVersionController>();
  final _access = Get.find<VerificationAccessMenuUser>();
  final scrollController = ScrollController();

  /// Verifica a versão e redireciona caso precise ser atualizado.
  _forceUpdateVersion() async {
    final bool isForceUpdate = await _forceApp.isForceUpdateApp();
    await Future.delayed(const Duration(seconds: 1)).then((value) async {
      if (isForceUpdate) {
        await _forceApp.forceUpdateApp();
        return;
      }
    }).catchError((e) {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SignalWebsocket.instance.openConnection;
      _controller.getFirstPage(true);
      _access.loadingAccessUser();
      _access.appDevice();
      _forceUpdateVersion();
      scrollController.addListener(() {
        _controller.onScroll(scrollController.position.pixels, scrollController.position.maxScrollExtent);
      });
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: ConstColors.backgroundDefault,
      bottomNavigationBar: AppBottomNavigationBar(disableSchedule: true),
      body: SafeArea(
        child: AppScaffold(
          backgroundColor: ConstColors.backgroundDefault,
          appBar: AppBarDefault.bar(
            showIconBackTop: false,
            onPressedLeading: () => Get.toNamed(Routes.MENU),
            titleApp: 'schedule',
            actions: [
              IconButton(
                onPressed: () => Get.toNamed(Routes.DOCTOR_ACHEDULE_PATIENT),
                icon: const Icon(
                  Icons.event_note,
                  size: 30,
                ),
              ),
            ],
          ),
          body: ResponsiveBuilder(builder: (context, view) {
            return RefreshIndicator(
              onRefresh: () async => await _controller.swipeRefresh(),
              child: CupertinoScrollbar(
                thumbVisibility: false,
                controller: scrollController,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: scrollController,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AnimatedFromColumn(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Obx(() {
                          if (_controller.isLoading.value == AppLoadingStatus.notConnecting) {
                            return Container(
                              height: view.localWidgetSize?.height,
                              alignment: Alignment.center,
                              child: AppNotHasdata(loadData: () async => await _controller.getFirstPage(true)),
                            );
                          }
                          if ((_controller.isLoading.value == AppLoadingStatus.notLoading) || (_controller.isLoading.value == AppLoadingStatus.nextPageLoading)) {
                            if (_controller.listDoctorSchedule.isEmpty) {
                              return Container(
                                height: view.localWidgetSize!.height,
                                alignment: Alignment.center,
                                child: AppNotHasdata(loadData: () async => await _controller.getFirstPage(true)),
                              );
                            }

                            return ListView.builder(
                              itemBuilder: (_, index) {
                                final DoctorScheduleExt _model = _controller.listDoctorSchedule[index];
                                int cor = _controller.formatColor(_model.cor);
                                return Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  child: ClipPath(
                                    clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                    child: Container(
                                      decoration: BoxDecoration(border: Border(left: BorderSide(color: Color(cor), width: 8))),
                                      child: ItemListDoctorSchedule(
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                        label: _model.descricao.toString().trim(),
                                        onTab: () => Get.toNamed(
                                          Routes.DOCTOR_COMMITMENT,
                                          arguments: ParamsToNavigationPage(doutorId: _model.id, nomeDoMedico: _model.descricao, profissionalId: _model.profissionalId, dataDoFiltroDePesquisa: DateTime.now().toString(), cardColor: _model.cor),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: _controller.listDoctorSchedule.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                            );
                          } else {
                            if (_controller.isLoading.value == AppLoadingStatus.shimmerLoading) {
                              return const ShimmerDoctorSchedule();
                            } else {
                              return const CupertinoActivityIndicator();
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
              ),
            );
          }),
        ),
      ),
    );
  }
}
