import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/constants/const_drawables.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/controller_from_initial/verification_access_menu_user.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/menu/item_menu.dart';
import 'package:medicinadireta/core/menu/model/item_submenu_model.dart';
import 'package:medicinadireta/core/mixin/basic_page_mixin.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/modules/patient_alert/presenter/controller/patient_alert_controller.dart';
import 'package:medicinadireta/modules/patient_alert/presenter/widgets/shimmer_alerts.dart';
import 'package:medicinadireta/modules/patient_information/presenter/controller/find_data_patient_controller.dart';
import 'package:medicinadireta/modules/patient_information/presenter/controller/patient_datails_controller.dart';
import 'package:medicinadireta/modules/patient_information/presenter/widgets/item_card_alert.dart';
import 'package:medicinadireta/modules/patient_information/submodules/attachments/presenter/controller/camera_gallery_controller.dart';
import 'package:medicinadireta/routes/app_pages.dart';

class PatientDetailsPhone extends BasePage {
  PatientDetailsPhone({Key? key}) : super(key: key);

  @override
  _PatientDetailsPhoneState createState() => _PatientDetailsPhoneState();
}

class _PatientDetailsPhoneState extends BaseState<PatientDetailsPhone> with WidgetsBindingObserver, BasicPage {
  final _controllerFindPatient = Get.find<FindDataPatientController>();
  final _controller = Get.find<PatientDetailsController>();
  final _access = Get.find<VerificationAccessMenuUser>();
  final _camera = Get.find<CameraGalleryController>();
  final _alerts = Get.find<PatientAlertController>();
  final _scrollController = ScrollController();

  final ParamsToNavigationPage _params = Get.arguments;

  @override
  ParamsToNavigationPage? screenCardPatient() => null;

  @override
  String screenName() => 'patient'.tr;

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  Widget? floatingActionButton() => null;

  @override
  List<Widget>? actions() => [];

  @override
  AppBottomNavigationBar? bottomNavigationBar() => AppBottomNavigationBar();

  @override
  Function()? onPressedLeading() => _params.voltarParaPagina == Routes.LIST_PATIENT ? () async => await Get.toNamed(Routes.LIST_PATIENT) : () async => await Get.toNamed(Routes.DOCTOR_COMMITMENT, arguments: _params);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _alerts.getFirstPage(_params.pacienteId);
      _controllerFindPatient.paramsNavigator(_params);
      _controllerFindPatient.loadingSaveFotoPerfil.value = false;
      _controllerFindPatient.photoPerfilCamera.clear();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget body() {
    return _body();
  }

