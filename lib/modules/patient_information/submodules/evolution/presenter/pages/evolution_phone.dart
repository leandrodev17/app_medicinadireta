import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/controller_from_initial/verification_access_menu_user.dart';
import 'package:medicinadireta/core/enum/paper_access_user.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/mixin/basic_page_mixin.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_html.dart';
import 'package:medicinadireta/core/widgets/app_not_connecting.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/core/widgets/form/app_button_simple.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/widgets/shimmer_doctor_commitment.dart';
import 'package:medicinadireta/modules/patient_information/commons/controllers/commons_controller_soap.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/evolution_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/presenter/controller/evolution_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/presenter/controller/form_evolution_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/presenter/widgets/form_evolution.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/card_item_evolution.dart';

class EvolutionPhone extends BasePage {
  EvolutionPhone({Key? key}) : super(key: key);

  @override
  _EvolutionPhoneState createState() => _EvolutionPhoneState();
}

class _EvolutionPhoneState extends BaseState<EvolutionPhone> with WidgetsBindingObserver, BasicPage {
  final _evolution = Get.find<EvolutionController>();
  final _access = Get.find<VerificationAccessMenuUser>();
  final _evolutionForm = Get.find<FormEvolutionController>();
  final _commonsController = CommonsControllerSoap();

  int _isExpandedIndex = 9999;

  ParamsToNavigationPage _params = Get.arguments;

  @override
  String screenName() => 'evolution'.tr;

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  AppBottomNavigationBar? bottomNavigationBar() => AppBottomNavigationBar();

  @override
  Function()? onPressedLeading() => () => Get.toNamed(Routes.PATIENT_DETAILS, arguments: _params);

  @override
  ParamsToNavigationPage? screenCardPatient() => _params;

  @override
  List<Widget>? actions() => [
        Visibility(
          visible: _access.accessPaper(Routes.NEW_EVOLUTION, PaperAccessUser.PRIVATE_INSERT),
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => _openFormNewEvolution(false, const EvolutionExt()),
              icon: const Icon(Icons.post_add, size: 30, color: ConstColors.blue),
            ),
          ),
        )
      ];

  @override
  Widget? floatingActionButton() => null;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _evolution.getFirstPage(patientId: _params.pacienteId!);
      _evolution.loadInfoUserStorage();
      // tipo de produtos
      _evolutionForm.getPatientProducts(_params.pacienteId!);
      //modelo de descrição
      _evolutionForm.getPatientProductsModel();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _openFormNewEvolution(bool editForm, EvolutionExt item) {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => FormEvolution(editForm: editForm, arguments: _params, controller: _evolutionForm, itemModel: item),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget body() {
    return _body();
  }

  Widget _body() {
    return ResponsiveBuilder(builder: (context, view) {
      return RefreshIndicator(
        onRefresh: () async => await _evolution.getFirstPage(patientId: _params.pacienteId!),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            Obx(() {
              return SliverToBoxAdapter(
                child: Visibility(
                  visible: _evolution.isLoading.value == AppLoadingStatus.notConnecting,
                  child: Container(
                    height: view.localWidgetSize?.height,
                    alignment: Alignment.center,
                    child: AppNotHasdata(loadData: () async => await _evolution.getFirstPage(patientId: _params.pacienteId!)),
                  ),
                ),
              );
            }),
            Obx(() {
              if ((_evolution.isLoading.value == AppLoadingStatus.notLoading) || (_evolution.isLoading.value == AppLoadingStatus.nextPageLoading)) {
                if (_evolution.listEvolution.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: view.localWidgetSize?.height,
                      alignment: Alignment.center,
                      child: AppNotHasdata(loadData: () async => await _evolution.getFirstPage(patientId: _params.pacienteId!)),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final EvolutionExt model = _evolution.listEvolution[index];
                      return CardItemEvolution(
                        controller: _evolution,
                        itemIndex: index,
                        model: model,
                        paramsToNavigationPage: _params,
                        commonsController: _commonsController,
                        formEvolutionController: _evolutionForm,
                      );
                    },
                    childCount: _evolution.listEvolution.length,
                  ),
                );
              } else {
                if (_evolution.isLoading.value == AppLoadingStatus.shimmerLoading) {
                  return const SliverToBoxAdapter(child: ShimmerDoctorCommitment());
                } else {
                  return const SliverToBoxAdapter(child: CupertinoActivityIndicator());
                }
              }
            }),
          ],
        ),
      );
    });
  }
}
