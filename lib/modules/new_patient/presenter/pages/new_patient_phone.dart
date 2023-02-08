import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/helpers/formats_constants.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/validators/app_validators.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/form/app_date_time_field.dart';
import 'package:medicinadireta/core/widgets/form/app_text_field.dart';
import 'package:medicinadireta/core/widgets/form/render_when.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/new_patient/presenter/controller/new_patient_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/domain/entities/network/params_general_data.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class NewPatientPhone extends StatefulWidget {
  NewPatientPhone({Key? key}) : super(key: key);

  @override
  _NewPatientPhoneState createState() => _NewPatientPhoneState();
}

class _NewPatientPhoneState extends State<NewPatientPhone> with WidgetsBindingObserver {
  final _scrollController = ScrollController();
  final _controller = Get.find<NewPatientController>();
  final _formKey = GlobalKey<FormState>();
  var _modelRequest = ParamsGeneralData();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    WidgetsBinding.instance.addObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AppScaffold(
        bottomNavigationBar: AppBottomNavigationBar(disablePatient: true),
        appBar: AppBarDefault.bar(
          title: Text('new_patient'.tr.toUpperCase()),
        ),
        body: ResponsiveBuilder(builder: (context, view) {
          return CupertinoScrollbar(
            thumbVisibility: false,
            controller: _scrollController,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(3),
              controller: _scrollController,
              child: Form(
                key: _formKey,
                child: AnimatedFromColumn(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 60,
                          padding: EdgeInsets.only(top: 10),
                          child: AppTextField(
                            controller: _controller.nameController,
                            maxLines: 100,
                            labelText: 'name'.tr,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            enabled: !_controller.loadingSave.value,
                            onSaved: (data) => _modelRequest = _modelRequest.copyWith(nome: data),
                            validator: AppValidators.multiple([
                              AppValidators.required(),
                              AppValidators.min(6, 'Informe nome e sobrenome'),
                            ]),
                            textCapitalization: TextCapitalization.characters,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Obx(() {
                      return Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 60,
                          padding: EdgeInsets.only(top: 10),
                          child: AppDateTime(
                            key: ValueKey(_controller.birthday?.value),
                            controller: _controller.birthdayController,
                            label: 'birthday'.tr,
                            enabled: !_controller.loadingSave.value,
                            initialValue: _controller.birthday?.value,
                            timer: false,
                            allowAfter: false,
                            onSaved: (data) {
                              if (data != null) {
                                var _brith = FormatsDatetime.apiDateFormat.format(data);
                                _modelRequest = _modelRequest.copyWith(dataNascimento: _brith);
                              }
                            },
                            validator: (data) {
                              if (data != null) {
                                final daysDiff = DateTime.now().difference(data).inDays;
                                var _inDays = (daysDiff / 365).floor();
                                if (_inDays > 100) return 'invalid_date_of_birth'.tr;
                                return null;
                              }
                              return 'requiredField'.tr;
                            },
                          ),
                        ),
                      );
                    }),
                    // SizedBox(height: 15),
                    Obx(
                      () => Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: AppTextField(
                            controller: _controller.emailController,
                            maxLines: 80,
                            labelText: 'email'.tr,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            enabled: !_controller.loadingSave.value,
                            onSaved: (data) => _modelRequest = _modelRequest.copyWith(email: data),
                            validator: AppValidators.multiple([
                              AppValidators.email(),
                            ]),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Obx(
                      () => Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 60,
                          padding: EdgeInsets.only(top: 10),
                          child: AppTextField(
                            controller: _controller.dddPhoneController,
                            inputFormatters: [FormatsConstants.phoneMask],
                            maxLines: 20,
                            labelText: 'ddd_cellphone'.tr,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            enabled: !_controller.loadingSave.value,
                            onSaved: (data) {
                              if (data != null) {
                                _modelRequest = _modelRequest.copyWith(telCelPatient: data);
                              }
                            },
                            validator: AppValidators.multiple([
                              AppValidators.phone(),
                            ]),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Obx(() {
                      return AppButton(
                        minWidth: MediaQuery.of(context).size.width - 50,
                        colorBackground: ConstColors.blue,
                        onPressed: () async {
                          var formValid = _formKey.currentState?.validate() ?? false;
                          if (formValid) {
                            _formKey.currentState?.save();
                            AppLog.i(_modelRequest.toMap().toString());
                            await _controller.saveNewPatient(_modelRequest);
                          }
                        },
                        childRaisedButton: RenderWhen(
                          text: 'save'.tr,
                          isLoading: _controller.loadingSave.value,
                        ),
                      );
                    }),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
