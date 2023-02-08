import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/constants/const_strings.dart';
import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:medicinadireta/core/packages/dropdown_search_package/app_dropdown_widget_search_impl.dart';
import 'package:medicinadireta/core/validators/app_validators.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/form/app_button_simple.dart';
import 'package:medicinadireta/core/widgets/form/app_text_field.dart';
import 'package:medicinadireta/core/widgets/form/render_when.dart';
import 'package:medicinadireta/core/widgets/form/text_form_field_simple.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/controller/medical_controller.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/widgets/search_farmaceutica.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/widgets/search_terapeutica.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/medical.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/medical_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/principal_active_ext.dart';

import '/core/mixin/basic_page_mixin.dart';
import '/core/models/params/params_to_navigation_page.dart';
import '/core/responsive/responsive_builder.dart';
import '/core/widgets/app_bottom_navigator.dart';
import 'register_principal_active.dart';

class MedicalRegisterForm extends BasePage {
  final String title;
  final bool? edit;
  final Medical? itemMedical;

  MedicalRegisterForm({
    Key? key,
    required this.title,
    this.edit,
    this.itemMedical,
  }) : super(key: key);

  @override
  MedicalRegisterFormState createState() => MedicalRegisterFormState();
}

class MedicalRegisterFormState extends BaseState<MedicalRegisterForm> with WidgetsBindingObserver, BasicPage {
  final _controller = Get.find<MedicalController>();
  var _dataRequest = const MedicalExt();
  final _formKey = GlobalKey<FormState>();

  Medical? get _item => widget.itemMedical;

  final _descriptionMedicalEC = TextEditingController();
  final _descriptionLabEC = TextEditingController();
  final _usoContinuoEC = TextEditingController();
  final _orientationUseEC = TextEditingController();
  final _titleSearchEC = TextEditingController();

  final _viaAdmSearchEC = TextEditingController();
  final _usoContinuoSearchEC = TextEditingController();
  final _tarjaSearchEC = TextEditingController();
  final _antimicrobianoSearchEC = TextEditingController();
  final _listaControladoSearchEC = TextEditingController();
  final _typeMedicalSearchEC = TextEditingController();

