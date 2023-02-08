import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:medicinadireta/core/mixin/basic_page_mixin.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/navigator_app/navigator_app.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/validators/app_validators.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/packages/dropdown_search_package/app_dropdown_widget_search_impl.dart';
import 'package:medicinadireta/core/widgets/app_html.dart';
import 'package:medicinadireta/core/widgets/form/app_text_field.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/request_new_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/evolution_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/presenter/controller/form_evolution_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/presenter/widgets/widget_editor_html.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FormEvolution extends BasePage {
  final bool editForm;
  final ParamsToNavigationPage arguments;
  final EvolutionExt? itemModel;
  final FormEvolutionController controller;

  FormEvolution({
    Key? key,
    this.editForm = false,
    required this.arguments,
    required this.controller,
    this.itemModel,
  }) : super(key: key);

  @override
  _FormEvolutionState createState() => _FormEvolutionState();
}

class _FormEvolutionState extends BaseState<FormEvolution> with WidgetsBindingObserver, BasicPage {
  final ScrollController _scrollControllerEditor = ScrollController();
  bool get _edit => widget.editForm;
  FormEvolutionController get _controller => widget.controller;
  ParamsToNavigationPage get _arguments => widget.arguments;
  EvolutionExt? get _item => widget.itemModel;

  final _scrollController = ScrollController();
  var _request = RequestNewEvolution();
  final _formKey = GlobalKey<FormState>();

  String? _initialDiagnosis;
  String? _initialModel;
  final _commetsEC = TextEditingController();

