import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';

import '../../../../../../core/models/profissional/conselho.dart';
import '../../infra/models/pressure_model.dart';
import '../controller/pressure_controller.dart';
import './item_text.dart';

import '/constants/const_colors.dart';
import '/core/extension/size_screen_extension.dart';
import '/core/widgets/form/app_button_simple.dart';

class CardItemPressure extends StatelessWidget {
  final PressureController controller;
  final PressureModel model;
  final int itemIndex;
  final ParamsToNavigationPage paramsToNavigationPage;
  const CardItemPressure({Key? key, required this.controller, required this.model, required this.itemIndex, required this.paramsToNavigationPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isEdit = false;
    // logUsuario pode vir qualquer valor do banco e não só o id do usuário que alterou o registro
    // bool isEdit = controller.isEditAllergys(userId: int.parse(model.logUsuario?.toString() ?? '0'), edit: model.editavel);
    List<Conselho>? _conselho = model.profissional?.conselho;
    bool isNotEmptyConselho = _conselho != null && _conselho.isNotEmpty;

    String profissional = model.profissional?.nome?.toString() ?? 'no_value'.tr;
    String? conselhoTipo = _conselho != null && isNotEmptyConselho ? _conselho.first.conselhoTipo : '';
    String? numeroConselho = _conselho != null && isNotEmptyConselho ? _conselho.first.numeroConselho : '';
    String nameConselho = (model.profissional?.nome != null && isNotEmptyConselho) ? "$conselhoTipo | $numeroConselho" : '';

    Color borderCard = isEdit ? ConstColors.orange : ConstColors.blue;
    String id = model.id?.toString() ?? 'no_value'.tr;
    String atendimentoId = model.atendimentoId?.toString() ?? 'no_value'.tr;
    String dataLocal = controller.dateFormatAllergy(model.dataEvento);
    String utcEvento = model.utcEvento?.toString() ?? 'no_value'.tr;
    String descricao = model.descricao?.toString() ?? 'no_value'.tr;

    String pressaoSistolicaPadrao = model.pressaoSistolicaPadrao?.toString() ?? 'no_value'.tr;
    String pressaoSistolica = model.pressaoSistolica?.toString() ?? 'no_value'.tr;

    String pressaoDistolicaPadrao = model.pressaoDistolicaPadrao?.toString() ?? 'no_value'.tr;
    String pressaoDiastolica = model.pressaoDiastolica?.toString() ?? 'no_value'.tr;

    String pressaoUm = model.pressaoUm?.toString() ?? 'no_value'.tr;
    String forma = model.forma?.toString() ?? 'no_value'.tr;
    String posicao = model.posicao?.toString() ?? 'no_value'.tr;
    String local = model.local?.toString() ?? 'no_value'.tr;

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
                                ItemText(title: 'Título', description: "Pressão Arterial - ${itemIndex + 1}"),
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ItemText(title: 'n° Atendimento', description: atendimentoId),
                                SizedBox(width: 60.wEx),
                                ItemText(title: 'ID REGISTRO', description: id),
                              ],
                            ),
                            SizedBox(height: 10.hEx),
                            Row(
                              children: [
                                const ItemText(title: 'Uni. atendimento', description: 'Sbis'),
                                SizedBox(width: 54.wEx),
                                // ItemText(title: 'Status', description: status),
                              ],
                            ),
                            SizedBox(height: 10.hEx),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ItemText(title: 'Pressão mmHg', description: "$pressaoSistolicaPadrao x $pressaoDistolicaPadrao mmHg"),
                                ItemText(title: 'Pressão cmHg', description: "${model.pressaoSistolicaPadrao / 10} x ${model.pressaoDistolicaPadrao / 10} cmHg"),
                              ],
                            ),
                            SizedBox(height: 10.hEx),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ItemText(title: 'Local', description: local),
                                ItemText(title: 'Forma', description: forma),
                              ],
                            ),
                            SizedBox(height: 10.hEx),
                            ItemText(title: 'Posição', description: posicao),
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
