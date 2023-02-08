import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:medicinadireta/core/mixin/basic_page_mixin.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/request_new_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/evolution_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/presenter/controller/form_evolution_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class WidgetEditorHtml extends BasePage {
  final bool editForm;
  final RequestNewEvolution modelRequest;
  final FormEvolutionController controller;
  final ParamsToNavigationPage arguments;
  final EvolutionExt? itemModel;

  WidgetEditorHtml({
    Key? key,
    required this.controller,
    required this.editForm,
    required this.modelRequest,
    required this.arguments,
    this.itemModel,
  }) : super(key: key);

  @override
  _WidgetEditorHtmlState createState() => _WidgetEditorHtmlState();
}

class _WidgetEditorHtmlState extends BaseState<WidgetEditorHtml> with WidgetsBindingObserver, BasicPage {
  HtmlEditorController controllerHTML = HtmlEditorController();

  bool get _edit => widget.editForm;
  RequestNewEvolution get _modelRequest => widget.modelRequest;
  FormEvolutionController get _controller => widget.controller;
  ParamsToNavigationPage get _arguments => widget.arguments;
  EvolutionExt? get _item => widget.itemModel;

  @override
  String screenName() => '';

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  AppBottomNavigationBar? bottomNavigationBar() => null;

  @override
  Function()? onPressedLeading() => () async => await _dataContent();

  @override
  ParamsToNavigationPage? screenCardPatient() => null;

  _dataContent() async {
    String? _html = await controllerHTML.getText();
    _controller.dataHtml.value = _html;
    if (_html.isEmpty || _html == '') {
      Navigator.pop(context);
      return;
    }
    var _request = _modelRequest;
    _request = _request.copyWith(historico: _html);
    if (_request.historico == null || _request.historico == '') {
      AppAlert.alertWarning(title: 'Oops!', body: 'Motivo da evolução obrigatório', seconds: 10);
      return;
    }
    if (_edit == true) {
      await _controller.updateNewEvolution(evolutionId: _item!.id!, params: _arguments, requestForm: _request, localAgenda: _item?.localAgenda ?? "--");
    } else {
      await _controller.saveNewEvolution(_arguments, _request);
    }
  }

  @override
  List<Widget>? actions() => [
        Obx(() {
          return TextButton.icon(
              onPressed: _controller.loadingSaving.value ? null : () async => await _dataContent(),
              icon: _controller.loadingSaving.value ? CupertinoActivityIndicator() : Icon(Icons.save_outlined, color: ConstColors.blue, size: 24),
              label: Text(
                'Fechar Edição'.tr.toUpperCase(),
                style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold, fontSize: 11.spEx),
              ));
        }),
        // TextButton.icon(
        //     onPressed: () async => await _dataContent(),
        //     icon: Icon(Icons.edit, color: ConstColors.blue, size: 24),
        //     label: Text(
        //       'fechar'.tr.toUpperCase(),
        //       style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold, fontSize: 11.spEx),
        //     )),
      ];

  @override
  Widget? floatingActionButton() => null;

  @override
  Widget body() {
    return _body();
  }

  Widget _body() {
    return ResponsiveBuilder(builder: (context, view) {
      return Column(
        children: [
          // Container(
          //   width: view.localWidgetSize?.width,
          //   padding: const EdgeInsets.all(8),
          //   alignment: Alignment.center,
          //   decoration: BoxDecoration(color: Color(0xFFE5EEFC), borderRadius: BorderRadius.circular(2)),
          //   child: Text(
          //     'Salve as informações editadas na tela anterior.',
          //     style: GoogleFonts.openSans(fontSize: 13.spEx, color: ConstColors.blue, fontWeight: FontWeight.w600),
          //   ),
          // ),
          // Divider(),
          Expanded(
            child: Obx(() {
              return Container(
                key: ValueKey(_controller.keyRunnerEditor.value),
                child: HtmlEditor(
                  controller: controllerHTML,
                  htmlToolbarOptions: HtmlToolbarOptions(
                    defaultToolbarButtons: [
                      //  StyleButtons(),
                      FontSettingButtons(fontName: false, fontSize: true, fontSizeUnit: false),
                      FontButtons(clearAll: false, subscript: false, superscript: false),
                      ColorButtons(),
                      ListButtons(listStyles: false),
                      ParagraphButtons(textDirection: false, lineHeight: false, caseConverter: false, increaseIndent: false, decreaseIndent: false),
                      InsertButtons(video: false, audio: false, table: false, hr: true, otherFile: false, link: false, picture: false),
                    ],
                    toolbarPosition: ToolbarPosition.aboveEditor,
                    toolbarType: ToolbarType.nativeGrid,
                  ),
                  htmlEditorOptions: HtmlEditorOptions(
                    hint: "Informe o motivo da evolução",
                    initialText: _controller.dataHtml.value,
                    shouldEnsureVisible: true,
                    autoAdjustHeight: true,
                    adjustHeightForKeyboard: true,
                  ),
                  otherOptions: OtherOptions(
                    height: view.localWidgetSize?.height ?? 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      border: Border.fromBorderSide(
                        BorderSide(color: ConstColors.border, width: 1),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      );
    });
  }
}
