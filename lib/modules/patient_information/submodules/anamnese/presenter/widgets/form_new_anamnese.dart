import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/mixin/basic_page_mixin.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/packages/dropdown_search_package/app_dropdown_widget_search_impl.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/validators/app_validators.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/form/app_button_simple.dart';
import 'package:medicinadireta/core/widgets/form/app_date_time_field.dart';
import 'package:medicinadireta/core/widgets/form/app_text_field.dart';
import 'package:medicinadireta/core/widgets/form/render_when.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/request_new_anamnese.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/infra/models/anamnese_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/presenter/controller/anamnese_controller.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class FormNewAnamnese extends BasePage {
  final String title;
  final bool? edit;
  final AnamneseExt? itemAnamnese;
  final AnamneseController controller;
  final ParamsToNavigationPage params;
  FormNewAnamnese({Key? key, required this.controller, required this.params, this.edit = false, this.itemAnamnese, required this.title}) : super(key: key);

  @override
  _FormNewAnamneseState createState() => _FormNewAnamneseState();
}

class _FormNewAnamneseState extends BaseState<FormNewAnamnese> with WidgetsBindingObserver, BasicPage {
  String get _title => widget.title;
  bool? get _edit => widget.edit ?? false;
  AnamneseExt? get _item => widget.itemAnamnese;
  AnamneseController get _controller => widget.controller;
  ParamsToNavigationPage get _params => widget.params;
  final _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _bloco0EC = TextEditingController();
  final TextEditingController _bloco1EC = TextEditingController();
  final TextEditingController _bloco2EC = TextEditingController();
  final TextEditingController _bloco3EC = TextEditingController();
  final TextEditingController _bloco4EC = TextEditingController();
  final TextEditingController _bloco5EC = TextEditingController();
  final TextEditingController _bloco6EC = TextEditingController();
  final TextEditingController _bloco7EC = TextEditingController();
  final TextEditingController _bloco8EC = TextEditingController();

  DateTime? _initialValue;
  String? _selectedItemCID;
  String? _selectedItemCIAP;

  var _request = RequestNewAnamnese();

