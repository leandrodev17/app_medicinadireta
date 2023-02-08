import 'dart:typed_data';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/drawer/search.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/helpers/helpers.dart';
import 'package:medicinadireta/core/models/patient/patient_model_ext.dart';
import 'package:medicinadireta/core/navigator_app/navigator_app.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/core/widgets/card_list_patient_finance.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/financial/presenter/controller/financial_controller.dart';
import 'package:medicinadireta/modules/financial/presenter/widgets/shimmer_financial.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import 'service_order_phone.dart';

class FinancialPhone extends StatefulWidget {
  FinancialPhone({Key? key}) : super(key: key);

  @override
  _FinancialPhoneState createState() => _FinancialPhoneState();
}

class _FinancialPhoneState extends State<FinancialPhone> with WidgetsBindingObserver {
  final _controller = Get.find<FinancialController>();
  final _scrollController = ScrollController();
  final _debouncer = Debouncer(delay: Duration(milliseconds: 500));
  var visible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.isOpenTextFieldSearchFinancial.value = false;
      _controller.getFirstPage(true);
      _scrollController.addListener(() {
        _controller.onScroll(_scrollController.position.pixels, _scrollController.position.maxScrollExtent);
      });
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: ConstColors.backgroundDefault,
      onWillPop: () async => await Get.toNamed(Routes.MENU),
      bottomNavigationBar: AppBottomNavigationBar(),
      body: SafeArea(
        child: AppScaffold(
          backgroundColor: ConstColors.backgroundDefault,
          appBar: AppBarDefault.bar(
            onPressedLeading: () => Get.toNamed(Routes.MENU),
            titleApp: 'financial',
            actions: [
              IconButton(
                onPressed: _controller.openTextFieldSearchFinancial,
                icon: Icon(Icons.search, color: Colors.black),
              ),
            ],
          ),
          body: ResponsiveBuilder(builder: (context, view) {
            return CupertinoScrollbar(
              thumbVisibility: false,
              controller: _scrollController,
              child: RefreshIndicator(
                onRefresh: () async => await _controller.swipeRefresh(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(3),
                        controller: _scrollController,
                        child: AnimatedFromColumn(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(() => Visibility(visible: _controller.isOpenTextFieldSearchFinancial.value, child: SizedBox(height: 90))),
                            Obx(() {
                              //Search
                              if (_controller.isLoading.value == AppLoadingStatus.searchLoading) {
                                if (_controller.isLoadingSearchFinancial.value) return ShimmerFinancial();
                                if (_controller.listPatientFinancialSearch.isEmpty) {
                                  return Container(
                                    height: view.localWidgetSize!.height,
                                    alignment: Alignment.center,
                                    child: AppNotHasdata(
                                      message: "Não foi possível localizar o paciente, por favor, verifique o nome informado.",
                                      visibleOnPressed: false,
                                    ),
                                  );
                                }
                                return ListItemPatientFinancial(_controller.listPatientFinancialSearch);
                              }
                              if ((_controller.isLoading.value == AppLoadingStatus.notLoading) || (_controller.isLoading.value == AppLoadingStatus.nextPageLoading)) {
                                if (_controller.listPatientFinancial.isEmpty) {
                                  return Container(
                                    height: view.localWidgetSize!.height,
                                    alignment: Alignment.center,
                                    child: AppNotHasdata(loadData: () async => await _controller.getFirstPage()),
                                  );
                                }
                                return ListItemPatientFinancial(_controller.listPatientFinancial);
                              } else {
                                if (_controller.isLoading.value == AppLoadingStatus.shimmerLoading) {
                                  return ShimmerFinancial();
                                } else {
                                  return Container(child: CupertinoActivityIndicator());
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
                      Obx(() {
                        return Visibility(
                          visible: _controller.isOpenTextFieldSearchFinancial.value,
                          child: Positioned(
                            top: 0,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 80,
                                maxWidth: MediaQuery.of(context).size.width,
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                color: Colors.transparent,
                                child: Search(
                                  onPressed: () => _controller.searchPatient(),
                                  autofocus: true,
                                  onChanged: (data) {
                                    _controller.onChangeSearchPatientFinancial(data);
                                    _debouncer(() async {
                                      if (data.length > 3) {
                                        await _controller.searchPatient();
                                      } else {
                                        _controller.isLoading.value = AppLoadingStatus.notLoading;
                                      }
                                    });
                                  },
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "search_patient".tr,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
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

class ListItemPatientFinancial extends StatelessWidget {
  final List<PatientModelExt> listFinancial;

  ListItemPatientFinancial(this.listFinancial, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12, top: 8),
      child: ListView.builder(
        itemBuilder: (_, index) {
          final PatientModelExt _model = listFinancial[index];
          // final Financial _financial = Financial(prontuario: _model.prontuario, nome: _model.nome, id: _model.id);

          var _phone = _model.telefones != null && _model.telefones!.isNotEmpty ? _model.telefones!.first.formatted() : 'no_phone'.tr;
          var _email = _model.email != '' ? _model.email : "no_value".tr;
          var _prontuario = _model.prontuario != null ? _model.prontuario : "no_value".tr;
          var _name = _model.nome != null ? _model.nome : "no_value".tr;
          Uint8List? _foto = Helpers.convertBase64MemoryImage(_model.fotoBase64);

          return CardListPatientFinance(
            foto: _foto,
            key: ValueKey(_model.id),
            name: _name,
            prontuario: _prontuario.toString(),
            onTap: () async => await NavigatorApp.openMyPage(context, ServiceOrderPhone(model: _model), fullscreenDialog: true),
            // onTap: () async => await Get.toNamed(Routes.SERVICE_ORDER, arguments: _model),
          );

          // return Container(
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     border: Border.all(width: 1.0, color: ConstColors.border),
          //     borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
          //   ),
          //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          //   margin: EdgeInsets.symmetric(vertical: 5),
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 12),
          //     child: Column(
          //       children: <Widget>[
          //         NumberRecordPatient(title: 'patient_record'.tr, info: _prontuario.toString()),
          //         ListTile(
          //           // onTap: () async => await Get.toNamed(Routes.SERVICE_ORDER, arguments: _financial),
          //           contentPadding: EdgeInsets.zero,
          //           title: Text(_name ?? "no_value".tr),
          //           subtitle: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: <Widget>[
          //               const SizedBox(height: 4),
          //               Text(_email?.trim() ?? "no_value".tr),
          //               const SizedBox(height: 4),
          //               Text(_phone),
          //             ],
          //           ),
          //           trailing: Icon(Icons.keyboard_arrow_right, color: ConstColors.orange, size: 30),
          //         )
          //       ],
          //     ),
          //   ),
          // );
        },
        itemCount: listFinancial.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        // separatorBuilder: (_, index) => Divider(),
      ),
    );
  }
}
