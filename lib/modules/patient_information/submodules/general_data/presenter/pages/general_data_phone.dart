import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/controller_from_initial/verification_access_menu_user.dart';
import 'package:medicinadireta/core/enum/paper_access_user.dart';
import 'package:medicinadireta/core/helpers/formats_constants.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/mixin/basic_page_mixin.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/validators/app_validators.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/form/app_date_time_field.dart';
import 'package:medicinadireta/core/widgets/form/app_text_field.dart';
import 'package:medicinadireta/core/widgets/form/radio_button_group.dart';
import 'package:medicinadireta/core/widgets/form/render_when.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/domain/entities/network/params_general_data.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/presenter/controller/general_data_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/presenter/widgets/shimmer_form_general.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralDataPhone extends BasePage {
  GeneralDataPhone({Key? key}) : super(key: key);

  @override
  _GeneralDataPhoneState createState() => _GeneralDataPhoneState();
}

class _GeneralDataPhoneState extends BaseState<GeneralDataPhone> with WidgetsBindingObserver, BasicPage {
  final _access = Get.find<VerificationAccessMenuUser>();
  final ParamsToNavigationPage _params = Get.arguments;
  final _controller = Get.find<GeneralDataController>();
  final _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  var checkMasculine = false;
  var checkFeminine = false;
  var checkIgnored = false;
  var checkParticular = false;
  var checkHealthInsurance = false;

  var _modelRequest = ParamsGeneralData();
  @override
  String screenName() => 'general_data_edit'.tr;

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  AppBottomNavigationBar? bottomNavigationBar() => AppBottomNavigationBar();

  @override
  Function()? onPressedLeading() => () => Get.toNamed(Routes.PATIENT_DETAILS, arguments: _params);

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
      _controller.findGeneralData(_params.pacienteId!);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  _indicatorButtomCamera() {
    return Positioned(right: 30, bottom: 8, child: CircleAvatar(backgroundColor: ConstColors.blue, radius: 15, child: Icon(Icons.camera_alt, color: Colors.white, size: 18)));
  }

  @override
  Widget body() => _body();

