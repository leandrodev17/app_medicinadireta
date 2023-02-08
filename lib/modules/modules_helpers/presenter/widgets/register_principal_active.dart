import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/constants/const_strings.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:medicinadireta/core/packages/dropdown_search_package/app_dropdown_widget_search_impl.dart';
import 'package:medicinadireta/core/validators/app_validators.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/form/app_text_field.dart';
import 'package:medicinadireta/core/widgets/form/render_when.dart';
import 'package:medicinadireta/core/widgets/form/text_form_field_simple.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/controller/medical_controller.dart';
import 'package:medicinadireta/modules/modules_helpers/presenter/widgets/search_principal_active_server.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/principal_active_ext.dart';
import 'package:medicinadireta/routes/app_pages.dart';

import '/core/mixin/basic_page_mixin.dart';
import '/core/models/params/params_to_navigation_page.dart';
import '/core/responsive/responsive_builder.dart';
import '/core/widgets/app_bottom_navigator.dart';

class SearchPrincipalActive extends BasePage {
  SearchPrincipalActive({Key? key}) : super(key: key);

  @override
  SearchPrincipalActiveState createState() => SearchPrincipalActiveState();
}

class SearchPrincipalActiveState extends BaseState<SearchPrincipalActive> with WidgetsBindingObserver, BasicPage {
  final MedicalController _controller = Get.find<MedicalController>();
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 300));
  var _dataRequest = const PrincipalActiveExt();
  final _formKey = GlobalKey<FormState>();

  final _concentrationEC = TextEditingController();
  final _searchControllerEC = TextEditingController();
  Map<String, dynamic>? _selectedItemStatus = {"id": "A", "value": "ATIVO"};
  Map<String, dynamic>? _selectedItemListaUnitOfMeasurement;
  String? _selectedItemPrincipalActive;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.listRequestPrincipalActive.clear();
      _controller.isSavePrincipalActive.value = false;
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    _debouncer.cancel();
    _concentrationEC.dispose();
    _searchControllerEC.dispose();
    // _controller.searchPrincipalActiveServerEC.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  String screenName() => 'Principio Ativo';

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  AppBottomNavigationBar? bottomNavigationBar() => AppBottomNavigationBar();

  @override
  Function()? onPressedLeading() => () => Get.back();

  @override
  ParamsToNavigationPage? screenCardPatient() => null;

  @override
  List<Widget>? actions() => [
        // IconButton(onPressed: () async => await _controller.showPrincipalActive(), icon: const Icon(Icons.refresh)),
      ];

  @override
  Widget? floatingActionButton() => null;

  @override
  Widget body() => _body();

  Widget _body() {
    return ResponsiveBuilder(builder: (context, view) {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            // AppDropdownWidgetSearchImpl(
            //   items: _controller.listPrincipalActive,
            //   selectedItem: _selectedItemPrincipalActive,
            //   searchControllerEC: _searchControllerEC,
            //   labelText: 'Principio Ativo',
            //   hintText: 'Selecione um.',
            //   validator: (dynamic data) {
            //     if (data != null && data != '') return null;
            //     return 'Campo obrigatório';
            //   },
            //   onSaved: (dynamic data) {
            //     if (data != null) _dataRequest = _dataRequest.copyWith(principioAtivo: data);
            //   },
            //   enabled: !_controller.isLoadingSaveNewMedical.value,
            // ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => SearchPrincipalActiveServer(),
                  fullscreenDialog: true,
                ),
              ),
              child: Obx(() {
                return TextFormFieldSimple(
                  key: ValueKey(_controller.valueKeyPrincipalActiveServer.value),
                  controller: _controller.searchPrincipalActiveServerEC,
                  fieldRequired: true,
                  labelText: 'Principio Ativo',
                  hintText: 'Escreva 4 (quatro) ou mais caracteres.'.tr,
                  enabled: false,
                  validator: AppValidators.required(m: 'Campo obrigatório'),
                  onSaved: (String? data) {
                    if (data != null) _dataRequest = _dataRequest.copyWith(principioAtivo: data);
                  },
                );
              }),
            ),
            SizedBox(height: 10.hEx),
            AppTextField(
              controller: _concentrationEC,
              labelText: 'Concentração'.tr,
              hintText: 'Escreva aqui.'.tr,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              maxLength: 20,
              fieldRequired: true,
              textCapitalization: TextCapitalization.sentences,
              validator: AppValidators.multiple([
                AppValidators.required(),
              ]),
              onSaved: (data) {
                if (data != null) _dataRequest = _dataRequest.copyWith(concentracao: int.parse(data.toString()));
              },
            ),
            SizedBox(height: 10.hEx),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: AppDropdownWidgetSearchImpl(
                    items: ConstStrings.listaUnitOfMeasurement,
                    selectedItem: _selectedItemListaUnitOfMeasurement,
                    labelText: 'Unidade de medida',
                    hintText: 'Selecione um.',
                    fieldRequired: true,
                    itemAsString: (dynamic value) => value['value'].toString(),
                    validator: (dynamic data) {
                      if (data != null && data != '') return null;
                      return 'Campo obrigatório';
                    },
                    onSaved: (dynamic data) {
                      if (data != null) _dataRequest = _dataRequest.copyWith(unidadeMedida: data['id']);
                    },
                  ),
                ),
                SizedBox(width: 5.hEx),
                Expanded(
                  child: AppDropdownWidgetSearchImpl(
                    items: ConstStrings.listStatus,
                    selectedItem: _selectedItemStatus,
                    labelText: 'Status',
                    hintText: 'Selecione',
                    itemAsString: (dynamic value) => value['value'].toString(),
                    validator: (dynamic data) {
                      if (data != null && data != '') return null;
                      return 'Campo obrigatório';
                    },
                    onSaved: (dynamic data) {
                      if (data != null) _dataRequest = _dataRequest.copyWith(status: data['id']);
                    },
                  ),
                ),
              ],
            ),
            // SizedBox(height: 10.hEx),
            const Spacer(),
            Row(
              children: [
                Obx(() {
                  return Expanded(
                    child: AppButton(
                      minWidth: MediaQuery.of(context).size.width,
                      colorBackground: ConstColors.blue,
                      onPressed: _controller.isSavePrincipalActive.value
                          ? null
                          : () async {
                              var formValid = _formKey.currentState?.validate() ?? false;
                              if (formValid) {
                                _formKey.currentState?.save();
                                AppLog.w("_dataRequest ${_dataRequest.toMap()}", name: "_dataRequest");
                                await _controller.savePrincipalActive(_dataRequest);
                                // _controller.addItemRequestPrincipalActive(_dataRequest);
                              }
                            },
                      childRaisedButton: RenderWhen(
                        text: 'Associar Principio Ativo',
                        isLoading: _controller.isSavePrincipalActive.value,
                      ),
                    ),
                  );
                }),
              ],
            ),
            // SizedBox(height: 10.hEx),
            // Expanded(
            //   child: Obx(() {
            //     return ListView.builder(
            //       itemBuilder: (BuildContext context, int index) {
            //         PrincipalActiveExt item = _controller.listRequestPrincipalActive[index];
            //         String concentracao = "${item.concentracao} ${item.unidadeMedida}";
            //         String status = item.status == "A" ? "ATIVO" : "INATIVO";
            //         return Container(
            //           margin: const EdgeInsets.symmetric(vertical: 5),
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             border: Border.all(width: 2.0, color: ConstColors.ff5897F5),
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //           child: ListTile(
            //             title: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Text(
            //                       status,
            //                       style: GoogleFonts.openSans(fontSize: 14.0, color: ConstColors.ff5897F5, fontWeight: FontWeight.w700),
            //                     ),
            //                     Obx(() {
            //                       if (_controller.isSavePrincipalActive.value == index) {
            //                         return  Container(
            //                         padding: const EdgeInsets.all(17),
            //                         child:  const CupertinoActivityIndicator());
            //                       }
            //                       return Row(
            //                         children: [
            //                           IconButton(
            //                             onPressed: () async => await _controller.savePrincipalActive(item, index),
            //                             icon: const Icon(Icons.add_task, color: ConstColors.ff5897F5),
            //                           ),
            //                           IconButton(
            //                             onPressed: () => _controller.removeItemRequestPrincipalActive(item),
            //                             icon: const Icon(Icons.delete, color: ConstColors.danger),
            //                           ),
            //                         ],
            //                       );
            //                     }),
            //                   ],
            //                 ),
            //                 itemWidget('Princípio Ativo', item.principioAtivo.toString()),
            //                 SizedBox(height: 5.hEx),
            //               ],
            //             ),
            //             subtitle: itemWidget('Concentração', concentracao),
            //           ),
            //         );
            //       },
            //       itemCount: _controller.listRequestPrincipalActive.length,
            //       shrinkWrap: true,
            //     );
            //   }),
            // ),
          ],
        ),
      );
    });
  }

  itemWidget(String title, String subtitle) => RichText(
        text: TextSpan(
          text: "$title\n",
          style: GoogleFonts.openSans(fontSize: 14.0, color: ConstColors.cinza2, fontWeight: FontWeight.w400),
          children: [
            TextSpan(
              text: subtitle,
              style: GoogleFonts.openSans(fontSize: 14.0, color: ConstColors.cinza, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      );
}
