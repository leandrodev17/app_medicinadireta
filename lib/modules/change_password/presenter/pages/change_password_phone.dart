import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/helpers/app_unfocus.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/validators/app_validators.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/form/app_text_field.dart';
import 'package:medicinadireta/core/widgets/form/render_when.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/change_password/presenter/controller/change_password_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPhone extends StatefulWidget {
  const ChangePasswordPhone({Key? key}) : super(key: key);

  @override
  ChangePasswordPhoneState createState() => ChangePasswordPhoneState();
}

class ChangePasswordPhoneState extends State<ChangePasswordPhone> with WidgetsBindingObserver {
  final _scrollController = ScrollController();
  final _controller = Get.find<ChangePasswordController>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AppScaffold(
        backgroundColor: ConstColors.backgroundDefault,
        onWillPop: () async => await Future.value(true),
        body: SafeArea(
          child: AppScaffold(
            backgroundColor: ConstColors.backgroundDefault,
            appBar: AppBarDefault.bar(titleApp: 'Mudar Senha'),
            body: ResponsiveBuilder(builder: (context, view) {
              return CupertinoScrollbar(
                thumbVisibility: false,
                controller: _scrollController,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  controller: _scrollController,
                  child: Form(
                    key: _formKey,
                    child: AnimatedFromColumn(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Obx(
                          () => AppTextField(
                            maxLength: 10,
                            controller: _controller.newPasswordController,
                            onChanged: _controller.setNewPassword,
                            focusNode: _controller.newPasswordFocusNode,
                            labelText: 'new_password'.tr,
                            hintText: 'new_password'.tr,
                            errorText: _controller.newPasswordError,
                            onFieldSubmitted: (data) => AppUnfocus.nextFocus(unfocus: _controller.newPasswordFocusNode, nextFocus: _controller.confirmPasswordFocusNode),
                            hintStyle: Theme.of(context).textTheme.subtitle2,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            autofocus: true,
                            enabled: !_controller.loading.value,
                            visibleSuffixIcon: true,
                            obscureText: !_controller.visiblePasswordNew.value,
                            suffixIconWidget: _controller.visiblePasswordNew.value
                                ? const Icon(Icons.visibility_outlined, color: ConstColors.fillColor)
                                : const Icon(Icons.visibility_off_outlined, color: ConstColors.fillColor),
                            onPressedSuffixIcon: () => _controller.visiblePasswordShow(),
                            validator: AppValidators.required(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => AppTextField(
                            maxLength: 20,
                            controller: _controller.confirmPasswordController,
                            onChanged: _controller.setConfirmPassword,
                            focusNode: _controller.confirmPasswordFocusNode,
                            errorText: _controller.confirmPasswordError,
                            labelText: 'new_password_confirm'.tr,
                            hintText: 'new_password_confirm'.tr,
                            hintStyle: Theme.of(context).textTheme.subtitle2,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            enabled: !_controller.loading.value,
                            visibleSuffixIcon: true,
                            obscureText: !_controller.visiblePasswordNew.value,
                            suffixIconWidget: _controller.visiblePasswordNew.value
                                ? Icon(Icons.visibility_outlined, color: ConstColors.fillColor)
                                : Icon(Icons.visibility_off_outlined, color: ConstColors.fillColor),
                            onPressedSuffixIcon: () => _controller.visiblePasswordShow(),
                            validator: AppValidators.required(),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Obx(
                          () => AppButton(
                            minWidth: MediaQuery.of(context).size.width,
                            colorBackground: ConstColors.blue,
                            onPressed: _controller.loading.value
                                ? null
                                : () async {
                                    var formValid = _formKey.currentState?.validate() ?? false;
                                    if (formValid) {
                                      _formKey.currentState?.save();
                                      await _controller.saveNewPassword();
                                    }
                                  },
                            // onPressed: _controller.isPressedSave ? () async => await _controller.saveNewPassword() : null,
                            childRaisedButton: RenderWhen(
                              text: 'save'.tr,
                              // isLockeding: !_controller.isPressedSave,
                              isLoading: _controller.loading.value,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
