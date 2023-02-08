import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/constants/const_strings.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/packages/dropdown_search_package/app_dropdown_widget_search_impl.dart';
import 'package:medicinadireta/core/validators/app_validators.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/form/app_date_time_field.dart';
import 'package:medicinadireta/core/widgets/form/app_text_field.dart';
import 'package:medicinadireta/core/widgets/form/render_when.dart';
import 'package:medicinadireta/core/widgets/form/text_form_field_simple.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/allergy.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/medical.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/presenter/widgets/search_medical.dart';

import '../../infra/models/network/request_allergy_ext.dart';

import '/core/mixin/basic_page_mixin.dart';
import '/core/models/params/params_to_navigation_page.dart';
import '/core/responsive/responsive_builder.dart';
import '/core/widgets/app_bottom_navigator.dart';
import '/modules/patient_information/submodules/allergy/presenter/controller/allergy_controller.dart';
import '/routes/app_pages.dart';

class FormAllergy extends BasePage {
  final String title;
  final bool? edit;
  final Allergy? itemAllergy;
  final AllergyController controller;
  final ParamsToNavigationPage params;
  FormAllergy({Key? key, required this.controller, required this.params, this.edit = false, this.itemAllergy, required this.title}) : super(key: key);

  @override
  FormAllergyState createState() => FormAllergyState();
}

class FormAllergyState extends BaseState<FormAllergy> with WidgetsBindingObserver, BasicPage {
  AllergyController get _controller => widget.controller;
  ParamsToNavigationPage get _params => widget.params;
  bool? get _edit => widget.edit;
  Allergy? get _allergy => widget.itemAllergy;

  final _formKey = GlobalKey<FormState>();
  var _dataRequest = const RequestAllergyExt();

  final _dateEventEC = TextEditingController();

  final _descriptionReacaoEC = TextEditingController();
  final _dateOcorridoDeEC = TextEditingController();
  final _dateOcorridoAteEC = TextEditingController();

  DateTime? _dateEventValue;
  DateTime? _initialDateOcorridoDe;
  DateTime? _initialDateOcorridoAte;

  // String? _selectedItemUTC;
  // Map<String, dynamic>? _selectedItemUTC = {"id": "-03:00", "value": "-03:00"};
  Map<String, dynamic>? _selectedItemOrigemInfo = {"id": 4, "value": "PACIENTE"};
  Map<String, dynamic>? _selectedItemOrigemTipo;
  Map<String, dynamic>? _selectedItemAllergy = {"id": 1, "value": "ATIVO"};
  Map<String, dynamic>? _selectedItemSeveridade;
  Map<String, dynamic>? _selectedItemConfirm;
  Map<String, dynamic>? _selectedItemReaction = {"id": "A", "value": "ALERGIA"};
  Map<String, dynamic>? _selectedItemOcorrido;

  dateNow() {
    String _date = DateTime.now().toString();
    _dateEventEC.text = _controller.formatsDateTime(_date, time: true);
    _dateEventValue = _controller.prepareDateTime(_date);
  }