  Widget _body() {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ResponsiveBuilder(builder: (context, view) {
        return CupertinoScrollbar(
          thumbVisibility: false,
          controller: _scrollController,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            child: AnimatedFromColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() {
                  if (_controller.loadingFindData.value) return ShimmerFormGeneral();
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () async => await _controller.cameraGallery.showCameraOrGallery(),
                                child: Container(
                                  width: 120,
                                  child: Obx(() {
                                    var _filePerfil = _controller.cameraGallery.filePerfil;
                                    if (_controller.photoPerfil.value.isNotEmpty && _filePerfil.isEmpty) {
                                      return Stack(
                                        children: [
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundColor: ConstColors.blue,
                                            child: CircleAvatar(
                                              radius: 38,
                                              backgroundImage: MemoryImage(_controller.photoPerfil.value),
                                            ),
                                          ),
                                          _indicatorButtomCamera(),
                                        ],
                                      );
                                    }
                                    return Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundColor: ConstColors.blue,
                                          child: _filePerfil.length > 0
                                              ? CircleAvatar(radius: 38, backgroundImage: FileImage(_filePerfil.first))
                                              : CircleAvatar(radius: 38, backgroundImage: AssetImage('assets/images/logo.png')),
                                        ),
                                        _indicatorButtomCamera(),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                              Column(
                                children: [
                                  Text('patient_record'.tr),
                                  Container(
                                    width: 45,
                                    height: 25,
                                    decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(8)), color: ConstColors.orange),
                                    child: Center(
                                      child: Text(
                                        "${_params.numeroDoProtuario}",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w400, color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Obx(
                          () => Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: AppTextField(
                                controller: _controller.namePatientController,
                                // focusNode: _controller.namePatientFocusNode,
                                maxLines: 50,
                                labelText: 'name'.tr,
                                hintText: 'name'.tr,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                // autofocus: true,
                                enabled: !_controller.loadingFindData.value,
                                onSaved: (data) => _modelRequest = _modelRequest.copyWith(nome: data),
                                validator: AppValidators.multiple([
                                  AppValidators.required(),
                                  AppValidators.min(6, 'Informe nome e sobrenome'),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Obx(
                          () => Container(
                            padding: EdgeInsets.only(left: 20),
                            child: RadioButtonGroup(
                              title: 'gender'.tr,
                              labels: _controller.listGender,
                              groupValue: _controller.indexGender.value,
                              onChanged: _controller.onChangeGender,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Obx(
                          () => Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: AppTextField(
                                controller: _controller.cpfPatientController,
                                inputFormatters: [FormatsConstants.CPF],
                                maxLines: 15,
                                labelText: 'cpf'.tr,
                                hintText: 'cpf'.tr,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                // autofocus: true,
                                enabled: !_controller.loadingFindData.value,
                                onSaved: (data) {
                                  if (data != null) {
                                    var _cpf = data.replaceAll(".", '').replaceAll("-", '');
                                    _modelRequest = _modelRequest.copyWith(cpf: _cpf);
                                  }
                                },
                                validator: AppValidators.multiple([
                                  // AppValidators.required(),
                                  AppValidators.cpf(),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Obx(() {
                          return Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: AppTextField(
                                controller: _controller.rgPatientController,
                                maxLines: 15,
                                labelText: 'rg'.tr,
                                hintText: 'rg'.tr,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                // autofocus: true,
                                enabled: !_controller.loadingFindData.value,
                                onSaved: (data) => _modelRequest = _modelRequest.copyWith(rg: data),
                                validator: AppValidators.multiple([
                                  // AppValidators.required(),
                                  AppValidators.min(6, "Verifique o RG informado"),
                                ]),
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: 20),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            child: Obx(
                              () => AppDateTime(
                                key: ValueKey(_controller.birthDate.value),
                                controller: _controller.birthDaysController,
                                // resetIcon: null,
                                label: 'birthday'.tr,
                                hintText: 'birthday'.tr,
                                enabled: !_controller.loadingSave.value,
                                initialValue: _controller.birthDate.value,
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
                          ),
                        ),
                        SizedBox(height: 20),
                        Obx(
                          () => Container(
                            padding: EdgeInsets.only(left: 20),
                            child: RadioButtonGroup(
                              title: 'attendance_type'.tr,
                              labels: _controller.listAttendanceType,
                              groupValue: _controller.indexAttendanceType.value,
                              onChanged: _controller.onChangeAttendanceType,
                            ),
                          ),
                        ),
                        Obx(
                          () => Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: AppTextField(
                                controller: _controller.mailDatePatientController,
                                maxLines: 80,
                                labelText: 'email'.tr,
                                hintText: 'email'.tr,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                // autofocus: true,
                                enabled: !_controller.loadingFindData.value,
                                onSaved: (data) => _modelRequest = _modelRequest.copyWith(email: data),
                                validator: AppValidators.multiple([
                                  AppValidators.email(),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Obx(
                          () => Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: AppTextField(
                                controller: _controller.telCelDatePatientController,
                                inputFormatters: [FormatsConstants.phoneMaskFormatter],
                                maxLines: 20,
                                labelText: 'ddd_cellphone'.tr,
                                hintText: 'ddd_cellphone'.tr,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                // autofocus: true,
                                enabled: !_controller.loadingFindData.value,
                                onSaved: (data) => _modelRequest = _modelRequest.copyWith(telCelPatient: data),
                                validator: AppValidators.multiple([
                                  AppValidators.phone(),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Obx(
                          () => Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: AppTextField(
                                controller: _controller.telResDatePatientController,
                                inputFormatters: [FormatsConstants.phoneMaskFormatter],
                                maxLines: 20,
                                labelText: 'ddd_residential_phone'.tr,
                                hintText: 'ddd_residential_phone'.tr,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                // autofocus: true,
                                enabled: !_controller.loadingFindData.value,
                                onSaved: (data) => _modelRequest = _modelRequest.copyWith(telResPatient: data),
                                validator: AppValidators.multiple([
                                  AppValidators.min(8, 'Verifique o número informado.'),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Obx(
                          () => Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: AppTextField(
                                controller: _controller.telComDatePatientController,
                                inputFormatters: [FormatsConstants.phoneMaskFormatter],
                                maxLines: 20,
                                labelText: 'ddd_commercial_phone'.tr,
                                hintText: 'ddd_commercial_phone'.tr,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                // autofocus: true,
                                enabled: !_controller.loadingFindData.value,
                                onSaved: (data) => _modelRequest = _modelRequest.copyWith(telComPatient: data),
                                validator: AppValidators.multiple([
                                  // AppValidators.required(),
                                  AppValidators.min(8, 'Verifique o número informado.'),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Obx(() {
                          return Visibility(
                            visible: _access.accessPaper(Routes.GENERAL_DATA, PaperAccessUser.PRIVATE_UPDATE),
                            child: Container(
                              alignment: Alignment.center,
                              child: AppButton(
                                minWidth: MediaQuery.of(context).size.width - 50,
                                colorBackground: ConstColors.blue,
                                onPressed: () async {
                                  var formValid = _formKey.currentState?.validate() ?? false;
                                  if (formValid) {
                                    _formKey.currentState?.save();
                                    await _controller.saveGeneralData(_params, _modelRequest);
                                  }
                                },
                                childRaisedButton: RenderWhen(
                                  text: 'save'.tr,
                                  isLoading: _controller.loadingSave.value,
                                ),
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
        );
      }),
    );
  }
}
