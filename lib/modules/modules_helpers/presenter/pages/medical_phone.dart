import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/constants/const_strings.dart';
import 'package:medicinadireta/core/drawer/search.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:medicinadireta/core/packages/dropdown_search_package/app_dropdown_widget_search_impl.dart';
import 'package:medicinadireta/core/validators/app_validators.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/form/app_button_simple.dart';
import 'package:medicinadireta/core/widgets/form/app_text_field.dart';
import 'package:medicinadireta/core/widgets/form/render_when.dart';
import 'package:medicinadireta/core/widgets/form/text_form_field_simple.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/controller/medical_controller.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/widgets/medical_register_form.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/widgets/search_farmaceutica.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/widgets/search_terapeutica.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/widgets/shimmer_medical.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/medical.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/medical_ext.dart';

import '/core/mixin/basic_page_mixin.dart';
import '/core/models/params/params_to_navigation_page.dart';
import '/core/responsive/responsive_builder.dart';
import '/core/widgets/app_bottom_navigator.dart';

class MedicalPhone extends BasePage {
  MedicalPhone({Key? key}) : super(key: key);

  @override
  MedicalPhoneState createState() => MedicalPhoneState();
}

class MedicalPhoneState extends BaseState<MedicalPhone> with WidgetsBindingObserver, BasicPage {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  final MedicalController _controller = Get.find<MedicalController>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.listMedical.clear();
      // _controller.getFirst(isFirst: true);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _debouncer.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  String screenName() => 'Medicamentos';

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  AppBottomNavigationBar? bottomNavigationBar() => AppBottomNavigationBar();

  @override
  Function()? onPressedLeading() => () => Get.back();

  @override
  ParamsToNavigationPage? screenCardPatient() => null;

  @override
  List<Widget>? actions() => [];

  void _openForm(bool edit, String title, Medical item) {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => MedicalRegisterForm(
          title: title,
          edit: edit,
          itemMedical: item,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget? floatingActionButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 70),
        child: FloatingActionButton(
          onPressed: () => _openForm(false, "Cadastrar Medicamento", const Medical()),
          backgroundColor: ConstColors.blue,
          child: const Icon(Icons.add, size: 24, color: Colors.white),
        ),
      );

  @override
  Widget body() => _body();

  Widget _body() {
    return ResponsiveBuilder(builder: (context, view) {
      return CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 80,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: Container(
                alignment: Alignment.topCenter,
                color: Colors.transparent,
                child: Search(
                  onPressed: () {},
                  autofocus: true,
                  onChanged: (data) {
                    _debouncer(() async {
                      if (data != '' && data.length > 3) {
                        await _controller.searchMedical(data);
                      } else {
                        _controller.listMedical.clear();
                        _controller.isLoading.value = AppLoadingStatus.notLoading;
                      }
                    });
                  },
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Pesquisar".tr,
                ),
              ),
            ),
          ),
          Obx(() {
            return SliverToBoxAdapter(
              child: Visibility(
                visible: _controller.isLoading.value == AppLoadingStatus.notConnecting,
                child: Container(
                  height: view.localWidgetSize?.height,
                  alignment: Alignment.center,
                  child: AppNotHasdata(
                    loadData: () {},
                    visibleOnPressed: false,
                  ),
                ),
              ),
            );
          }),
          Obx(() {
            if ((_controller.isLoading.value == AppLoadingStatus.notLoading) || (_controller.isLoading.value == AppLoadingStatus.nextPageLoading)) {
              if (_controller.listMedical.isEmpty) {
                return SliverToBoxAdapter(
                  child: Container(
                    height: view.localWidgetSize?.height,
                    alignment: Alignment.center,
                    child: AppNotHasdata(
                      loadData: () {},
                      visibleOnPressed: false,
                    ),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final Medical model = _controller.listMedical[index];
                    return Container(
                      color: ConstColors.white,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(model.medDesc.toString()),
                        onTap: () async {
                          await _controller.getDataMedicalId(model.id!);
                          _openForm(true, "Atualizar Medicamento", model);
                        },
                      ),
                    );
                  },
                  childCount: _controller.listMedical.length,
                ),
              );
            } else {
              if (_controller.isLoading.value == AppLoadingStatus.shimmerLoading) {
                return const SliverToBoxAdapter(child: ShimmerMedical());
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