  _showDataFields(Allergy allergy) {
    _controller.descriptionAllergyEC.text = allergy.descricao ?? '';
    _descriptionReacaoEC.text = allergy.reacao ?? '';

    if (allergy.dataEvento?.isNotEmpty ?? false) {
      _dateEventEC.text = _controller.formatsDateTime(allergy.dataEvento, time: true);
      _dateEventValue = _controller.prepareDateTime(allergy.dataEvento);
    }

    if (allergy.dataInicioOcorrido?.isNotEmpty ?? false) {
      _dateOcorridoDeEC.text = _controller.formatsDateTime(allergy.dataInicioOcorrido);
      _initialDateOcorridoDe = _controller.prepareDateTime(allergy.dataInicioOcorrido);
    }

    if (allergy.dataFimOcorrido?.isNotEmpty ?? false) {
      _dateOcorridoAteEC.text = _controller.formatsDateTime(allergy.dataFimOcorrido);
      _initialDateOcorridoAte = _controller.prepareDateTime(allergy.dataFimOcorrido);
    }

    Medical? medical = Medical(
      id: allergy.medicamentoId,
      medDesc: allergy.medicamento,
      principioAtivo: allergy.principioAtivo,
      aprDesc: allergy.viaAdministracao,
    );

    ///Habilita os campos de data de inicio da ocorrência e fim, desse registro
    if (allergy.dataTipo != null) _controller.visibilityDateOcorrido.value = true;

    var _selectedItemUTC = _controller.findItemMap(allergy.utcEvento.toString(), ConstStrings.listUTC);
    if (_selectedItemUTC != null) _controller.selectedItemUTC.addAll(_selectedItemUTC);

    _selectedItemOrigemInfo = _controller.findItemMap(allergy.origem, ConstStrings.origemInfo);
    _selectedItemOrigemTipo = _controller.findItemMap(allergy.tipo, ConstStrings.origemTipo);
    _selectedItemAllergy = _controller.findItemMap(allergy.status, ConstStrings.statusAllergy);
    _selectedItemSeveridade = _controller.findItemMap(allergy.severidade, ConstStrings.typeSeveridade);
    _selectedItemConfirm = _controller.findItemMap(allergy.confirmacao, ConstStrings.statusConfirm);
    _selectedItemReaction = _controller.findItemMap(allergy.classificacaoReacao, ConstStrings.statusReacao);
    _selectedItemOcorrido = _controller.findItemMap(allergy.dataTipo, ConstStrings.statusOcorrido);

    _controller.setVisibilityMedical(allergy.tipo);
    _controller.setVisibilityOcorrido(allergy.dataTipo);
    _controller.medicalForm.add(medical);
    _controller.searchControllerEC.text = allergy.medicamento?.toString() ?? '';
    _controller.descriptionAllergyEC.text = allergy.descricao?.toString() ?? '';

    // _controller.setMedicalSendForm(medical);

    ///Serve para rebuildar os componentes de select
    _controller.valueKeySelected.value = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_edit!) dateNow();
      _controller.visibilityMedical.value = false;
      _controller.visibilityDateOcorrido.value = false;
      _controller.descriptionAllergyEC.clear();
      _controller.searchControllerEC.clear();
      _controller.medicalForm.clear();
      if (_edit!) _showDataFields(_allergy!);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    _dateEventEC.dispose();
    _descriptionReacaoEC.dispose();
    _dateOcorridoDeEC.dispose();
    _dateOcorridoAteEC.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  String screenName() => widget.title;

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  AppBottomNavigationBar? bottomNavigationBar() => AppBottomNavigationBar();

