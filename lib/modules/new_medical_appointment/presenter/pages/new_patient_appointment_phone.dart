import 'package:flutter/material.dart';
import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/helpers/formats_constants.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/validators/app_validators.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/form/app_date_time_field.dart';
import 'package:medicinadireta/core/widgets/form/render_when.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/new_medical_appointment/presenter/controller/new_medical_appointment_controller.dart';
import 'package:medicinadireta/modules/new_patient/domain/entities/network/request_new_patient.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '../../../../core/widgets/form/app_text_field_simple.dart';

class NewPatientAppointmentPhone extends StatefulWidget {
  const NewPatientAppointmentPhone({Key? key}) : super(key: key);

  @override
  NewPatientAppointmentPhoneState createState() => NewPatientAppointmentPhoneState();
}

class NewPatientAppointmentPhoneState extends State<NewPatientAppointmentPhone> with WidgetsBindingObserver {
  final _scrollController = ScrollController();
  final _controller = Get.find<NewMedicalAppointmentController>();
  var _model = RequestNewPatient();
  final _formKey = GlobalKey<FormState>();
  DateTime? _birthday;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dddPhoneController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _birthdayFocusNode = FocusNode();
  final _dddPhoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.controllerNewPatient.cleanFields();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _dddPhoneController.dispose();
    _birthdayController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _birthdayFocusNode.dispose();
    _dddPhoneFocusNode.dispose();
    _birthday = null;
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AppScaffold(
        backgroundColor: ConstColors.backgroundDefault,
        body: SafeArea(
          child: AppScaffold(
            backgroundColor: ConstColors.backgroundDefault,
            appBar: AppBarDefault.bar(titleApp: 'new_patient'),
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
                          () => AppTextFieldSimple(
                            controller: _nameController,
                            focusNode: _nameFocusNode,
                            maxLines: 50,
                            prefixIcon: const Icon(Icons.account_box, color: ConstColors.blue),
                            hintText: 'name'.tr,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            // autofocus: true,
                            enabled: !_controller.loadingSaveNewPatient.value,
                            onSaved: (data) => _model = _model.copyWith(nome: data),
                            validator: AppValidators.multiple([
                              AppValidators.required(),
                              AppValidators.min(6, 'Informe nome e sobrenome'),
                            ]),
                            textCapitalization: TextCapitalization.characters,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(() {
                          return AppDateTime(
                            padding: EdgeInsets.zero,
                            key: ValueKey(_birthday),
                            resetIcon: null,
                            isDecorationNotBorder: true,
                            prefixIcon: const Icon(Icons.event, color: ConstColors.blue),
                            hintText: 'birthday'.tr,
                            enabled: !_controller.loadingSave.value,
                            initialValue: _birthday,
                            timer: false,
                            allowAfter: false,
                            onSaved: (data) {
                              if (data != null) {
                                var brith = FormatsDatetime.apiDateFormat.format(data);
                                _model = _model.copyWith(dataNascimento: brith);
                              }
                            },
                            validator: (data) {
                              if (data != null) {
                                final daysDiff = DateTime.now().difference(data).inDays;
                                var inDays = (daysDiff / 365).floor();
                                if (inDays > 100) return 'invalid_date_of_birth'.tr;
                                return null;
                              }
                              return 'requiredField'.tr;
                            },
                          );
                        }),
                        const SizedBox(height: 10),
                        Obx(
                          () => AppTextFieldSimple(
                            controller: _emailController,
                            focusNode: _emailFocusNode,
                            maxLines: 80,
                            prefixIcon: const Icon(Icons.mail, color: ConstColors.blue),
                            hintText: 'E-mail'.tr,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            enabled: !_controller.loadingSaveNewPatient.value,
                            onSaved: (data) {
                              if (data != null) _model = _model.copyWith(email: data);
                            },
                            validator: AppValidators.multiple([
                              AppValidators.email(),
                            ]),
                            textCapitalization: TextCapitalization.none,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => AppTextFieldSimple(
                            controller: _dddPhoneController,
                            focusNode: _dddPhoneFocusNode,
                            maxLines: 20,
                            hintText: 'ddd_cellphone'.tr,
                            prefixIcon: const Icon(Icons.smartphone, color: ConstColors.blue),
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [FormatsConstants.phoneMask],
                            enabled: !_controller.loadingSaveNewPatient.value,
                            onSaved: (data) {
                              _model = _model.copyWith(celular: data);
                            },
                            validator: AppValidators.multiple([
                              AppValidators.phone(),
                            ]),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Obx(() {
                          return AppButton(
                            minWidth: MediaQuery.of(context).size.width,
                            colorBackground: ConstColors.blue,
                            onPressed: () async {
                              var formValid = _formKey.currentState?.validate() ?? false;
                              if (formValid) {
                                _formKey.currentState?.save();
                                await _controller.saveNewPatientAppointment(_model);
                              }
                            },
                            // onPressed: _controller.controllerNewPatient.isPressedSave ? () async => await _controller.saveNewPatientAppointment() : null,
                            childRaisedButton: RenderWhen(
                              text: 'save'.tr,
                              isLoading: _controller.loadingSaveNewPatient.value,
                            ),
                          );
                        }),
                        const SizedBox(height: 30),
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
