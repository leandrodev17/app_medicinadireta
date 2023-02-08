import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';

import '../../../../../../core/models/profissional/conselho.dart';
import '../../infra/models/anthropometry_model.dart';
import '../controller/anthropometry_controller.dart';
import './item_text.dart';

import '/constants/const_colors.dart';
import '/core/extension/size_screen_extension.dart';
import '/core/widgets/form/app_button_simple.dart';

class CardItemAnthropometry extends StatelessWidget {
  final AnthropometryController controller;
  final AnthropometryModel model;
  final int itemIndex;
  final ParamsToNavigationPage paramsToNavigationPage;
  const CardItemAnthropometry({Key? key, required this.controller, required this.model, required this.itemIndex, required this.paramsToNavigationPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width * .3;
    bool isEdit = false;
    // logUsuario pode vir qualquer valor do banco e não só o id do usuário que alterou o registro
    // bool isEdit = controller.isEditAllergys(userId: int.parse(model.logUsuario?.toString() ?? '0'), edit: model.editavel);
    List<Conselho>? conselho = model.profissional?.conselho;
    bool isNotEmptyConselho = conselho != null && conselho.isNotEmpty;

    String profissional = model.profissional?.nome?.toString() ?? 'no_value'.tr;
    String? conselhoTipo = conselho != null && isNotEmptyConselho ? conselho.first.conselhoTipo : '';
    String? numeroConselho = conselho != null && isNotEmptyConselho ? conselho.first.numeroConselho : '';
    String nameConselho = (model.profissional?.nome != null && isNotEmptyConselho) ? "$conselhoTipo | $numeroConselho" : '';

    Color borderCard = isEdit ? ConstColors.orange : ConstColors.blue;
    String id = model.id?.toString() ?? 'no_value'.tr;
    String atendimentoId = model.atendimentoId?.toString() ?? 'no_value'.tr;
    // bool privacidadeClinica = model.privacidadeClinica ?? true;
    // String dataLocal = privacidadeClinica ? "privateClinical".tr : controller.dateFormatAllergy(model.dataEvento);
    String dataLocal = controller.dateFormatAllergy(model.dataEvento);
    String utcEvento = model.utcEvento?.toString() ?? 'no_value'.tr;
    String descricao = "Antropometria - ${itemIndex + 1}";
    String status = model.status?.toString().trim() ?? 'no_value'.tr;
    String peso = model.peso?.toString() ?? 'no_value'.tr;
    String pesoUm = model.pesoUm ?? 'no_value'.tr;
    String altura = model.altura?.toString() ?? 'no_value'.tr;
    String alturaUm = model.alturaUm ?? 'no_value'.tr;
    String circuferenciaAbdominal = model.circuferenciaAbdominal?.toString() ?? 'no_value'.tr;
    String abdominalUm = model.abdominalUm ?? 'no_value'.tr;

    String calcAsc = model.calcAsc?.toString() ?? 'no_value'.tr;
    String calcImc = model.calcImc?.toString() ?? 'no_value'.tr;
    String calcIca = model.calcIca?.toString() ?? 'no_value'.tr;
    String calcAct = model.calcAct?.toString() ?? 'no_value'.tr;
    String calcPgc = model.calcPgc?.toString() ?? 'no_value'.tr;

    String massaMagra = model.massaMagra?.toString() ?? 'no_value'.tr;
    String massaMagraUm = model.massaMagraUm?.toString() ?? 'no_value'.tr;
    String massaGorda = model.massaGorda?.toString() ?? 'no_value'.tr;
    String massaGordaUm = model.massaGordaUm?.toString() ?? 'no_value'.tr;

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
                                ItemText(title: 'Título', description: descricao),
                                SizedBox(height: 10.hEx),
                                ItemText(title: 'Profissional', description: profissional),
                                Text(nameConselho, style: const TextStyle(fontSize: 12)),
                                SizedBox(height: 10.hEx),
                                ItemText(title: 'Data (UTC $utcEvento)', description: dataLocal),
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
                            const ItemText(title: 'Uni. atendimento', description: 'Sbis'),
                            SizedBox(height: 10.hEx),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ItemText(title: 'n° Atendimento', description: atendimentoId),
                                ItemText(title: 'ID REGISTRO', description: id),
                              ],
                            ),
                            SizedBox(height: 10.hEx),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ItemText(title: 'Peso', description: "$peso $pesoUm"),
                                ItemText(title: 'Altura', description: "$altura $alturaUm"),
                              ],
                            ),
                            SizedBox(height: 10.hEx),
                            ItemText(title: 'Circ. Abdominal', description: "$circuferenciaAbdominal $abdominalUm"),
                            SizedBox(height: 10.hEx),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ItemText(title: 'Massa de Gordura', description: "$massaGorda $massaGordaUm"),
                                ItemText(title: 'Massa Magra', description: "$massaMagra $massaMagraUm"),
                              ],
                            ),
                            SizedBox(height: 10.hEx),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ItemText(title: 'ASC', description: calcAsc),
                                ItemText(title: 'IMC', description: calcImc),
                              ],
                            ),
                            SizedBox(height: 10.hEx),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ItemText(title: 'ICA', description: calcIca),
                                ItemText(title: 'ACT', description: calcAct),
                              ],
                            ),
                            SizedBox(height: 10.hEx),
                            ItemText(title: 'PGC', description: calcPgc),
                            SizedBox(height: 10.hEx),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.hEx),
                      Visibility(
                        visible: false,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 17.wEx),
                          child: AppButtonSimple(
                            width: MediaQuery.of(context).size.width,
                            child: TextButton.icon(
                              onPressed: null,
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
