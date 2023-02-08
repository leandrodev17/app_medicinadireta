import 'package:medicinadireta/core/validators/app_validators.dart';
import 'package:medicinadireta/core/widgets/app_will_pop_scope.dart';
import 'package:medicinadireta/modules/authentication/domain/entities/params_authentication.dart';

import '/constants/const_colors.dart';
import '/constants/const_drawables.dart';
import '/core/responsive/responsive_builder.dart';
import '/core/widgets/form/app_button.dart';
import '/core/widgets/form/app_text_field.dart';
import '/core/widgets/form/render_when.dart';

import '/core/animation/animated_from_column.dart';
import '../controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationPhone extends StatefulWidget {
  final AuthenticationController controller;
  const AuthenticationPhone({Key? key, required this.controller}) : super(key: key);

  @override
  _AuthenticationPhoneState createState() => _AuthenticationPhoneState();
}

class _AuthenticationPhoneState extends State<AuthenticationPhone> with WidgetsBindingObserver {
  AuthenticationController get _controller => widget.controller;
  final _formKey = GlobalKey<FormState>();
  var _request = ParamsAuthentication();

  final _loginEC = TextEditingController();
  final _passEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.loading.value = false;
      // _controller.userController.clear();
      // _controller.passController.clear();
      // _controller.username.value = 'null';
      // _controller.password.value = 'null';
      // _controller.deleteCache();
      // PushNotificationConfigure().generatorToken();
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _loginEC.dispose();
    _passEC.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppWillPopScope(
      child: ResponsiveBuilder(builder: (context, view) {
        return Scaffold(
          body: Container(
            height: view.localWidgetSize!.height,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: _formKey,
                child: AnimatedFromColumn(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      child: Hero(tag: 'logo', child: Image.asset(ConstDrawables.logo)),
                    ),
                    Obx(() {
                      return AppTextField(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        maxLength: 100,
                        autofocus: true,
                        hintText: 'CRM ou ID',
                        controller: _loginEC,
                        labelText: 'Login',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        enabled: !_controller.loading.value,
                        onSaved: (data) {
                          if (data != null && data.isNotEmpty) _request = _request.copyWith(login: data);
                        },
                        validator: AppValidators.required(),
                      );
                    }),
                    // Obx(
                    //   () => AppTextField(
                    //     controller: _controller.userController,
                    //     focusNode: _controller.userFocusNode,
                    //     maxLength: 100,
                    //     hintText: 'CRM ou ID',
                    //     labelText: 'Login',
                    //     errorText: _controller.usernameError,
                    //     onFieldSubmitted: (data) => AppUnfocus.nextFocus(unfocus: _controller.userFocusNode, nextFocus: _controller.passFocusNode),
                    //     onChanged: _controller.setUsername,
                    //     keyboardType: TextInputType.text,
                    //     textInputAction: TextInputAction.next,
                    //     enabled: !_controller.loading.value,
                    //     autofocus: true,
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    // Obx(
                    //   () => AppTextField(
                    //     controller: _controller.passController,
                    //     focusNode: _controller.passFocusNode,
                    //     maxLength: 100,
                    //     hintText: 'Sua senha',
                    //     labelText: 'Senha',
                    //     errorText: _controller.passwordError,
                    //     onChanged: _controller.setPassword,
                    //     keyboardType: TextInputType.text,
                    //     textInputAction: TextInputAction.done,
                    //     enabled: !_controller.loading.value,
                    //     obscureText: !_controller.visiblePassword.value,
                    //     visibleSuffixIcon: true,
                    // suffixIconWidget: _controller.visiblePassword.value
                    //     ? Icon(Icons.visibility_outlined, color: ConstColors.fillColor)
                    //     : Icon(Icons.visibility_off_outlined, color: ConstColors.fillColor),
                    // onPressedSuffixIcon: () => _controller.visiblePasswordShow(),
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    Obx(() {
                      return AppTextField(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        maxLength: 50,
                        hintText: 'Sua senha',
                        controller: _passEC,
                        labelText: 'Senha',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obscureText: !_controller.visiblePassword.value,
                        visibleSuffixIcon: true,
                        enabled: !_controller.loading.value,
                        suffixIconWidget: _controller.visiblePassword.value
                            ? Icon(Icons.visibility_outlined, color: ConstColors.fillColor)
                            : Icon(Icons.visibility_off_outlined, color: ConstColors.fillColor),
                        onPressedSuffixIcon: () => _controller.visiblePasswordShow(),
                        onSaved: (data) {
                          if (data != null && data.isNotEmpty) {
                            _request = _request.copyWith(password: data.toUpperCase());
                          }
                        },
                        validator: AppValidators.required(),
                      );
                    }),
                    Obx(
                      () => AppButton(
                        colorBackground: ConstColors.blue,
                        // onPressed: _controller.onPressButton ? () => _controller.signInUser() : null,
                        onPressed: _controller.loading.value
                            ? null
                            : () async {
                                var formValid = _formKey.currentState?.validate() ?? false;
                                if (formValid) {
                                  _formKey.currentState?.save();
                                  print('_request ${_request.toMap()}');
                                  await _controller.signInUser(_request);
                                }
                              },
                        childRaisedButton: RenderWhen(
                          text: 'Entrar',
                          isLoading: _controller.loading.value,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
