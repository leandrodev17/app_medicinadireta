import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/mixin/basic_page_mixin.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/form/app_text_field.dart';
import 'package:medicinadireta/core/widgets/form/render_when.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/presenter/controller/relationship_controller.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class RelationshipPhone extends BasePage {
  RelationshipPhone({Key? key}) : super(key: key);

  @override
  _RelationshipPhoneState createState() => _RelationshipPhoneState();
}

class _RelationshipPhoneState extends BaseState<RelationshipPhone> with WidgetsBindingObserver, BasicPage {
  final _controller = Get.find<RelationshipController>();
  ParamsToNavigationPage _params = Get.arguments;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getPacienteId(_params.pacienteId!);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  String screenName() => 'relationship'.tr;

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

  @override
  Widget? floatingActionButton() => null;

  @override
  Widget body() {
    return _body();
  }

  Widget _body() {
    return ResponsiveBuilder(builder: (context, view) {
      return CupertinoScrollbar(
        thumbVisibility: false,
        controller: _scrollController,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          child: AnimatedFromColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(
                () => Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: AppTextField(
                      controller: _controller.messageController,
                      focusNode: _controller.messageFocusNode,
                      maxLines: 300,
                      minLines: 20,
                      labelText: 'message'.tr,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      hintText: 'enter_message'.tr,
                      enabled: !_controller.loading.value,
                      errorText: _controller.messageError,
                      onChanged: _controller.onChangeMessage),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => AppButton(
                  // minWidth: 190.0,
                  colorBackground: ConstColors.blue,
                  onPressed: _controller.isMessage ? () async => await _controller.save(_params) : null,
                  childRaisedButton: RenderWhen(
                    text: 'save'.tr,
                    isLockeding: !_controller.isMessage,
                    isLoading: _controller.loading.value,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
