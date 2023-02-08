import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:medicinadireta/core/mixin/basic_page_mixin.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_html.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/core/widgets/form/app_button_simple.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/infra/models/anamnese_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/presenter/controller/anamnese_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/presenter/widgets/form_new_anamnese.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/presenter/widgets/shimmer_list_anamnese.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../commons/controllers/commons_controller_soap.dart';
import '../../../../commons/widgets/shimmer_cards.dart';
import '../widgets/card_item_anamnese.dart';

class AnamnesePhone extends BasePage {
  AnamnesePhone({Key? key}) : super(key: key);

  @override
  _AnamnesePhoneState createState() => _AnamnesePhoneState();
}

class _AnamnesePhoneState extends BaseState<AnamnesePhone> with WidgetsBindingObserver, BasicPage {
  final _commonsController = CommonsControllerSoap();

  final _controller = Get.find<AnamneseController>();
  final _scrollController = ScrollController();
  ParamsToNavigationPage _params = Get.arguments;

  @override
  String screenName() => 'anamnese'.tr;

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
              onPressed: () => _openFormNewAnamnese(),
              icon: const Icon(Icons.post_add, size: 30, color: ConstColors.blue),
            ),
          ),
        )
      ];

  @override
  Widget? floatingActionButton() => null;
  // Widget? floatingActionButton() => Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 70),
  //       child: FloatingActionButton(
  //         onPressed: () => _openFormNewAnamnese(),
  //         child: Icon(Icons.add, size: 24, color: Colors.white),
  //         backgroundColor: ConstColors.blue,
  //       ),
  //     );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.loadInfoUserStorage();
      _controller.getFirst(isFirst: true, pacientId: _params.pacienteId);
      _controller.getDataCiap();
      _controller.getDataCidSubCategory();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _openFormNewAnamnese() {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => FormNewAnamnese(
          controller: _controller,
          params: _params,
          title: 'Nova Anamnese'.tr.toUpperCase(),
          itemAnamnese: AnamneseExt(),
          edit: false,
        ),
        fullscreenDialog: true,
      ),
    );
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
                if (_controller.listItensAnamnese.isEmpty) {
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
                      final AnamneseExt model = _controller.listItensAnamnese[index];
                      return CardItemAnamnese(
                        controller: _controller,
                        commonsController: _commonsController,
                        itemIndex: index,
                        model: model,
                        paramsToNavigationPage: _params,
                      );
                    },
                    childCount: _controller.listItensAnamnese.length,
                  ),
                );
              } else {
                if (_controller.isLoading.value == AppLoadingStatus.shimmerLoading) {
                  return const SliverToBoxAdapter(child: ShimmerCards());
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

class ItensAnamnese extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const ItensAnamnese({Key? key, this.title, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: subTitle?.isNotEmpty ?? false,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: AppHtml(onData: "<b>$title</b></br> <span>$subTitle</span"),
          ),
        ],
      ),
    );
  }
}
