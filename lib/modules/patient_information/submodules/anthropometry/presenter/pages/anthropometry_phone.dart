import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/presenter/widgets/form_allergy.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/infra/models/prescription_model.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/presenter/controller/prescription_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/presenter/widgets/card_item_prescription.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/presenter/widgets/shimmer_prescription.dart';

import '../../infra/models/anthropometry_model.dart';
import '../controller/anthropometry_controller.dart';
import '../widgets/card_item_anthropometry.dart';
import '../widgets/shimmer_anthropometry.dart';
import '/constants/const_colors.dart';
import '/core/enum/app_loading_status.dart';
import '/core/mixin/basic_page_mixin.dart';
import '/core/models/params/params_to_navigation_page.dart';
import '/core/responsive/responsive_builder.dart';
import '/core/widgets/app_bottom_navigator.dart';
import '/core/widgets/app_not_hasdata.dart';
import '/routes/app_pages.dart';

class AnthropometryPhone extends BasePage {
  AnthropometryPhone({Key? key}) : super(key: key);

  @override
  AnthropometryPhoneState createState() => AnthropometryPhoneState();
}

class AnthropometryPhoneState extends BaseState<AnthropometryPhone> with WidgetsBindingObserver, BasicPage {
  final _controller = Get.find<AnthropometryController>();
  final _scrollController = ScrollController();
  final ParamsToNavigationPage _params = Get.arguments;

  @override
  String screenName() => 'Antropometria'.tr;

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  AppBottomNavigationBar? bottomNavigationBar() => AppBottomNavigationBar();

  @override
  Function()? onPressedLeading() => () => Get.toNamed(Routes.PATIENT_DETAILS, arguments: _params);

  @override
  ParamsToNavigationPage? screenCardPatient() => _params;

  @override
  List<Widget>? actions() => [];

  void _openForm() {
    // Navigator.push<void>(
    //   context,
    //   MaterialPageRoute<void>(
    //     builder: (BuildContext context) => FormAllergy(
    //       controller: _controller,
    //       params: _params,
    //       title: 'Nova Receita'.tr.toUpperCase(),
    //       itemAllergy: const Allergy(),
    //       edit: false,
    //     ),
    //     fullscreenDialog: true,
    //   ),
    // );
  }

  @override
  Widget? floatingActionButton() => null;
  // Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 70),
  //       child: FloatingActionButton(
  //         onPressed: () => _openForm(),
  //         backgroundColor: ConstColors.blue,
  //         child: const Icon(Icons.add, size: 24, color: Colors.white),
  //       ),
  //     );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.loadInfoUserStorage();
      _controller.getFirst(isFirst: true, pacienteId: _params.pacienteId);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget body() => _body();

  Widget _body() {
    return ResponsiveBuilder(builder: (context, view) {
      return RefreshIndicator(
        onRefresh: () async => await _controller.swipeRefresh(_params.pacienteId),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) {
            //       // final Allergy model = _controller.listItensAllergys[index];
            //       return CardItemPrescription(
            //         controller: _controller,
            //         itemIndex: index,
            //         model: PrescriptionModel(),
            //         paramsToNavigationPage: _params,
            //       );
            //     },
            //     childCount: 40,
            //   ),
            // ),
            Obx(() {
              return SliverToBoxAdapter(
                child: Visibility(
                  visible: _controller.isLoading.value == AppLoadingStatus.notConnecting,
                  child: Container(
                    height: view.localWidgetSize?.height,
                    alignment: Alignment.center,
                    child: AppNotHasdata(loadData: () async => await _controller.swipeRefresh(_params.pacienteId)),
                  ),
                ),
              );
            }),
            Obx(() {
              if ((_controller.isLoading.value == AppLoadingStatus.notLoading) || (_controller.isLoading.value == AppLoadingStatus.nextPageLoading)) {
                if (_controller.listAnthropometry.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: view.localWidgetSize?.height,
                      alignment: Alignment.center,
                      child: AppNotHasdata(loadData: () async => await _controller.swipeRefresh(_params.pacienteId)),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final AnthropometryModel model = _controller.listAnthropometry[index];
                      return CardItemAnthropometry(
                        controller: _controller,
                        itemIndex: index,
                        model: model,
                        paramsToNavigationPage: _params,
                      );
                    },
                    childCount: _controller.listAnthropometry.length,
                  ),
                );
              } else {
                if (_controller.isLoading.value == AppLoadingStatus.shimmerLoading) {
                  return const SliverToBoxAdapter(child: ShimmerAnthropometry());
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
