import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/infra/models/exams_model.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/presenter/controller/exams_controller.dart';

import '../../../../../../core/models/profissional/conselho.dart';
import '../../../../../../core/widgets/app_html.dart';
import './item_text.dart';

import '/constants/const_colors.dart';
import '/core/extension/size_screen_extension.dart';
import '/core/widgets/form/app_button_simple.dart';

class CardItemExams extends StatelessWidget {
  final ExamsController controller;
  final ExamsModel model;
  final int itemIndex;
  final ParamsToNavigationPage paramsToNavigationPage;
  const CardItemExams({Key? key, required this.controller, required this.model, required this.itemIndex, required this.paramsToNavigationPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Conselho>? _conselho = model.profissional?.conselho;
    bool isNotEmptyConselho = _conselho != null && _conselho.isNotEmpty;

    String profissional = model.profissional?.nome?.toString() ?? 'no_value'.tr;
    String? conselhoTipo = _conselho != null && isNotEmptyConselho ? _conselho.first.conselhoTipo : '';
    String? numeroConselho = _conselho != null && isNotEmptyConselho ? _conselho.first.numeroConselho : '';
    String nameConselho = (model.profissional?.nome != null && isNotEmptyConselho) ? "$conselhoTipo | $numeroConselho" : '';
    bool isEdit = false;
    // logUsuario pode vir qualquer valor do banco e não só o id do usuário que alterou o registro
    // bool isEdit = controller.isEditExams(userId: int.parse(model.logUsuario?.toString() ?? '0'), edit: model.editavel);

    Color borderCard = isEdit ? ConstColors.orange : ConstColors.blue;
    String id = model.id?.toString() ?? 'no_value'.tr;
    String atendimentoId = model.atendimentoId?.toString() ?? 'no_value'.tr;
    String dataLocal = controller.dateFormatExams(model.dataLocal);
    String utcEvento = model.dataUtc?.toString() ?? 'no_value'.tr;
    String descricao = model.descricao?.toString() ?? 'no_value'.tr;
    String status = model.status?.toString() ?? 'no_value'.tr;
    String criacao = model.versao?.toString() ?? 'no_value'.tr;
    String enviado = model.enviado?.toString() ?? 'no_value'.tr;
    String receituario = model.receituario ?? 'no_value'.tr;

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
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(child: ItemText(title: 'Enviado', description: enviado)),
                                    Flexible(child: ItemText(title: 'Data (UTC $utcEvento)', description: dataLocal)),
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
                                ItemText(title: 'Status', description: status),
                              ],
                            ),
                            SizedBox(height: 10.hEx),
                            ItemText(title: 'Criação', description: criacao),
                            SizedBox(height: 10.hEx),
                            Text('Exame'.toUpperCase(), style: TextStyle(color: ConstColors.cinza2, fontSize: 10.spEx, fontWeight: FontWeight.w400)),
                            AppHtml(onData: receituario, textStyle: TextStyle(color: ConstColors.cinza, fontSize: 14.spEx, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.hEx),
                      Visibility(
                        visible: false, //isEdit,
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