  @override
  Function()? onPressedLeading() => () => Get.toNamed(Routes.ALLERGYS, arguments: widget.params);

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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: AppDateTime(
                        key: ValueKey(_dateEventValue),
                        padding: const EdgeInsets.all(0),
                        controller: _dateEventEC,
                        hintText: 'Selecione data e hora'.tr,
                        label: 'Data e Horário'.tr,
                        enabled: true,
                        initialValue: _dateEventValue,
                        timer: true,
                        allowAfter: false,
                        validator: (DateTime? data) {
                          if (data != null) return null;
                          return 'requiredField'.tr;
                        },
                        onSaved: (DateTime? data) {
                          if (data != null) _dataRequest = _dataRequest.copyWith(dataEvento: data.toUtc().toString());
                        },
                      ),
                    ),
                    SizedBox(width: 5.wEx),
                    Expanded(
                      flex: 1,
                      child: Obx(() {
                        return AppDropdownWidgetSearchImpl(
                          key: ValueKey(_controller.valueKeySelected.value),
                          mode: ModeEnum.MENU,
                          items: ConstStrings.listUTC,
                          itemAsString: (dynamic value) => value['value'].toString(),
                          selectedItem: _controller.selectedItemUTC,
                          validator: (dynamic data) {
                            if (data != null) return null;
                            return 'requiredField'.tr;
                          },
                          onSaved: (dynamic data) {
                            if (data != null) _dataRequest = _dataRequest.copyWith(utcEvento: data['id']);
                          },
                          labelText: 'UTC',
                          hintText: 'Fuso horário',
                          showSearchBox: false,
                          enabled: !_controller.loadingSave.value,
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 10.hEx),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Obx(() {
                        return AppDropdownWidgetSearchImpl(
                          key: ValueKey(_controller.valueKeySelected.value),
                          items: ConstStrings.origemInfo,
                          selectedItem: _selectedItemOrigemInfo,
                          labelText: 'Origem da informação',
                          hintText: 'Selecione a origem',
                          itemAsString: (dynamic value) => value['value'].toString(),
                          onSaved: (dynamic data) {
                            if (data != null) _dataRequest = _dataRequest.copyWith(origem: data['id']);
                          },
                          enabled: !_controller.loadingSave.value,
                        );
                      }),
                    ),
                    SizedBox(width: 5.wEx),
                    Expanded(
                      child: Obx(() {
                        return AppDropdownWidgetSearchImpl(
                          key: ValueKey(_controller.valueKeySelected.value),
                          items: ConstStrings.origemTipo,
                          itemAsString: (dynamic value) => value['value'].toString(),
                          selectedItem: _selectedItemOrigemTipo,
                          labelText: 'Tipo',
                          hintText: 'Selecione o tipo',
                          fieldRequired: true,
                          onChanged: (dynamic data) {
                            if (data != null) _controller.setVisibilityMedical(data['id']);
                          },
                          validator: (dynamic data) {
                            if (data != null) return null;
                            return 'requiredField'.tr;
                          },
                          onSaved: (dynamic data) {
                            if (data != null) _dataRequest = _dataRequest.copyWith(tipo: data['id']);
                          },
                          enabled: !_controller.loadingSave.value,
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 10.hEx),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Obx(() {
                        return AppDropdownWidgetSearchImpl(
                          key: ValueKey(_controller.valueKeySelected.value),
                          items: ConstStrings.statusAllergy,
                          selectedItem: _selectedItemAllergy,
                          labelText: 'Status da Alergia',
                          hintText: 'Selecione o status atual.',
                          itemAsString: (dynamic value) => value['value'].toString(),
                          validator: (dynamic data) {
                            if (data != null) return null;
                            return 'requiredField'.tr;
                          },
                          onSaved: (dynamic data) {
                            if (data != null) _dataRequest = _dataRequest.copyWith(status: data['id']);
                          },
                          enabled: !_controller.loadingSave.value,
                        );
                      }),
                    ),
                    SizedBox(width: 5.wEx),
                    Expanded(
                      child: Obx(() {
                        return AppDropdownWidgetSearchImpl(
                          key: ValueKey(_controller.valueKeySelected.value),
                          items: ConstStrings.typeSeveridade,
                          itemAsString: (dynamic value) => value['value'].toString(),
                          selectedItem: _selectedItemSeveridade,
                          labelText: 'Severidade',
                          hintText: 'Selecione a severidade.',
                          onSaved: (dynamic data) {
                            if (data != null) _dataRequest = _dataRequest.copyWith(severidade: data['id']);
                          },
                          enabled: !_controller.loadingSave.value,
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 10.hEx),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Obx(() {
                        return AppDropdownWidgetSearchImpl(
                          key: ValueKey(_controller.valueKeySelected.value),
                          items: ConstStrings.statusConfirm,
                          selectedItem: _selectedItemConfirm,
                          labelText: 'Confirmação',
                          hintText: 'Selecione o status.',
                          fieldRequired: true,
                          itemAsString: (dynamic value) => value['value'].toString(),
                          validator: (dynamic data) {
                            if (data != null) return null;
                            return 'requiredField'.tr;
                          },
                          onSaved: (dynamic data) {
                            if (data != null) _dataRequest = _dataRequest.copyWith(confirmacao: data['id']);
                          },
                          showSearchBox: false,
                          mode: ModeEnum.MENU,
                          enabled: !_controller.loadingSave.value,
                        );
                      }),
                    ),
                    SizedBox(width: 5.wEx),
                    Expanded(
                      child: Obx(() {
                        return AppDropdownWidgetSearchImpl(
                          key: ValueKey(_controller.valueKeySelected.value),
                          items: ConstStrings.statusReacao,
                          itemAsString: (dynamic value) => value['value'].toString(),
                          selectedItem: _selectedItemReaction,
                          labelText: 'Classificação Reação',
                          hintText: 'Selecione a Reação.',
                          validator: (dynamic data) {
                            if (data != null) return null;
                            return 'requiredField'.tr;
                          },
                          onSaved: (dynamic data) {
                            if (data != null) _dataRequest = _dataRequest.copyWith(classificacaoReacao: data['id']);
                          },
                          showSearchBox: false,
                          mode: ModeEnum.MENU,
                          enabled: !_controller.loadingSave.value,
                        );
                      }),
                    ),
                  ],
                ),
                Obx(() {
                  return Visibility(
                    visible: _controller.visibilityMedical.value,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      color: ConstColors.white,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => SearchMedical(controller: _controller),
                                fullscreenDialog: true,
                              ),
                            ),
                            child: TextFormFieldSimple(
                              key: ValueKey("_medical_${_controller.listMedical.length}"),
                              controller: _controller.searchControllerEC,
                              labelText: 'Medicamento'.tr,
                              hintText: 'Escreva aqui.'.tr,
                              enabled: false,
                              fieldRequired: true,
                              validator: AppValidators.required(m: 'Selecione o Medicamento.'),
                              onSaved: (String? data) {
                                if (data != ConstStrings.appValueNull && _controller.medicalForm.isNotEmpty) {
                                  Medical dta = _controller.medicalForm.first;
                                  bool _principioAtivo = dta.principioAtivo != null && dta.principioAtivo != '';
                                  bool _formaFarmaceutica = dta.formaFarmaceutica != null && dta.formaFarmaceutica != '';
                                  _dataRequest = _dataRequest.copyWith(
                                    // fonteMedicamento: '',
                                    medicamentoId: dta.id,
                                    medicamento: dta.medDesc ?? '',
                                    principioAtivo: _principioAtivo ? dta.principioAtivo : null,
                                    // formaFarmaceutica: '',
                                    viaAdministracao: dta.aprDesc ?? '',
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 20.hEx),
                        ],
                      ),
                    ),
                  );
                }),
                Obx(() {
                  return Visibility(
                    visible: _controller.visibilityMedical.value,
                    child: Container(
                      color: ConstColors.white,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      alignment: Alignment.bottomLeft,
                      child: RichText(
                        text: TextSpan(
                          text: 'Principio Ativo: ',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: ConstColors.blue),
                          children: [
                            TextSpan(
                              text: _controller.medicalForm.isNotEmpty ? _controller.medicalForm.first.principioAtivo.toString() : '--',
                              style: const TextStyle(fontWeight: FontWeight.w400, color: ConstColors.cinza),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(height: 10.hEx),

                /// Deve ser preenchido conforme a seleção do medicamento
                /// Preencher com os detalhes do medicamento selecionado
                /// se não selecionar deixar como uma caixa simples para editar o que quiser

                AppTextField(
                  controller: _controller.descriptionAllergyEC,
                  maxLines: 300,
                  minLines: 5,
                  labelText: 'Descrição da Alergia'.tr,
                  hintText: 'Escreva aqui.'.tr,
                  fieldRequired: true,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  enabled: true,
                  validator: AppValidators.multiple([
                    AppValidators.required(),
                    AppValidators.min(3, "Descrição no mínimo 5 caracteres e comprimento máximo de 255"),
                  ]),
                  textCapitalization: TextCapitalization.sentences,
                  onSaved: (String? data) {
                    if (data != ConstStrings.appValueNull) _dataRequest = _dataRequest.copyWith(descricao: data);
                  },
                ),
                SizedBox(height: 10.hEx),
                AppTextField(
                  controller: _descriptionReacaoEC,
                  maxLines: 300,
                  minLines: 5,
                  labelText: 'Reação'.tr,
                  hintText: 'Escreva aqui.'.tr,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  enabled: true,
                  // validator: (String? data) {
                  //   if (data != null && data != '') return null;
                  //   return 'requiredField'.tr;
                  // },
                  textCapitalization: TextCapitalization.sentences,
                  onSaved: (String? data) {
                    if (data != null && data != '') _dataRequest = _dataRequest.copyWith(reacao: data);
                  },
                ),
                SizedBox(height: 10.hEx),
                Obx(() {
                  return AppDropdownWidgetSearchImpl(
                    key: ValueKey(_controller.valueKeySelected.value),
                    items: ConstStrings.statusOcorrido,
                    itemAsString: (dynamic value) => value['value'].toString(),
                    selectedItem: _selectedItemOcorrido,
                    labelText: 'Informar Data do Ocorrido',
                    hintText: 'Selecione o Ocorrido.',
                    onSaved: (dynamic data) {
                      if (data != null) _dataRequest = _dataRequest.copyWith(dataTipo: data['id']);
                    },
                    onChanged: (dynamic data) {
                      if (data != null) _controller.setVisibilityOcorrido(data['id']);
                    },
                    showSearchBox: false,
                    mode: ModeEnum.MENU,
                    enabled: !_controller.loadingSave.value,
                  );
                }),
                SizedBox(height: 10.hEx),
                Obx(() {
                  return Visibility(
                    visible: _controller.visibilityDateOcorrido.value,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppDateTime(
                            key: ValueKey(_initialDateOcorridoDe),
                            padding: const EdgeInsets.all(0),
                            controller: _dateOcorridoDeEC,
                            label: 'De:'.tr,
                            hintText: 'Selecione uma data'.tr,
                            enabled: true,
                            initialValue: _initialDateOcorridoDe,
                            timer: false,
                            allowAfter: false,
                            onSaved: (DateTime? data) {
                              if (data != null) _dataRequest = _dataRequest.copyWith(dataInicioOcorrido: FormatsDatetime.formatDate(data, FormatsDatetime.yearMonthDay));
                            },
                            validator: (DateTime? data) {
                              if (data != null) return null;
                              return 'requiredField'.tr;
                            },
                          ),
                        ),
                        SizedBox(width: 5.wEx),
                        Expanded(
                          child: AppDateTime(
                            key: ValueKey(_initialDateOcorridoAte),
                            padding: const EdgeInsets.all(0),
                            controller: _dateOcorridoAteEC,
                            label: 'Até:'.tr,
                            hintText: 'Selecione uma data'.tr,
                            enabled: true,
                            initialValue: _initialDateOcorridoAte,
                            timer: false,
                            allowAfter: false,
                            onSaved: (DateTime? data) {
                              if (data != null) _dataRequest = _dataRequest.copyWith(dataFimOcorrido: FormatsDatetime.formatDate(data, FormatsDatetime.yearMonthDay));
                            },
                            validator: (DateTime? data) {
                              if (data != null) return null;
                              return 'requiredField'.tr;
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: 10.hEx),
                Row(
                  children: [
                    Obx(() {
                      return Expanded(
                        child: AppButton(
                          minWidth: MediaQuery.of(context).size.width,
                          colorBackground: ConstColors.blue,
                          onPressed: _controller.loadingSave.value
                              ? null
                              : () async {
                                  var formValid = _formKey.currentState?.validate() ?? false;
                                  if (formValid) {
                                    _formKey.currentState?.save();
                                    if (!_edit!) {
                                      await _controller.saveAllergy(_dataRequest, _params);
                                    } else {
                                      await _controller.updateAllergy(_dataRequest, _params, _allergy!.id!);
                                    }
                                  }
                                },
                          childRaisedButton: RenderWhen(
                            text: _edit! ? 'salvar' : 'incluir'.toUpperCase().tr,
                            isLoading: _controller.loadingSave.value,
                          ),
                        ),
                      );
                    }),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