  _isEdit() async {
    await 0.2.delay();
    if (_edit == true) {
      bool _isHTML = _item?.tipoEditor == "H";
      bool _isNotEmpty = _item?.historico?.isNotEmpty ?? false;
      if (_isNotEmpty && !_isHTML) _commetsEC.text = _item?.historico ?? '--';
      if (_isNotEmpty && _isHTML) {
        _controller.keyRunnerEditor.value = DateTime.now().millisecondsSinceEpoch;
        _controller.dataHtml.value = _item?.historico ?? '';
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.dataHtml.value = '';
      // _controller.tipoEvolucao.value = false;
      _controller.isTipoEvolucao();
      _isEdit();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _commetsEC.dispose();
    _initialDiagnosis = null;
    _initialModel = null;
    _scrollControllerEditor.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  String screenName() => 'evolution';

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  AppBottomNavigationBar? bottomNavigationBar() => AppBottomNavigationBar();

  @override
  Function()? onPressedLeading() => () => Get.toNamed(Routes.EVOLUTION, arguments: _arguments);

  @override
  ParamsToNavigationPage? screenCardPatient() => null;

  @override
  List<Widget>? actions() => [
        Obx(() {
          bool _isHTML = _item?.tipoEditor == "H";
          return TextButton.icon(
              onPressed: _controller.loadingSaving.value
                  ? null
                  : () async {
                      var formValid = _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        _formKey.currentState?.save();
                        if (_controller.tipoEvolucao.value || _isHTML) {
                          _request = _request.copyWith(historico: _controller.dataHtml.value);
                        }
                        if (_request.historico == null || _request.historico == '') {
                          AppAlert.alertWarning(title: 'Oops!', body: 'Preencha o campo descrição', seconds: 10);
                          return;
                        }
                        if (_edit == true) {
                          await _controller.updateNewEvolution(evolutionId: _item!.id!, params: _arguments, requestForm: _request, localAgenda: _item?.localAgenda ?? "--");
                        } else {
                          await _controller.saveNewEvolution(_arguments, _request);
                        }
                      }
                    },
              icon: _controller.loadingSaving.value ? CupertinoActivityIndicator() : Icon(Icons.save_outlined, color: ConstColors.blue, size: 24),
              label: Text(
                (_edit == true) ? "Salvar".tr.toUpperCase() : 'Incluir'.tr.toUpperCase(),
                style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold, fontSize: 11.spEx),
              ));
        }),
      ];

  @override
  Widget? floatingActionButton() => null;

  @override
  Widget body() => _body();

  Widget _body() {
    bool _isHTML = _item?.tipoEditor == "H";
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ResponsiveBuilder(builder: (context, view) {
        return CupertinoScrollbar(
          thumbVisibility: false,
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppDropdownWidgetSearchImpl(
                          items: _controller.productsMap.map((e) => _controller.labelPatientProducts(e)).toList(),
                          selectedItem: _initialDiagnosis,
                          onSaved: (dynamic filter) {
                            if (filter != null) {
                              var _model = _controller.productsMap.firstWhere((e) => _controller.labelPatientProducts(e).toLowerCase() == filter?.toLowerCase());
                              _request = _request.copyWith(tuss: _model.id.toString(), tussDescricao: _controller.labelPatientProducts(_model));
                            }
                          },
                          labelText: 'diagnosis'.tr.toUpperCase(),
                          hintText: 'diagnosis'.tr.toUpperCase(),
                        ),
                        const SizedBox(height: 10),
                        AppDropdownWidgetSearchImpl(
                          items: _controller.productsModelMap.map((e) => e.titulo?.toUpperCase()).toList(),
                          selectedItem: _initialModel,
                          onChanged: (dynamic filter) async {
                            if (filter != null) {
                              var _model = _controller.productsModelMap.firstWhere((e) => e.titulo?.toLowerCase() == filter?.toLowerCase());
                              bool _isNotEmpty = _model.comentario?.isNotEmpty ?? false;
                              if (_isNotEmpty && !_isHTML) _commetsEC.text = "${_commetsEC.text}\n<p>${_model.comentario}</p>";
                              if (_isNotEmpty && _isHTML) {
                                _controller.dataHtml.value = "${_controller.dataHtml.value}\n<p>${_model.comentario}</p>";
                                _controller.keyRunnerEditor.value = DateTime.now().millisecondsSinceEpoch;
                                setState(() {});
                              }

                              if (!_edit && _controller.tipoEvolucao.value) {
                                _controller.dataHtml.value = "${_controller.dataHtml.value}\n<p>${_model.comentario}</p>";
                                _controller.keyRunnerEditor.value = DateTime.now().millisecondsSinceEpoch;
                                setState(() {});
                              }
                            }
                          },
                          onSaved: (dynamic filter) {
                            if (filter != null) {
                              var _model = _controller.productsModelMap.firstWhere((e) => e.titulo?.toLowerCase() == filter?.toLowerCase());
                              _request = _request.copyWith(historico: _model.comentario);
                            }
                          },
                          labelText: 'model'.tr.toUpperCase(),
                          hintText: 'model'.tr.toUpperCase(),
                        ),
                        const SizedBox(height: 10),
                        Obx(() {
                          return Visibility(
                            visible: _controller.tipoEvolucao.value || _isHTML,
                            child: InkWell(
                              onTap: () =>
                                  NavigatorApp.openMyPage(context, WidgetEditorHtml(controller: _controller, editForm: _edit, modelRequest: _request, itemModel: _item, arguments: _arguments)),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: view.localWidgetSize?.width,
                                      constraints: BoxConstraints(minHeight: 100.hEx),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 12),
                                            child: Text(
                                              'descrição'.tr.toUpperCase(),
                                              style: GoogleFonts.openSans(fontSize: 9.spEx, color: ConstColors.blue, fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          Obx(() {
                                            if (_controller.dataHtml.value == '') {
                                              return Container(
                                                padding: EdgeInsets.symmetric(horizontal: 12),
                                                child: Text(
                                                  'Informe o motivo da evolução'.toUpperCase(),
                                                  style: GoogleFonts.openSans(fontSize: 11.spEx, color: ConstColors.grey, fontWeight: FontWeight.w400),
                                                ),
                                              );
                                            }
                                            return Container(
                                              padding: EdgeInsets.symmetric(horizontal: 5),
                                              child: AppHtml(
                                                key: ValueKey(_controller.keyRunnerEditor.value),
                                                onData: _controller.dataHtml.value,
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 10),
                        Obx(() {
                          return Visibility(
                            visible: !_controller.tipoEvolucao.value && !_isHTML,
                            child: AppTextField(
                              controller: _commetsEC,
                              maxLines: 200,
                              minLines: 5,
                              labelText: 'evolution_description'.tr,
                              hintText: 'evolution_description'.tr,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              enabled: true,
                              onSaved: (data) {
                                if (data != null && data.isNotEmpty) _request = _request.copyWith(historico: data);
                              },
                              validator: AppValidators.multiple([
                                AppValidators.required(),
                                AppValidators.min(6, 'Informe um pouco mais de detalhes sobre o registro.'),
                              ]),
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
