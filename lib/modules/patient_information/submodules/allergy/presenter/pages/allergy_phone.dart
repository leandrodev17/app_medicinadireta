import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/presenter/widgets/form_allergy.dart';

import '/constants/const_colors.dart';
import '/core/enum/app_loading_status.dart';
import '/core/mixin/basic_page_mixin.dart';
import '/core/models/params/params_to_navigation_page.dart';
import '/core/responsive/responsive_builder.dart';
import '/core/widgets/app_bottom_navigator.dart';
import '/core/widgets/app_not_hasdata.dart';
import '/modules/patient_information/submodules/allergy/domain/entities/allergy.dart';
import '/modules/patient_information/submodules/allergy/presenter/controller/allergy_controller.dart';
import '/modules/patient_information/submodules/allergy/presenter/widgets/card_item.dart';
import '/modules/patient_information/submodules/allergy/presenter/widgets/shimmer_allergy.dart';
import '/routes/app_pages.dart';

class AllergyPhone extends BasePage {
  AllergyPhone({Key? key}) : super(key: key);

  @override
  AllergyPhoneState createState() => AllergyPhoneState();
}

class AllergyPhoneState extends BaseState<AllergyPhone> with WidgetsBindingObserver, BasicPage {
  final _controller = Get.find<AllergyController>();
  final _scrollController = ScrollController();
  final ParamsToNavigationPage _params = Get.arguments;

  @override
  String screenName() => 'allergy'.tr;

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
          visible: true, // _access.accessPaper(Routes.NEW_EVOLUTION, PaperAccessUser.PRIVATE_INSERT),
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.post_add, size: 30, color: ConstColors.blue),
            ),
          ),
        )
      ];

  void _openForm() {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => FormAllergy(
          controller: _controller,
          params: _params,
          title: 'Nova Alergia'.tr.toUpperCase(),
          itemAllergy: const Allergy(),
          edit: false,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget? floatingActionButton() => null;
  // Widget? floatingActionButton() => Padding(
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
      _controller.getFirst(isFirst: true, pacientId: _params.pacienteId);
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
        onRefresh: () async => await _controller.swipeRefresh(pacientId: _params.pacienteId),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            Obx(() {
              return SliverToBoxAdapter(
                child: Visibility(
                  visible: _controller.isLoading.value == AppLoadingStatus.notConnecting,
                  child: Container(
                    height: view.localWidgetSize?.height,
                    alignment: Alignment.center,
                    child: AppNotHasdata(loadData: () async => await _controller.swipeRefresh(pacientId: _params.pacienteId)),
                  ),
                ),
              );
            }),
            Obx(() {
              if ((_controller.isLoading.value == AppLoadingStatus.notLoading) || (_controller.isLoading.value == AppLoadingStatus.nextPageLoading)) {
                if (_controller.listItensAllergys.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: view.localWidgetSize?.height,
                      alignment: Alignment.center,
                      child: AppNotHasdata(loadData: () async => await _controller.swipeRefresh(pacientId: _params.pacienteId)),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final Allergy model = _controller.listItensAllergys[index];
                      return CardItem(
                        controller: _controller,
                        itemIndex: index,
                        model: model,
                        paramsToNavigationPage: _params,
                      );
                    },
                    childCount: _controller.listItensAllergys.length,
                  ),
                );
              } else {
                if (_controller.isLoading.value == AppLoadingStatus.shimmerLoading) {
                  return const SliverToBoxAdapter(child: ShimmerAllergy());
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
