import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:medicinadireta/constants/const_strings.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';

import '../../../../../../core/models/profissional/conselho.dart';
import './item_text.dart';

import '/constants/const_colors.dart';
import '/core/extension/size_screen_extension.dart';
import '/core/widgets/form/app_button_simple.dart';
import '/modules/patient_information/submodules/allergy/domain/entities/allergy.dart';
import '/modules/patient_information/submodules/allergy/presenter/controller/allergy_controller.dart';
import 'form_allergy.dart';

class CardItem extends StatelessWidget {
  final AllergyController controller;
  final Allergy model;
  final int itemIndex;
  final ParamsToNavigationPage paramsToNavigationPage;
  const CardItem({Key? key, required this.controller, required this.model, required this.itemIndex, required this.paramsToNavigationPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: ConstColors.cinza, fontSize: 14.spEx, fontWeight: FontWeight.w400);
    Map<String, dynamic>? map = model.tipo != null ? controller.findItemMap(model.tipo, ConstStrings.origemTipo) : null;

    List<Conselho>? _conselho = model.profissional?.conselho;
    bool isNotEmptyConselho = _conselho != null && _conselho.isNotEmpty;

    String profissional = model.profissional?.nome?.toString() ?? 'no_value'.tr;
    String? conselhoTipo = _conselho != null && isNotEmptyConselho ? _conselho.first.conselhoTipo : '';
    String? numeroConselho = _conselho != null && isNotEmptyConselho ? _conselho.first.numeroConselho : '';
    String nameConselho = (model.profissional?.nome != null && isNotEmptyConselho) ? "$conselhoTipo | $numeroConselho" : '';

    bool isEdit = controller.isEditAllergys(userId: model.usuarioId, edit: model.editavel);
    String dataLocal = controller.dateFormatAllergy(model.dataLocal);
    String atendimentoId = model.atendimentoId?.toString() ?? 'no_value'.tr;
    String id = model.id?.toString() ?? 'no_value'.tr;
    String descricao = model.descricao?.toString() ?? 'no_value'.tr;
    String utcEvento = model.utcEvento?.toString() ?? '--';
    String tipo = map != null ? map['value'] : 'no_value'.tr;
    Map<String, dynamic>? _status = controller.findItemMap(model.status, ConstStrings.statusAllergy);
    String status = _status != null ? _status['value'] : 'no_value'.tr;
    Color borderCard = isEdit ? ConstColors.orange : ConstColors.blue;
    return Card(
      elevation: 0,
      child: ClipPath(
        clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.rEx))),
        child: Container(
          decoration: BoxDecoration(border: Border(left: BorderSide(color: borderCard, width: 5.wEx))),
          child: Obx(() {
            return ExpansionPanelList(
              elevation: 0,
              animationDuration: const Duration(milliseconds: 600),
              expandedHeaderPadding: const EdgeInsets.all(0),
              expansionCallback: (int index, bool isExpanded) => controller.expansionCallback(itemIndex, isExpanded),
              children: [
                ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                      padding: EdgeInsets.only(left: 10.wEx),
                      child: Row(
                        children: [
                          Icon(isEdit ? Icons.lock_open_outlined : Icons.lock, color: borderCard, size: 30.hEx),
                          SizedBox(width: 10.wEx),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10.hEx),
                                ItemText(title: 'Alergia', description: descricao),
                                SizedBox(height: 10.hEx),
                                ItemText(title: 'Profissional', description: profissional, textStyleDescription: textStyle),
                                Text(nameConselho, style: const TextStyle(fontSize: 12)),
                                SizedBox(height: 10.hEx),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(child: ItemText(title: 'TIPO', description: tipo, textStyleDescription: textStyle)),
                                    Flexible(child: ItemText(title: 'Data (UTC $utcEvento)', description: dataLocal, textStyleDescription: textStyle)),
                                  ],
                                ),
                                Visibility(visible: !(controller.isExpandedIndex.value == itemIndex), child: SizedBox(height: 10.hEx)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  isExpanded: controller.isExpandedIndex.value == itemIndex,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(color: Color(0xFFEEEEEE), thickness: 1),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.wEx),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ItemText(title: 'n° Atendimento', description: atendimentoId, textStyleDescription: textStyle),
                                SizedBox(width: 60.wEx),
                                ItemText(title: 'ID REGISTRO', description: id, textStyleDescription: textStyle),
                              ],
                            ),
                            SizedBox(height: 10.hEx),
                            Row(
                              children: [
                                ItemText(title: 'Uni. atendimento', description: 'Sbis', textStyleDescription: textStyle),
                                SizedBox(width: 54.wEx),
                                ItemText(title: 'Status', description: status.toString(), textStyleDescription: textStyle),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.hEx),
                      Visibility(
                        visible: isEdit,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 17.wEx),
                          child: AppButtonSimple(
                            width: MediaQuery.of(context).size.width,
                            child: TextButton.icon(
                              onPressed: () => Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => FormAllergy(
                                    title: 'Editar Alergia'.tr.toUpperCase(),
                                    edit: true,
                                    itemAllergy: model,
                                    controller: controller,
                                    params: paramsToNavigationPage,
                                  ),
                                ),
                              ),
                              icon: Icon(Icons.edit, color: ConstColors.white, size: 16.hEx),
                              label: Text('edit'.tr.toUpperCase(),
                                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                        color: ConstColors.white,
                                        fontSize: 14.spEx,
                                        fontWeight: FontWeight.w400,
                                      )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.hEx),
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
