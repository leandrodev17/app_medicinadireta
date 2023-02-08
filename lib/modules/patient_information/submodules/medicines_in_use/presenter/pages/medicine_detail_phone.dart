import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/mixin/basic_page_mixin.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/infra/models/medicines_in_use_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/presenter/widgets/widget_medicine_detail.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class MedicineDetailPhone extends BasePage {
  MedicineDetailPhone({Key? key}) : super(key: key);

  @override
  _MedicineDetailPhoneState createState() => _MedicineDetailPhoneState();
}

class _MedicineDetailPhoneState extends BaseState<MedicineDetailPhone> with WidgetsBindingObserver, BasicPage {
  ParamsToNavigationPage _params = Get.arguments[0];
  MedicinesInUseExt _medicamento = Get.arguments[1];
  final _scrollController = ScrollController();

  @override
  String screenName() => 'detail'.tr;

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  AppBottomNavigationBar? bottomNavigationBar() => AppBottomNavigationBar();

  @override
  Function()? onPressedLeading() => () => Navigator.pop(context);

  @override
  ParamsToNavigationPage? screenCardPatient() => _params;

  @override
  Widget? floatingActionButton() => null;

  @override
  List<Widget>? actions() => [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget body() {
    return _body();
  }

  Widget _body() {
    var _laboratorio = _medicamento.medicamento?.laboratorio != null ? _medicamento.medicamento!.laboratorio : "no_value".tr;
    var _descricao = _medicamento.medicamento?.descricao != null ? _medicamento.medicamento!.descricao : "no_value".tr;
    var _apresentacao = _medicamento.medicamento?.apresentacao != null ? _medicamento.medicamento!.apresentacao : "no_value".tr;
    var _restricaoHospitalar = _medicamento.medicamento?.restricaoHospitalar != null ? _medicamento.medicamento!.restricaoHospitalar : "no_value".tr;

    var _dataUsoIni = _medicamento.dataUsoIni != null ? FormatsDatetime.formatDate(DateTime.parse(_medicamento.dataUsoIni!), FormatsDatetime.dateFormat) : "no_value".tr;
    var _dataUsoFim = _medicamento.dataUsoFim != null ? FormatsDatetime.formatDate(DateTime.parse(_medicamento.dataUsoFim!), FormatsDatetime.dateFormat) : "no_value".tr;

    return ResponsiveBuilder(builder: (context, view) {
      return CupertinoScrollbar(
        thumbVisibility: false,
        controller: _scrollController,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(3),
          controller: _scrollController,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: AnimatedFromColumn(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                WidgetMedicineDetail(title: 'medicine'.tr, detail: _descricao!),
                WidgetMedicineDetail(title: 'medicine_description'.tr, detail: _apresentacao!),
                WidgetMedicineDetail(title: 'medicine_laboratory'.tr, detail: _laboratorio!),
                WidgetMedicineDetail(title: 'medicine_restriction'.tr, detail: _restricaoHospitalar!),
                WidgetMedicineDetail(title: 'init_date'.tr, detail: _dataUsoIni),
                WidgetMedicineDetail(title: 'init_end'.tr, detail: _dataUsoFim),
                WidgetMedicineDetail(title: 'Status', detail: 'undefined'.tr),
                WidgetMedicineDetail(title: 'medicine_type'.tr, detail: 'undefined'.tr),
              ],
            ),
          ),
        ),
      );
    });
  }
}