  _fillDataForm() {
    _controller.itemOption.value = '--';
    if (_edit != null && _edit == true) {
      if (_item?.motivoAtendimento?.isNotEmpty ?? false) _bloco1EC.text = _item?.motivoAtendimento ?? '';
      if (_item?.descricaoHda?.isNotEmpty ?? false) _bloco2EC.text = _item?.descricaoHda ?? '';
      if (_item?.descricaoHpp?.isNotEmpty ?? false) _bloco3EC.text = _item?.descricaoHpp ?? '';
      if (_item?.descricaoHabito?.isNotEmpty ?? false) _bloco4EC.text = _item?.descricaoHabito ?? '';
      if (_item?.descricaoVicio?.isNotEmpty ?? false) _bloco5EC.text = _item?.descricaoVicio ?? '';
      if (_item?.historicoMental?.isNotEmpty ?? false) _bloco6EC.text = _item?.historicoMental ?? '';
      if (_item?.historicoFamiliar?.isNotEmpty ?? false) _bloco7EC.text = _item?.historicoFamiliar ?? '';
      if (_item?.outros?.isNotEmpty ?? false) _bloco8EC.text = _item?.outros ?? '';

      if (_item?.dataEvento?.isNotEmpty ?? false) {
        var _date = DateTime.parse(_item?.dataEvento?.toString() ?? DateTime.now().toString());
        _bloco0EC.text = FormatsDatetime.formatDate(_date, FormatsDatetime.dateHourFormat);
        _initialValue = _date;
      }
    } else {
      _bloco0EC.text = FormatsDatetime.formatDate(DateTime.now(), FormatsDatetime.dateHourFormat);
      _initialValue = DateTime.now();
      _request = _request.copyWith(dataEvento: _initialValue.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fillDataForm();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _bloco0EC.dispose();
    _bloco1EC.dispose();
    _bloco2EC.dispose();
    _bloco3EC.dispose();
    _bloco4EC.dispose();
    _bloco5EC.dispose();
    _bloco6EC.dispose();
    _bloco7EC.dispose();
    _bloco8EC.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  String screenName() => _title;

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  AppBottomNavigationBar? bottomNavigationBar() => AppBottomNavigationBar();

  @override
  Function()? onPressedLeading() => () => Get.toNamed(Routes.ANAMNESE, arguments: _params);

  @override
  ParamsToNavigationPage? screenCardPatient() => null;

  @override
  List<Widget>? actions() => [
        IconButton(
          onPressed: () => ShowDialogItemForm.showDialogForm(context, _controller),
          icon: Icon(Icons.list_alt_outlined),
          tooltip: "Desativar campos",
        ),
      ];

  @override
  Widget? floatingActionButton() => null;

  @override
  Widget body() => _body();

  Widget _body() {
    var _vertical = 5.0;
    var _minLines = 2;
    var _maxLines = 200;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ResponsiveBuilder(builder: (context, view) {
        return CupertinoScrollbar(
          thumbVisibility: false,
          controller: _scrollController,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerLeft,
                  child: Text("Tipo de classificação ou terminologia"),
                ),
                Obx(() {
                  return Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                        child: Container(
                          width: 90.0,
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1.0, color: ConstColors.blue.withOpacity(0.5))),
                          ),
                          child: DropdownButton<String>(
                            onChanged: (data) {
                              if (data != null) {
                                _controller.changeOptions(data);
                                if (data != _controller.listOptions[0]) {
                                  _request = _request.copyWith(terminologiaQueixaPrincipal: data.replaceAll("-", ""));
                                } else {
                                  _request = _request.copyWith(terminologiaQueixaPrincipal: "", motivoAtendimento: "");
                                }
                              }
                            },
                            value: _controller.itemOption.value,
                            underline: Container(),
                            hint: Text('Selecione', style: Theme.of(context).textTheme.subtitle2),
                            icon: Icon(Icons.expand_more_outlined, color: ConstColors.blue),
                            isExpanded: true,
                            items: _controller.listOptions
                                .map((e) => DropdownMenuItem(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(e, style: Theme.of(context).textTheme.subtitle2),
                                    ),
                                    value: e))
                                .toList(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Visibility(
                        visible: _controller.itemOption.value == _controller.listOptions[1],
                        child: Expanded(
                          child: AppDropdownWidgetSearchImpl(
                            items: _controller.listItensCiap.map((e) => e.titulo).toList(),
                            selectedItem: _selectedItemCIAP,
                            onChanged: (dynamic _filter) {
                              if (_filter != null) _bloco1EC.text = _bloco1EC.text + "\n$_filter";
                            },
                            hintText: _controller.listOptions[1],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _controller.itemOption.value == _controller.listOptions[2],
                        child: Expanded(
                          child: AppDropdownWidgetSearchImpl(
                            items: _controller.listItensCidSubCategory.map((e) => e.descricao).toList(),
                            selectedItem: _selectedItemCID,
                            onChanged: (dynamic _filter) {
                              if (_filter != null) _bloco1EC.text = _bloco1EC.text + "\n$_filter";
                            },
                            hintText: _controller.listOptions[2],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppDateTime(
                            key: ValueKey(_initialValue),
                            padding: EdgeInsets.symmetric(vertical: _vertical),
                            controller: _bloco0EC,
                            hintText: 'Data do evento'.tr,
                            label: 'Data do evento'.tr,
                            enabled: true,
                            initialValue: _initialValue,
                            timer: true,
                            allowAfter: false,
                            onSaved: (DateTime? data) {
                              if (data != null) {
                                _request = _request.copyWith(dataEvento: data.toString());
                                _request = _request.copyWith(utcEvento: data.toUtc().toString());
                              }
                            },
                            validator: (DateTime? _data) {
                              if (_data != null) return null;
                              return 'requiredField'.tr;
                            },
                          ),
                          AppTextField(
                            padding: EdgeInsets.symmetric(vertical: _vertical),
                            controller: _bloco1EC,
                            maxLines: _maxLines,
                            minLines: _minLines,
                            labelText: 'Queixa ou motivo do atendimento'.tr,
                            hintText: 'Queixa ou motivo do atendimento'.tr,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            enabled: true,
                            onSaved: (data) {
                              if (data != null && data.isNotEmpty) _request = _request.copyWith(motivoAtendimento: data);
                            },
                            validator: AppValidators.min(6, 'Informe um pouco mais de detalhes sobre o registro.'),
                            textCapitalization: TextCapitalization.sentences,
                          ),
                          Obx(() {
                            return Visibility(
                              visible: _controller.fieldsForm[0]["visible"],
                              child: AppTextField(
                                padding: EdgeInsets.symmetric(vertical: _vertical),
                                controller: _bloco2EC,
                                maxLines: _maxLines,
                                minLines: _minLines,
                                hintText: _controller.fieldsForm[0]["value"],
                                labelText: _controller.fieldsForm[0]["value"],
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                enabled: true,
                                onSaved: (data) {
                                  if (data != null && data.isNotEmpty) _request = _request.copyWith(descricaoHda: data);
                                },
                                validator: AppValidators.min(6, 'Informe um pouco mais de detalhes sobre o registro.'),
                                textCapitalization: TextCapitalization.words,
                              ),
                            );
                          }),
                          Obx(() {
                            return Visibility(
                              visible: _controller.fieldsForm[1]["visible"],
                              child: AppTextField(
                                padding: EdgeInsets.symmetric(vertical: _vertical),
                                controller: _bloco3EC,
                                maxLines: _maxLines,
                                minLines: _minLines,
                                hintText: _controller.fieldsForm[1]["value"],
                                labelText: _controller.fieldsForm[1]["value"],
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                enabled: true,
                                onSaved: (data) {
                                  if (data != null && data.isNotEmpty) _request = _request.copyWith(descricaoHpp: data);
                                },
                                validator: AppValidators.min(6, 'Informe um pouco mais de detalhes sobre o registro.'),
                                textCapitalization: TextCapitalization.words,
                              ),
                            );
                          }),
                          Obx(() {
                            return Visibility(
                              visible: _controller.fieldsForm[2]["visible"],
                              child: AppTextField(
                                padding: EdgeInsets.symmetric(vertical: _vertical),
                                controller: _bloco4EC,
                                maxLines: _maxLines,
                                minLines: _minLines,
                                hintText: _controller.fieldsForm[2]["value"],
                                labelText: _controller.fieldsForm[2]["value"],
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                enabled: true,
                                onSaved: (data) {
                                  if (data != null && data.isNotEmpty) _request = _request.copyWith(descricaoHabito: data);
                                },
                                validator: AppValidators.min(6, 'Informe um pouco mais de detalhes sobre o registro.'),
                                textCapitalization: TextCapitalization.words,
                              ),
                            );
                          }),
                          Obx(() {
                            return Visibility(
                              visible: _controller.fieldsForm[3]["visible"],
                              child: AppTextField(
                                padding: EdgeInsets.symmetric(vertical: _vertical),
                                controller: _bloco5EC,
                                maxLines: _maxLines,
                                minLines: _minLines,
                                hintText: _controller.fieldsForm[3]["value"],
                                labelText: _controller.fieldsForm[3]["value"],
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                enabled: true,
                                onSaved: (data) {
                                  if (data != null && data.isNotEmpty) _request = _request.copyWith(descricaoVicio: data);
                                },
                                validator: AppValidators.min(6, 'Informe um pouco mais de detalhes sobre o registro.'),
                                textCapitalization: TextCapitalization.words,
                              ),
                            );
                          }),
                          Obx(() {
                            return Visibility(
                              visible: _controller.fieldsForm[4]["visible"],
                              child: AppTextField(
                                padding: EdgeInsets.symmetric(vertical: _vertical),
                                controller: _bloco6EC,
                                maxLines: _maxLines,
                                minLines: _minLines,
                                hintText: _controller.fieldsForm[4]["value"],
                                labelText: _controller.fieldsForm[4]["value"],
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                enabled: true,
                                onSaved: (data) {
                                  if (data != null && data.isNotEmpty) _request = _request.copyWith(historicoMental: data);
                                },
                                validator: AppValidators.min(6, 'Informe um pouco mais de detalhes sobre o registro.'),
                                textCapitalization: TextCapitalization.words,
                              ),
                            );
                          }),
                          Obx(() {
                            return Visibility(
                              visible: _controller.fieldsForm[5]["visible"],
                              child: AppTextField(
                                padding: EdgeInsets.symmetric(vertical: _vertical),
                                controller: _bloco7EC,
                                maxLines: _maxLines,
                                minLines: _minLines,
                                hintText: _controller.fieldsForm[5]["value"],
                                labelText: _controller.fieldsForm[5]["value"],
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                enabled: true,
                                onSaved: (data) {
                                  if (data != null && data.isNotEmpty) _request = _request.copyWith(historicoFamiliar: data);
                                },
                                validator: AppValidators.min(6, 'Informe um pouco mais de detalhes sobre o registro.'),
                                textCapitalization: TextCapitalization.words,
                              ),
                            );
                          }),
                          Obx(() {
                            return Visibility(
                              visible: _controller.fieldsForm[6]["visible"],
                              child: AppTextField(
                                padding: EdgeInsets.symmetric(vertical: _vertical),
                                controller: _bloco8EC,
                                maxLines: _maxLines,
                                minLines: _minLines,
                                hintText: _controller.fieldsForm[6]["value"],
                                labelText: _controller.fieldsForm[6]["value"],
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                enabled: true,
                                onSaved: (data) {
                                  if (data != null && data.isNotEmpty) _request = _request.copyWith(outros: data);
                                },
                                validator: AppValidators.min(6, 'Informe um pouco mais de detalhes sobre o registro.'),
                                textCapitalization: TextCapitalization.words,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Obx(() {
                    return AppButton(
                      minWidth: MediaQuery.of(context).size.width,
                      colorBackground: ConstColors.blue,
                      onPressed: _controller.loadingSaving.value
                          ? null
                          : () async {
                              var formValid = _formKey.currentState?.validate() ?? false;
                              if (formValid) {
                                _formKey.currentState?.save();
                                await _controller.saveAnamnese(
                                  pacientId: _params.pacienteId,
                                  params: _params,
                                  requestData: _request,
                                  edit: _edit,
                                  anamneseId: _item?.id ?? null,
                                );
                              }
                            },
                      childRaisedButton: RenderWhen(
                        text: (_edit != null && _edit == true) ? "Salvar".tr : 'Incluir'.tr,
                        isLoading: _controller.loadingSaving.value,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ShowDialogItemForm {
  ShowDialogItemForm._();

  static showDialogForm(BuildContext context, AnamneseController controller) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Selecione uma categoria".toUpperCase(), style: Theme.of(context).textTheme.subtitle2?.copyWith(color: ConstColors.orange, fontWeight: FontWeight.w500)),
          content: Obx(() {
            return Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        var _decode = controller.fieldsForm[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: _decode["visible"] ? Icon(Icons.check_box_outlined, color: ConstColors.blue) : Icon(Icons.check_box_outline_blank_outlined, color: ConstColors.grey),
                          title: Text(_decode['value'], style: Theme.of(context).textTheme.subtitle2),
                          onTap: () => controller.changeStateVisibleFields(index),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(height: 0.4),
                      itemCount: controller.fieldsForm.length,
                    ),
                  ),
                ],
              ),
            );
          }),
          actions: [
            AppButtonSimple(onPressed: () => Navigator.pop(context), backgroundColor: Color(0xff002d72), child: Text("close".tr)),
          ],
        );
      },
    );
  }
}
