import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/controller_from_initial/verification_access_menu_user.dart';
import 'package:medicinadireta/core/drawer/search.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/helpers/helpers.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/models/patient/patient_model_ext.dart';
import 'package:medicinadireta/core/page_not_access/presenter/page_not_access_screen.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/core/widgets/card_list_patient_finance.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/patient/presenter/controller/patient_controller.dart';
import 'package:medicinadireta/modules/patient/presenter/widgets/shimmer_patient.dart';
import 'package:medicinadireta/routes/app_pages.dart';

class PatientPhone extends StatefulWidget {
  const PatientPhone({Key? key}) : super(key: key);

  @override
  PatientPhoneState createState() => PatientPhoneState();
}

class PatientPhoneState extends State<PatientPhone> with WidgetsBindingObserver {
  final _controller = Get.find<PatientController>();
  final _access = Get.find<VerificationAccessMenuUser>();
  final _scrollController = ScrollController();
  final _debouncer = Debouncer(delay: const Duration(seconds: 1));
  var visible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.isOpenTextFieldSearch.value = false;
      _controller.getFirstPage(true);

      /// Carrega as permissões
      _access.loadingAccessUser();

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
    /// Sem permissão para acessar a lista de cliente
    if (!_access.existsKeyMenu(Routes.LIST_PATIENT)) return PageNotAccessScreen();
    return AppScaffold(
      backgroundColor: ConstColors.backgroundDefault,
      bottomNavigationBar: AppBottomNavigationBar(disablePatient: true),
      body: SafeArea(
        child: AppScaffold(
          backgroundColor: ConstColors.backgroundDefault,
          onWillPop: () async => await Get.toNamed(Routes.MENU),
          appBar: AppBarDefault.bar(
            onPressedLeading: () => Get.toNamed(Routes.MENU),
            titleApp: 'patients',
            actions: [
              IconButton(
                onPressed: _controller.openTextFieldSearch,
                icon: const Icon(Icons.search, color: Colors.black),
              ),
            ],
          ),
          body: ResponsiveBuilder(builder: (context, view) {
            return CupertinoScrollbar(
              controller: _scrollController,
              child: RefreshIndicator(
                onRefresh: () async => await _controller.swipeRefresh(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: _scrollController,
                        child: AnimatedFromColumn(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(() => Visibility(visible: _controller.isOpenTextFieldSearch.value, child: const SizedBox(height: 90))),
                            Obx(() {
                              //Search
                              if (_controller.isLoading.value == AppLoadingStatus.searchLoading) {
                                if (_controller.isLoadingSearch.value) return const ShimmerPatient();
                                if (_controller.listPatientSearch.isEmpty) {
                                  return Container(
                                    height: view.localWidgetSize!.height,
                                    alignment: Alignment.center,
                                    child: AppNotHasdata(
                                      message: "notHashData".tr,
                                      visibleOnPressed: false,
                                    ),
                                  );
                                }
                                return ListItemPatient(_controller.listPatientSearch);
                              } else if ((_controller.isLoading.value == AppLoadingStatus.notLoading) || (_controller.isLoading.value == AppLoadingStatus.nextPageLoading)) {
                                if (_controller.listPatient.isEmpty) {
                                  return Container(
                                    height: view.localWidgetSize!.height,
                                    alignment: Alignment.center,
                                    child: AppNotHasdata(loadData: () async => await _controller.getFirstPage()),
                                  );
                                }
                                return ListItemPatient(_controller.listPatient);
                              } else {
                                if (_controller.isLoading.value == AppLoadingStatus.shimmerLoading) {
                                  return const ShimmerPatient();
                                } else {
                                  return const Center(child: CupertinoActivityIndicator());
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
                      Obx(() {
                        return Visibility(
                          visible: _controller.isOpenTextFieldSearch.value,
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
                                    _controller.onChangeSearchPatient(data);
                                    _debouncer(() async {
                                      if (data != '' && data.length > 3) {
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

class ListItemPatient extends StatelessWidget {
  final List<PatientModelExt> listPatient;

  const ListItemPatient(this.listPatient, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        final PatientModelExt _model = listPatient[index];
        var _phone = _model.telefones != null && _model.telefones!.isNotEmpty ? _model.telefones!.first.formatted() : 'no_phone'.tr;
        // var _email = _model.email != '' || _model.email != null ? _model.email : "no_value".tr;
        var _prontuario = _model.prontuario != null ? _model.prontuario : "no_value".tr;
        var _name = _model.nome != null ? _model.nome : "no_value".tr;
        var _email = _model.email != null ? _model.email : "no_value".tr;

        List<String> _idade = _model.idade != null ? _model.idade!.split(" ").toList() : [];
        var _age = _idade.first;

        Uint8List? _foto = Helpers.convertBase64MemoryImage(_model.fotoBase64);

        var _newParams = ParamsToNavigationPage(
          email: _email,
          pacienteId: _model.id,
          idade: _age,
          nomeDoPaciente: _model.nome,
          numeroDoProtuario: _model.prontuario,
          telefone: _phone,
          observacaoDoPaciente: _model.observacoes,
          voltarParaPagina: Routes.LIST_PATIENT,
          photoPerfil: _foto,
        );

        return CardListPatientFinance(
          foto: _foto,
          key: ValueKey(_model.id),
          name: _name,
          prontuario: _prontuario.toString(),
          onTap: () async => await Get.toNamed(Routes.PATIENT_DETAILS, arguments: _newParams),
        );
      },
      itemCount: listPatient.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // separatorBuilder: (_, index) => Divider(),
    );
  }
}
