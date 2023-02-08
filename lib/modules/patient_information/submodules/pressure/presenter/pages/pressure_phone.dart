import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../infra/models/pressure_model.dart';
import '../controller/pressure_controller.dart';
import '../widgets/card_item_pressure.dart';
import '../widgets/shimmer_pressure.dart';
import '/core/enum/app_loading_status.dart';
import '/core/mixin/basic_page_mixin.dart';
import '/core/models/params/params_to_navigation_page.dart';
import '/core/responsive/responsive_builder.dart';
import '/core/widgets/app_bottom_navigator.dart';
import '/core/widgets/app_not_hasdata.dart';
import '/routes/app_pages.dart';

class PressurePhone extends BasePage {
  PressurePhone({Key? key}) : super(key: key);

  @override
  PressurePhoneState createState() => PressurePhoneState();
}

class PressurePhoneState extends BaseState<PressurePhone> with WidgetsBindingObserver, BasicPage {
  final _controller = Get.find<PressureController>();
  final _scrollController = ScrollController();
  final ParamsToNavigationPage _params = Get.arguments;

  @override
  String screenName() => 'Pressão Arterial'.tr;

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
                if (_controller.listPressure.isEmpty) {
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
                      final PressureModel model = _controller.listPressure[index];
                      return CardItemPressure(
                        controller: _controller,
                        itemIndex: index,
                        model: model,
                        paramsToNavigationPage: _params,
                      );
                    },
                    childCount: _controller.listPressure.length,
                  ),
                );
              } else {
                if (_controller.isLoading.value == AppLoadingStatus.shimmerLoading) {
                  return const SliverToBoxAdapter(child: ShimmerPressure());
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
