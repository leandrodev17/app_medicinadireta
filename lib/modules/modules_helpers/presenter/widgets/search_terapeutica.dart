import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:medicinadireta/core/mixin/basic_page_mixin.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/core/widgets/form/app_text_field.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/controller/medical_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/classe_terapeutica.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/presenter/widgets/shimmer_search_medical.dart';

class SearchTerapeutica extends BasePage {
  SearchTerapeutica({Key? key}) : super(key: key);

  @override
  SearchTerapeuticaState createState() => SearchTerapeuticaState();
}

class SearchTerapeuticaState extends BaseState<SearchTerapeutica> with WidgetsBindingObserver, BasicPage {
  final _controller = Get.find<MedicalController>();
  final _scrollController = ScrollController();
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 300));

  @override
  String screenName() => 'Classe Terapêutica'.tr;

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  AppBottomNavigationBar? bottomNavigationBar() => null;

  @override
  Function()? onPressedLeading() => () => Get.back();

  @override
  ParamsToNavigationPage? screenCardPatient() => null;

  @override
  List<Widget>? actions() => [];

  @override
  Widget? floatingActionButton() => null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.listClasseTerapeutica.clear();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _debouncer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget body() => _body();

  Widget _body() {
    return ResponsiveBuilder(builder: (context, view) {
      return CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: AppTextField(
              padding: const EdgeInsets.only(bottom: 20),
              controller: TextEditingController(),
              labelText: 'O que deseja pesquisar?',
              hintText: 'Digite a pesquisa.',
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              enabled: true,
              autofocus: true,
              textCapitalization: TextCapitalization.characters,
              onChanged: (dynamic d) {
                _debouncer(() async {
                  if (d != '' && d.length > 3) {
                    await _controller.searchClasseTerapeutica(d.toString().toLowerCase());
                  } else {
                    _debouncer.cancel();
                    _controller.isLoadingSearchClasseTerapeutica.value = AppLoadingStatus.notLoading;
                  }
                });
              },
            ),
          ),
          Obx(() {
            return SliverToBoxAdapter(
              child: Visibility(
                visible: _controller.isLoadingSearchClasseTerapeutica.value == AppLoadingStatus.notConnecting,
                child: Container(
                  height: view.localWidgetSize?.height,
                  alignment: Alignment.center,
                  child: AppNotHasdata(),
                ),
              ),
            );
          }),
          Obx(() {
            if ((_controller.isLoadingSearchClasseTerapeutica.value == AppLoadingStatus.notLoading) || (_controller.isLoadingSearchClasseTerapeutica.value == AppLoadingStatus.nextPageLoading)) {
              if (_controller.listClasseTerapeutica.isEmpty) {
                return SliverToBoxAdapter(
                  child: Container(
                    height: view.localWidgetSize?.height,
                    alignment: Alignment.center,
                    child: AppNotHasdata(),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final ClasseTerapeutica model = _controller.listClasseTerapeutica[index];
                    String? desc = model.descricao?.toString() ?? 'not_value'.tr;
                    String? codigo = model.codigo?.toString() ?? 'not_value'.tr;
                    return Container(
                      color: ConstColors.white,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          "$codigo - $desc",
                          style: TextStyle(
                            fontSize: 15.spEx,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () => _controller.setClasseTerapeuticaForm(model),
                      ),
                    );
                  },
                  childCount: _controller.listClasseTerapeutica.length,
                ),
              );
            } else {
              if (_controller.isLoadingSearchClasseTerapeutica.value == AppLoadingStatus.shimmerLoading) {
                return const SliverToBoxAdapter(child: ShimmerSearchMedical());
              } else {
                return const SliverToBoxAdapter(child: CupertinoActivityIndicator());
              }
            }
          }),
        ],
      );
    });
  }
}
