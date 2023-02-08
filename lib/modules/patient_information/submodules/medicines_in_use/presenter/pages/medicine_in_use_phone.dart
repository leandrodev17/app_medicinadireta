import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/mixin/basic_page_mixin.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/infra/models/medicines_in_use_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/presenter/controller/medicine_in_use_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/presenter/widgets/shimmer_medicine_in_use.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicineInUsePhone extends BasePage {
  MedicineInUsePhone({Key? key}) : super(key: key);

  @override
  _MedicineInUsePhoneState createState() => _MedicineInUsePhoneState();
}

class _MedicineInUsePhoneState extends BaseState<MedicineInUsePhone> with WidgetsBindingObserver, BasicPage {
  final _controller = Get.find<MedicineInUseController>();
  ParamsToNavigationPage _params = Get.arguments;
  final _scrollController = ScrollController();

  @override
  String screenName() => 'medicines_in_use'.tr;

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  AppBottomNavigationBar? bottomNavigationBar() => AppBottomNavigationBar();

  @override
  Function()? onPressedLeading() => () => Get.toNamed(Routes.PATIENT_DETAILS, arguments: _params);

  @override
  ParamsToNavigationPage? screenCardPatient() => _params;

  @override
  Widget? floatingActionButton() => null;

  @override
  List<Widget>? actions() => [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getFirstPage(isFirst: true, patientId: _params.pacienteId!);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget body() => _body();

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
                Obx(() {
                  if ((_controller.isLoading.value == AppLoadingStatus.notLoading) || (_controller.isLoading.value == AppLoadingStatus.nextPageLoading)) {
                    if (_controller.listMedicineInUse.isEmpty) {
                      return Container(
                        height: view.localWidgetSize!.height,
                        alignment: Alignment.center,
                        child: AppNotHasdata(loadData: () async => await _controller.getFirstPage(isFirst: true, patientId: _params.pacienteId!)),
                      );
                    }
                    return ListView.separated(
                      itemBuilder: (_, index) {
                        final MedicinesInUseExt _medicine = _controller.listMedicineInUse[index];
                        var _title = _medicine.medicamentoDescricao == null || _medicine.medicamentoDescricao == '' ? null : _medicine.medicamentoDescricao;
                        return Column(
                          children: <Widget>[
                            ListTile(
                              onTap: () async => await Get.toNamed(Routes.MEDICINES_DETAIL, arguments: [_params, _medicine]),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              title: Text(_title ?? 'no_value'.tr),
                              trailing: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).colorScheme.secondary),
                            ),
                          ],
                        );
                      },
                      itemCount: _controller.listMedicineInUse.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (_, index) => Divider(),
                    );
                  } else {
                    if (_controller.isLoading.value == AppLoadingStatus.shimmerLoading) {
                      return ShimmerMedicineInUse();
                    } else {
                      return Center(child: Container(child: CupertinoActivityIndicator()));
                    }
                  }
                }),
                Obx(() {
                  return Visibility(
                    visible: _controller.isLoading.value == AppLoadingStatus.nextPageLoading,
                    child: Padding(
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