  Map<String, dynamic>? _selectedTypeMedical;
  Map<String, dynamic>? _selectedTypeAdm;
  Map<String, dynamic>? _selectedMedicalUsoContinuo;
  Map<String, dynamic>? _selectedMedicalTarja;
  Map<String, dynamic>? _selectedMedicalAntimicrobiano;
  Map<String, dynamic>? _selectedItemListaControlado;

// Map: {id: 55997, medicamentoTipo: ALOPATICO, status: A, medDesc: CIPRO 250MG, tituloBusca: ANTIBIÓTICO, labDesc: BAYER S.A., usoIntExt: INTERNO, usoContinuo: N, qtd: 1, tarja: VERMELHA, ean1: , classeTerapeutica: G4A1 - ANTIBIÓTICOS URINÁRIOS, aprDesc: TOMAR 1 COMPRIMIDO VIA ORAL APÓS A REFEIÇÃO A CADA 12 HORAS DURANTE 7 DIAS., principioAtivo: CIPROFLOXACINO + CLORIDRATO DE CIPROFLOXACINO, formaFarmaceutica: CAIXA(S)}
// https://api.medicinadireta.com.br/odata/Medicamento?api-version=2.0&%24count=true&%24filter=contains(tolower(principioAtivo), 'cipro')
  _showDataFields() {
    if (widget.itemMedical == null) return;
    Medical item = _item!;

    _controller.newMedicalId.value = item.id!;

    List<PrincipalActiveExt> _principiosAtivos = item.principiosAtivos as List<PrincipalActiveExt>;
    _controller.listPrincipalsActives.addAll(_principiosAtivos);

    _dataRequest = _dataRequest.copyWith(status: item.status);

    _descriptionMedicalEC.text = item.medDesc ?? '';
    _titleSearchEC.text = item.tituloBusca ?? '';
    _descriptionLabEC.text = item.labDesc ?? '';
    _usoContinuoEC.text = item.qtd?.toString() ?? '';

    _orientationUseEC.text = item.aprDesc?.toString() ?? '';

    _controller.setVisibilityMedicalControl(item.tarja);

    _controller.setValuesTextFormFields(item);

    _selectedMedicalUsoContinuo = _controller.findItemMap(item.usoContinuo, ConstStrings.typeMedicalUsoContinuo);
    _selectedMedicalTarja = _controller.findItemMap(item.tarja, ConstStrings.typeMedicalTarja);
    _selectedMedicalAntimicrobiano = _controller.findItemMap(item.antimicrobiano, ConstStrings.typeMedicalAntimicrobiano);
    _selectedTypeMedical = _controller.findItemMap(item.medicamentoTipo, ConstStrings.typeMedical);
    _selectedTypeAdm = _controller.findItemMap(item.usoIntExt, ConstStrings.typeMedicalAdm);

    if (item.listaControlado != null) {
      _selectedItemListaControlado = _controller.findItemMap(item.listaControlado, ConstStrings.listaControlado);
    }

    _controller.valueKeyFormGeneral.value = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.listPrincipalsActives.clear();
      _controller.activeTab.value = 0;
      _controller.newMedicalId.value = 0;
      _controller.searchTerapeuticaControllerEC.clear();
      _controller.searchFarmaceuticaControllerEC.clear();
      _controller.requiredFields.value = false;
      _controller.isLoadingSaveNewMedical.value = false;
      if (widget.edit ?? false) _showDataFields();
      // _controller.showPrincipalActive();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionMedicalEC.dispose();
    _descriptionLabEC.dispose();
    _usoContinuoEC.dispose();
    _orientationUseEC.dispose();
    _titleSearchEC.dispose();
    _viaAdmSearchEC.dispose();
    _usoContinuoSearchEC.dispose();
    _tarjaSearchEC.dispose();
    _antimicrobianoSearchEC.dispose();
    _listaControladoSearchEC.dispose();
    _typeMedicalSearchEC.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  String screenName() => widget.title;

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

  @override
  Widget? floatingActionButton() => null;

  @override
  Widget body() => _body();
  Widget _body() {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ResponsiveBuilder(builder: (context, view) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: ConstColors.white,
                child: Row(
                  children: [
                    Obx(() {
                      return Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          color: _controller.activeTab.value == 0 ? ConstColors.blue : ConstColors.white,
                          child: TextButton(
                            onPressed: () => _controller.setTab(0),
                            child: Text(
                              'Medicamento',
                              style: TextStyle(color: _controller.activeTab.value == 0 ? ConstColors.white : ConstColors.blue, fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      );
                    }),
                    Obx(() {
                      return Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          color: _controller.activeTab.value == 1 ? ConstColors.blue : ConstColors.white,
                          child: TextButton(
                            onPressed: () => _controller.setTab(1),
                            child: Text(
                              'Principio Ativo',
                              style: TextStyle(color: _controller.activeTab.value == 1 ? ConstColors.white : ConstColors.blue, fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => Visibility(visible: _controller.activeTab.value == 0, child: widgetForm())),
              Obx(() {
                return Visibility(
                  visible: _controller.activeTab.value == 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TextButton(onPressed: onPressed, child: child),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                        ),
                        onPressed: () {
                          if (_controller.newMedicalId.value == 0) {
                            AppAlert.alertError(title: "Oops!", body: "É necessário cadastrar o medicamento antes de incluir o principio ativo", seconds: 15);
                            return;
                          }
                          Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => SearchPrincipalActive(), fullscreenDialog: true));
                        },
                        child: const Text(
                          'Associar Novo Principio Ativo',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: ConstColors.blue),
                        ),
                      ),
                      // const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Visibility(
                          visible: _controller.listPrincipalsActives.isNotEmpty,
                          child: Obx(() {
                            return ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                PrincipalActiveExt _item = _controller.listPrincipalsActives[index];
                                return Container(
                                  color: ConstColors.white,
                                  child: Obx(() {
                                    return ListTile(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                      title: Text(
                                        _item.principioAtivo.toString(),
                                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: ConstColors.cinza),
                                      ),
                                      trailing: _controller.deleteItemPrincipioAtivo.value == index
                                          ? const CupertinoActivityIndicator()
                                          : IconButton(
                                              onPressed: () => _controller.deletePrincipiosAtivos(_item.id!, _controller.newMedicalId.value, index),
                                              icon: const Icon(
                                                Icons.remove_circle_outline,
                                                color: Colors.red,
                                              ),
                                            ),
                                    );
                                  }),
                                );
                              },
                              separatorBuilder: (_, index) => Container(height: 3),
                              itemCount: _controller.listPrincipalsActives.length,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              })
            ],
          ),
        );
      }),
    );
  }

