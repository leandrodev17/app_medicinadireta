import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/helpers/app_unfocus.dart';
import 'package:medicinadireta/core/helpers/formats_constants.dart';
import 'package:medicinadireta/core/mixin/basic_page_mixin.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/form/app_date_time_field.dart';
import 'package:medicinadireta/core/widgets/form/app_text_field.dart';
import 'package:medicinadireta/core/widgets/form/render_when.dart';
import 'package:medicinadireta/core/widgets/switch_control_widget.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/presenter/controller/communication_controller.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunicationPhone extends BasePage {
  CommunicationPhone({Key? key}) : super(key: key);

  @override
  _CommunicationPhoneState createState() => _CommunicationPhoneState();
}

class _CommunicationPhoneState extends BaseState<CommunicationPhone> with WidgetsBindingObserver, BasicPage {
  final _controller = Get.find<CommunicationController>();
  ParamsToNavigationPage _params = Get.arguments;
  final _scrollController = ScrollController();
  var visibleCard = true;
  var blueColor = ConstColors.blue;
  var whiteColor = Colors.white;
  bool color = true;

  @override
  String screenName() => 'communication'.tr;

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

  final _paraEC = TextEditingController();
  final _assuntoEC = TextEditingController();
  final _messageEC = TextEditingController();
  final _phoneEC = TextEditingController();

  _showValues() {
    _paraEC.text = _params.email ?? '';
    _phoneEC.text = _params.telefone ?? '';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showValues();
      // _controller.getPacienteId(_model.id!);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    _paraEC.dispose();
    _assuntoEC.dispose();
    _messageEC.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget body() {
    return _body();
  }

  Widget _body() {
    return ResponsiveBuilder(builder: (context, view) {
      return RefreshIndicator(
        onRefresh: () async => await Future.value(true),
        child: CupertinoScrollbar(
          thumbVisibility: false,
          controller: _scrollController,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            child: AnimatedFromColumn(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Obx(() {
                    return SwitchControlWidget(
                      selectedValue: _controller.optionComunication.value,
                      controls: {
                        0: Text('email'.tr),
                        1: Text('sms'.tr),
                      },
                      onValueChanged: _controller.changeOptionComunication,
                    );
                  }),
                ),
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Obx(() {
                      return AppDateTime(
                        key: ValueKey(_controller.schedulingDatetime),
                        resetIcon: null,
                        label: 'scheduling'.tr,
                        enabled: !_controller.loadingSave.value,
                        initialValue: _controller.schedulingDatetime.value,
                        onChanged: _controller.setSchedulingDatetime,
                        errorText: _controller.schedulingError,
                        timer: true,
                        allowAfter: false,
                      );
                    }),
                  ),
                ),
                Obx(() {
                  return Visibility(
                      visible: _controller.optionComunication.value == 0,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 50,
                              child: AppTextField(
                                controller: _paraEC,
                                focusNode: _controller.emailFocusNode,
                                onFieldSubmitted: (data) => AppUnfocus.nextFocus(unfocus: _controller.emailFocusNode, nextFocus: _controller.assuntoFocusNode),
                                maxLength: 50,
                                labelText: 'to'.tr,
                                hintText: 'to'.tr,
                                autofocus: true,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                enabled: !_controller.loadingSave.value,
                                errorText: _controller.mailError,
                                onChanged: _controller.setEmailCommunication,
                              ),
                            ),
                          ),
                        ],
                      ));
                }),
                Obx(() {
                  return Visibility(
                      visible: _controller.optionComunication.value == 1,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 50,
                              child: AppTextField(
                                controller: _phoneEC,
                                focusNode: _controller.phoneFocusNode,
                                // onFieldSubmitted: (data) => AppUnfocus.nextFocus(unfocus: _controller.phoneFocusNode, nextFocus: _controller.assuntoFocusNode),
                                maxLength: 15,
                                labelText: 'phone'.tr,
                                hintText: 'phone'.tr,
                                inputFormatters: [FormatsConstants.phoneMask],
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                enabled: !_controller.loadingSave.value,
                                errorText: _controller.phoneCommunicationError,
                                onChanged: _controller.setPhoneCommunication,
                              ),
                            ),
                          ),
                        ],
                      ));
                }),
                const SizedBox(height: 20),
                Obx(
                  () => Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: AppTextField(
                        controller: _assuntoEC,
                        focusNode: _controller.assuntoFocusNode,
                        onFieldSubmitted: (data) => AppUnfocus.nextFocus(unfocus: _controller.assuntoFocusNode, nextFocus: _controller.mensagemFocusNode),
                        maxLength: 120,
                        labelText: 'subject'.tr,
                        hintText: 'subject'.tr,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        enabled: !_controller.loadingSave.value,
                        errorText: _controller.assuntoError,
                        onChanged: _controller.setAssuntoCommunication,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Obx(
                  () => Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: AppTextField(
                        controller: _messageEC,
                        focusNode: _controller.mensagemFocusNode,
                        maxLines: 200,
                        minLines: 3,
                        labelText: 'message'.tr,
                        hintText: 'message'.tr,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        enabled: !_controller.loadingSave.value,
                        errorText: _controller.messageError,
                        onChanged: _controller.setMessageCommunication,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Obx(() {
                  return AppButton(
                    minWidth: MediaQuery.of(context).size.width - 50,
                    colorBackground: ConstColors.blue,
                    onPressed: _controller.isPressedSave ? () async => await _controller.saveDataCommunication(_params) : null,
                    childRaisedButton: RenderWhen(
                      text: 'send'.tr,
                      isLockeding: !_controller.isPressedSave,
                      isLoading: _controller.loadingSave.value,
                    ),
                  );
                }),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    });
  }
}