  Widget _body() {
    return ResponsiveBuilder(builder: (context, view) {
      return RefreshIndicator(
        onRefresh: () async => await Future.wait([_controllerFindPatient.getFirstPage(_params.pacienteId), _alerts.getFirstPage(_params.pacienteId)]),
        child: CupertinoScrollbar(
          controller: _scrollController,
          child: SizedBox(
            height: view.localWidgetSize?.height,
            child: Column(
              children: [
                CardPatient(params: _params, controller: _controllerFindPatient, camera: _camera),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    // physics: NeverScrollableScrollPhysics(),
                    controller: _scrollController,
                    child: AnimatedFromColumn(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() {
                          _controller.isOpenCardDataGeneral.value;
                          if (_alerts.isLoading.value == AppLoadingStatus.shimmerLoading) {
                            return const ShimmerAlerts();
                          }
                          return ItemCardAlert(alerts: _alerts.listPatientAlerts, controller: _alerts);
                        }),
                        const SizedBox(height: 10),
                        Obx(() {
                          return ItemMenu(
                            showItem: _controller.isOpenCardDataGeneral.value,
                            contentPadding: const EdgeInsets.only(left: 30, right: 10),
                            itens: [
                              ItemSubmenuModel(
                                visible: _access.existsKeyMenu(Routes.GENERAL_DATA),
                                title: 'Editar dados',
                                onTap: () async => await Get.toNamed(Routes.GENERAL_DATA, arguments: _params),
                              ),
                              ItemSubmenuModel(
                                visible: _access.existsKeyMenu(Routes.RELATIONSHIP),
                                title: 'Relacionamento',
                                onTap: () async => await Get.toNamed(Routes.RELATIONSHIP, arguments: _params),
                              ),
                            ],
                            leadingPrimary: const Icon(Icons.manage_accounts, size: 25, color: ConstColors.blue),
                            onTapPrimary: () => _controller.openCardDataGeneral(),
                            titlePrimary: 'Dados Gerais',
                          );
                        }),
                        const SizedBox(height: 10),
                        Obx(
                          () {
                            return ItemMenuItemMenu(
                              showItem: _controller.isOpenCardSoap.value,
                              leadingPrimary: const Icon(Icons.account_tree_outlined, size: 25, color: ConstColors.blue),
                              onTapPrimary: () => _controller.openCardSoap(),
                              titlePrimary: 'SOAP',
                              contentPadding: const EdgeInsets.only(left: 30, right: 10),
                              itemMenu: [
                                ItemMenu(
                                  showItem: _controller.isOpenCardSoapSubjetivo.value,
                                  visibleIconLeading: true,
                                  leadingPrimary: const Icon(Icons.list, size: 25, color: ConstColors.blue),
                                  onTapPrimary: () => _controller.openCardSoapSubjetivo(),
                                  titlePrimary: 'Subjetivo',
                                  contentPaddingSub: const EdgeInsets.only(left: 60),
                                  contentPadding: const EdgeInsets.only(left: 44, right: 10),
                                  backgroundItem: Colors.grey.shade100,
                                  itens: [
                                    ItemSubmenuModel(
                                      visible: _access.existsKeyMenu(Routes.ANAMNESE),
                                      title: 'Anamnese',
                                      onTap: () async => await Get.toNamed(Routes.ANAMNESE, arguments: _params),
                                    ),
                                    ItemSubmenuModel(
                                      visible: _access.existsKeyMenu(Routes.EVOLUTION),
                                      title: 'Evolução',
                                      onTap: () async => await Get.toNamed(Routes.EVOLUTION, arguments: _controllerFindPatient.paramsToNavigationPage.value),
                                    ),
                                    ItemSubmenuModel(
                                      visible: _access.existsKeyMenu(Routes.ALLERGYS),
                                      title: 'Alergias',
                                      onTap: () async => await Get.toNamed(Routes.ALLERGYS, arguments: _controllerFindPatient.paramsToNavigationPage.value),
                                    ),
                                    ItemSubmenuModel(
                                      visible: _access.existsKeyMenu(Routes.MEDICINES_IN_USE),
                                      title: 'Medicamentos em uso',
                                      onTap: () async => await Get.toNamed(Routes.MEDICINES_IN_USE, arguments: _params),
                                    ),
                                    ItemSubmenuModel(
                                      visible: _access.existsKeyMenu(Routes.ATTACHMENTS),
                                      title: 'Anexos',
                                      onTap: () async => await Get.toNamed(Routes.ATTACHMENTS, arguments: _params),
                                    ),
                                  ],
                                ),
                                ItemMenu(
                                  showItem: _controller.isOpenCardSoapObjetivo.value,
                                  visibleIconLeading: true,
                                  leadingPrimary: const Icon(Icons.list, size: 25, color: ConstColors.blue),
                                  onTapPrimary: () => _controller.openCardSoapObjetivo(),
                                  titlePrimary: 'Objetivo',
                                  contentPaddingSub: const EdgeInsets.only(left: 60),
                                  contentPadding: const EdgeInsets.only(left: 44, right: 10),
                                  backgroundItem: Colors.grey.shade100,
                                  itens: [
                                    ItemSubmenuModel(
                                      visible: _access.existsKeyMenu(Routes.pressure),
                                      title: 'Pressão Arterial',
                                      onTap: () async => await Get.toNamed(Routes.pressure, arguments: _params),
                                    ),
                                    ItemSubmenuModel(
                                      visible: _access.existsKeyMenu(Routes.anthropometry),
                                      title: 'Antropometria',
                                      onTap: () async => await Get.toNamed(Routes.anthropometry, arguments: _params),
                                    ),
                                  ],
                                ),
                                ItemMenu(
                                  showItem: _controller.isOpenCardSoapPlano.value,
                                  visibleIconLeading: true,
                                  leadingPrimary: const Icon(Icons.list, size: 25, color: ConstColors.blue),
                                  onTapPrimary: () => _controller.openCardSoapPlano(),
                                  titlePrimary: 'Plano',
                                  contentPaddingSub: const EdgeInsets.only(left: 60),
                                  contentPadding: const EdgeInsets.only(left: 44, right: 10),
                                  backgroundItem: Colors.grey.shade100,
                                  itens: [
                                    ItemSubmenuModel(
                                      visible: _access.existsKeyMenu(Routes.prescription),
                                      title: 'Receitas',
                                      onTap: () async => await Get.toNamed(Routes.prescription, arguments: _params),
                                    ),
                                    ItemSubmenuModel(
                                      visible: _access.existsKeyMenu(Routes.exams),
                                      title: 'Exames',
                                      onTap: () async => await Get.toNamed(Routes.exams, arguments: _params),
                                    ),
                                    ItemSubmenuModel(
                                      visible: _access.existsKeyMenu(Routes.formPlan),
                                      title: 'Formulários',
                                      onTap: () async => await Get.toNamed(Routes.formPlan, arguments: _params),
                                    ),
                                    ItemSubmenuModel(
                                      visible: _access.existsKeyMenu(Routes.MEMED),
                                      iconDataImage: ConstDrawables.memed,
                                      title: 'Memed',
                                      leading: Image.asset(ConstDrawables.memed),
                                      onTap: () async => await Get.toNamed(Routes.MEMED, arguments: _params),
                                    ),
                                  ],
                                ),
                                // Visibility(
                                //   visible: _access.existsKeyMenu(Routes.MEMED),
                                //   child: ItemMenu(
                                //     titlePrimary: 'Memed',
                                //     styleTitlePrimary: GoogleFonts.openSans(
                                //       color: ConstColors.cinza,
                                //       fontWeight: FontWeight.w400,
                                //       fontSize: 15,
                                //     ),
                                //     iconDataImage: ConstDrawables.memed,
                                //     showItem: false,
                                //     onTapPrimary: () async => await Get.toNamed(Routes.MEMED, arguments: _params),
                                //     // contentPadding: const EdgeInsets.only(left: 30, right: 10),
                                //     contentPadding: const EdgeInsets.only(left: 46, right: 10),
                                //   ),
                                // ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        ItemMenu(
                          contentPadding: const EdgeInsets.only(left: 30, right: 10),
                          showItem: false,
                          visiblePrimary: _access.existsKeyMenu(Routes.COMMUNICATION),
                          leadingPrimary: const Icon(Icons.outbox_outlined, size: 25, color: ConstColors.blue), //Icons.outbox_outlined,
                          onTapPrimary: () async => await Get.toNamed(Routes.COMMUNICATION, arguments: _params),
                          titlePrimary: 'Comunicação',
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class CardPatient extends StatelessWidget {
  final ParamsToNavigationPage params;
  final FindDataPatientController controller;
  final CameraGalleryController camera;

  const CardPatient({Key? key, required this.params, required this.controller, required this.camera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Obx(() {
                  ParamsToNavigationPage _newFoto = controller.paramsToNavigationPage.value;
                  bool _isNotEmpty = _newFoto.photoPerfil != null;
                  return InkWell(
                    onTap: () async => await controller.changePhoto(params),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: controller.loadingSaveFotoPerfil.value
                              ? const CupertinoActivityIndicator()
                              : Column(
                                  children: [
                                    controller.photoPerfilCamera.isNotEmpty
                                        ? Expanded(child: CircleAvatar(radius: 38, backgroundImage: FileImage(controller.photoPerfilCamera.first)))
                                        : (_isNotEmpty
                                            ? Expanded(
                                                child: CircleAvatar(
                                                  radius: 38,
                                                  backgroundImage: MemoryImage(_newFoto.photoPerfil!),
                                                ),
                                              )
                                            : const Expanded(child: Icon(Icons.account_circle, size: 70, color: ConstColors.blue))),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Prontuário".toUpperCase(),
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(color: ConstColors.greyCard, fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                            decoration: BoxDecoration(
                              color: ConstColors.orange,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              params.numeroDoProtuario?.toString() ?? 'no_value'.tr,
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: ConstColors.white, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              params.nomeDoPaciente?.toUpperCase() ?? 'no_value'.tr,
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: ConstColors.blue, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Idade: ${params.idade ?? '--'}".toUpperCase(),
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: ConstColors.greyCard, fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Divider(color: ConstColors.border),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.mail_outline, size: 18),
                            const SizedBox(width: 5),
                            Text(
                              params.email.toString().isEmail ? params.email.toString() : 'no_email'.tr,
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: ConstColors.blue, fontSize: 11, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.phone_iphone_outlined, size: 18),
                            const SizedBox(width: 5),
                            Text(
                              params.telefone?.toUpperCase() ?? 'no_phone'.tr,
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: ConstColors.blue, fontSize: 11, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}