  Widget widgetForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Obx(() {
            return AppDropdownWidgetSearchImpl(
              key: ValueKey('s0_${_controller.valueKeyFormGeneral.value}'),
              items: ConstStrings.typeMedical,
              selectedItem: _selectedTypeMedical,
              searchControllerEC: _typeMedicalSearchEC,
              labelText: 'Tipo do Medicamento',
              fieldRequired: true,
              hintText: 'Selecione o tipo',
              itemAsString: (dynamic value) => value['value'].toString(),
              validator: (dynamic data) {
                if (data != null && data != '') return null;
                return 'Campo obrigatório';
              },
              onSaved: (dynamic data) {
                if (data != null) _dataRequest = _dataRequest.copyWith(medicamentoTipo: data['id']);
              },
              enabled: !_controller.isLoadingSaveNewMedical.value,
            );
          }),
          SizedBox(height: 10.hEx),
          AppTextField(
            controller: _descriptionMedicalEC,
            maxLines: 100,
            minLines: 3,
            fieldRequired: true,
            labelText: 'Medicamento / Apresentação'.tr,
            hintText: 'Escreva aqui.'.tr,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            enabled: true,
            onSaved: (data) {
              if (data != null) _dataRequest = _dataRequest.copyWith(medDesc: data);
            },
            validator: AppValidators.multiple([
              AppValidators.required(),
              AppValidators.min(3, "Descrição no mínimo 3 caracteres e comprimento máximo de 65000"),
            ]),
            textCapitalization: TextCapitalization.characters,
          ),
          SizedBox(height: 10.hEx),
          AppTextField(
            controller: _titleSearchEC,
            labelText: 'Título da Busca'.tr,
            hintText: 'Título da Busca.'.tr,
            fieldRequired: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            enabled: true,
            onSaved: (data) {
              if (data != null) _dataRequest = _dataRequest.copyWith(tituloBusca: data);
            },
            validator: AppValidators.multiple([
              AppValidators.required(),
              AppValidators.min(3, "Título no mínimo 3 caracteres e comprimento máximo de 255"),
            ]),
            textCapitalization: TextCapitalization.sentences,
          ),
          SizedBox(height: 10.hEx),
          AppTextField(
            controller: _descriptionLabEC,
            maxLines: 100,
            minLines: 1,
            labelText: 'Laboratório'.tr,
            hintText: 'Escreva aqui.'.tr,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            enabled: true,
            onSaved: (data) {
              if (data != null) _dataRequest = _dataRequest.copyWith(labDesc: data);
            },
            // validator: AppValidators.multiple([
            //   AppValidators.required(),
            //   AppValidators.min(3, "Descrição no mínimo 3 caracteres e comprimento máximo de 255"),
            // ]),
            textCapitalization: TextCapitalization.characters,
          ),
          SizedBox(height: 10.hEx),
          Obx(() {
            return AppDropdownWidgetSearchImpl(
              key: ValueKey('s1_${_controller.valueKeyFormGeneral.value}'),
              items: ConstStrings.typeMedicalAdm,
              selectedItem: _selectedTypeAdm,
              searchControllerEC: _viaAdmSearchEC,
              fieldRequired: true,
              labelText: 'Via de Administração',
              hintText: 'Selecione um.',
              itemAsString: (dynamic value) => value['value'].toString(),
              validator: (dynamic data) {
                if (data != null && data != '') return null;
                return 'Campo obrigatório';
              },
              onSaved: (dynamic data) {
                if (data != null) _dataRequest = _dataRequest.copyWith(usoIntExt: data['id']);
              },
              enabled: !_controller.isLoadingSaveNewMedical.value,
            );
          }),
          SizedBox(height: 10.hEx),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(() {
                  return AppDropdownWidgetSearchImpl(
                    key: ValueKey('s2_${_controller.valueKeyFormGeneral.value}'),
                    items: ConstStrings.typeMedicalUsoContinuo,
                    selectedItem: _selectedMedicalUsoContinuo,
                    searchControllerEC: _usoContinuoSearchEC,
                    labelText: 'Uso Contínuo?',
                    hintText: 'Selecione um.',
                    fieldRequired: true,
                    mode: ModeEnum.MENU,
                    showSearchBox: false,
                    itemAsString: (dynamic value) => value['value'].toString(),
                    validator: (dynamic data) {
                      if (data != null && data != '') return null;
                      return 'Campo obrigatório';
                    },
                    onChanged: (dynamic data) {
                      if (data != null) _controller.setRequiredFields(data['id']);
                    },
                    onSaved: (dynamic data) {
                      if (data != null) _dataRequest = _dataRequest.copyWith(usoContinuo: data['id']);
                    },
                    enabled: !_controller.isLoadingSaveNewMedical.value,
                  );
                }),
              ),
              SizedBox(width: 5.wEx),
              Expanded(
                child: Obx(() {
                  return AppTextField(
                    controller: _usoContinuoEC,
                    labelText: 'Quantidade'.tr,
                    hintText: 'Defina uma quantidade base.'.tr,
                    fieldRequired: _controller.requiredFields.value == true,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    enabled: true,
                    onSaved: (data) {
                      if (data != null && data != '') _dataRequest = _dataRequest.copyWith(qtd: int.parse(data.toString()));
                    },
                    validator: _controller.requiredFields.value ? AppValidators.required() : null,
                    textCapitalization: TextCapitalization.none,
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: 10.hEx),
          Obx(() {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => SearchFarmaceutica(),
                  fullscreenDialog: true,
                ),
              ),
              child: TextFormFieldSimple(
                key: ValueKey(_controller.valueKeyForma.value),
                controller: _controller.searchFarmaceuticaControllerEC,
                labelText: 'Forma Farmacêutica'.tr,
                hintText: 'Escreva aqui.'.tr,
                enabled: false,
                fieldRequired: _controller.requiredFields.value == true,
                validator: _controller.requiredFields.value ? AppValidators.required() : null,
                onSaved: (String? data) {
                  if (data != null && data != '') _dataRequest = _dataRequest.copyWith(formaFarmaceutica: data);
                },
              ),
            );
          }),
          SizedBox(height: 10.hEx),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(() {
                  return AppDropdownWidgetSearchImpl(
                    key: ValueKey('s3_${_controller.valueKeyFormGeneral.value}'),
                    items: ConstStrings.typeMedicalTarja,
                    selectedItem: _selectedMedicalTarja,
                    searchControllerEC: _tarjaSearchEC,
                    labelText: 'Tarja',
                    hintText: 'Selecione um.',
                    mode: ModeEnum.MENU,
                    showSearchBox: false,
                    itemAsString: (dynamic value) => value['value'].toString(),
                    // validator: (dynamic data) {
                    //   if (data != null && data != '') return null;
                    //   return 'Campo obrigatório';
                    // },
                    onChanged: (dynamic data) => _controller.setVisibilityMedicalControl(data['id']),
                    onSaved: (dynamic data) {
                      if (data != null) _dataRequest = _dataRequest.copyWith(tarja: data['id']);
                    },
                    enabled: !_controller.isLoadingSaveNewMedical.value,
                  );
                }),
              ),
              SizedBox(width: 5.wEx),
              Expanded(
                child: Obx(() {
                  return AppDropdownWidgetSearchImpl(
                    key: ValueKey('s4_${_controller.valueKeyFormGeneral.value}'),
                    items: ConstStrings.typeMedicalAntimicrobiano,
                    selectedItem: _selectedMedicalAntimicrobiano,
                    searchControllerEC: _antimicrobianoSearchEC,
                    labelText: 'Antimicrobiano',
                    hintText: 'Selecione um.',
                    mode: ModeEnum.MENU,
                    showSearchBox: false,
                    itemAsString: (dynamic value) => value['value'].toString(),
                    // validator: (dynamic data) {
                    //   if (data != null && data != '') return null;
                    //   return 'Campo obrigatório';
                    // },
                    onSaved: (dynamic data) {
                      if (data != null) _dataRequest = _dataRequest.copyWith(antimicrobiano: data['id']);
                    },
                    enabled: !_controller.isLoadingSaveNewMedical.value,
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: 10.hEx),
          Obx(() {
            return Visibility(
              visible: _controller.visibilityListMedicalControl.value,
              child: AppDropdownWidgetSearchImpl(
                key: ValueKey('s5_${_controller.valueKeyFormGeneral.value}'),
                items: ConstStrings.listaControlado,
                selectedItem: _selectedItemListaControlado,
                searchControllerEC: _listaControladoSearchEC,
                labelText: 'Lista Controlado',
                hintText: 'Selecione um.',
                fieldRequired: true,
                mode: ModeEnum.MENU,
                showSearchBox: false,
                itemAsString: (dynamic value) => value['value'].toString(),
                validator: (dynamic data) {
                  if (data != null && data != '') return null;
                  return 'Campo obrigatório';
                },
                onSaved: (dynamic data) {
                  if (data != null) _dataRequest = _dataRequest.copyWith(listaControlado: data['id']);
                },
                enabled: !_controller.isLoadingSaveNewMedical.value,
              ),
            );
          }),
          SizedBox(height: 10.hEx),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SearchTerapeutica(),
                fullscreenDialog: true,
              ),
            ),
            child: Obx(() {
              return TextFormFieldSimple(
                key: ValueKey('s7_${_controller.valueKeyTerapeutica.value}'),
                controller: _controller.searchTerapeuticaControllerEC,
                // fieldRequired: true,
                labelText: 'Classe Terapêutica'.tr,
                hintText: 'Escreva 1 (um) ou mais caracteres.'.tr,
                enabled: false,
                // validator: AppValidators.required(m: 'Classe Terapêutica.'),
                onSaved: (String? data) {
                  if (data != null) _dataRequest = _dataRequest.copyWith(classeTerapeutica: data);
                },
              );
            }),
          ),
          SizedBox(height: 10.hEx),
          AppTextField(
            controller: _orientationUseEC,
            maxLines: 50,
            minLines: 5,
            fieldRequired: true,
            labelText: 'Orientação de Uso'.tr,
            hintText: 'Escreva aqui.'.tr,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            enabled: true,
            onSaved: (data) {
              if (data != null) _dataRequest = _dataRequest.copyWith(aprDesc: data);
            },
            validator: AppValidators.multiple([
              AppValidators.required(),
              AppValidators.min(3, "Descrição no mínimo 3 caracteres e comprimento máximo de 255"),
            ]),
            textCapitalization: TextCapitalization.characters,
          ),
          SizedBox(height: 10.hEx),
          // Visibility(
          //   visible: (widget.edit ?? false) && widget.itemMedical?.id != null,
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       SizedBox(height: 10.hEx),
          //       AppButton(
          //         height: 30,
          //         minWidth: MediaQuery.of(context).size.width,
          //         colorBackground: ConstColors.ff5897F5,
          //         onPressed: () {
          //           if (widget.itemMedical?.id == null) {
          //             AppAlert.alertError(title: "Oops!", body: "ID do medicamento não localizado!", seconds: 15);
          //             return;
          //           }
          //           _controller.newMedicalId.value = widget.itemMedical!.id!;
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute<void>(
          //               builder: (BuildContext context) => SearchPrincipalActive(),
          //               fullscreenDialog: true,
          //             ),
          //           );
          //         },
          //         childRaisedButton: RenderWhen(text: '+ Incluir Novo Princípio Ativo'),
          //       ),
          //       SizedBox(height: 20.hEx),
          //     ],
          //   ),
          // ),
          Row(
            children: [
              Obx(() {
                return Expanded(
                  child: AppButton(
                    minWidth: MediaQuery.of(context).size.width,
                    colorBackground: ConstColors.blue,
                    onPressed: _controller.isLoadingSaveNewMedical.value
                        ? null
                        : () async {
                            var formValid = _formKey.currentState?.validate() ?? false;
                            if (formValid) {
                              _formKey.currentState?.save();
                              AppLog.i(jsonEncode(_dataRequest.toMap()));
                              if (_controller.newMedicalId.value != 0) {
                                await _controller.updateMedical(_dataRequest, _controller.newMedicalId.value);
                              } else {
                                await _controller.saveNewMedical(_dataRequest);
                              }
                            }
                          },
                    childRaisedButton: RenderWhen(
                      text: !widget.edit! ? 'Cadastrar' : "Atualizar",
                      isLoading: _controller.isLoadingSaveNewMedical.value,
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
