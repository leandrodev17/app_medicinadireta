import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import '../../../../../../core/models/profissional/conselho.dart';
import '../../../../../../core/widgets/app_html.dart';

import '../../../../commons/controllers/commons_controller_soap.dart';
import '../../../../commons/widgets/item_text_commons.dart';
import '../../infra/models/anamnese_ext.dart';
import '../controller/anamnese_controller.dart';
import '/constants/const_colors.dart';
import '/core/extension/size_screen_extension.dart';
import '/core/widgets/form/app_button_simple.dart';
import 'form_new_anamnese.dart';

class CardItemAnamnese extends StatelessWidget {
  final AnamneseController controller;
  final CommonsControllerSoap commonsController;
  final AnamneseExt model;
  final int itemIndex;
  final ParamsToNavigationPage paramsToNavigationPage;
  const CardItemAnamnese({Key? key, required this.controller, required this.commonsController, required this.model, required this.itemIndex, required this.paramsToNavigationPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Conselho>? _conselho = model.profissional?.conselho;
    bool isNotEmptyConselho = _conselho != null && _conselho.isNotEmpty;

    String profissional = model.profissional?.nome?.toString() ?? 'no_value'.tr;
    String? conselhoTipo = _conselho != null && isNotEmptyConselho ? _conselho.first.conselhoTipo : '';
    String? numeroConselho = _conselho != null && isNotEmptyConselho ? _conselho.first.numeroConselho : '';
    String nameConselho = (model.profissional?.nome != null && isNotEmptyConselho) ? "$conselhoTipo | $numeroConselho" : '';

    bool isEdit = controller.isEditAnamnese(userId: int.parse(model.usuarioId?.toString() ?? '0'), edit: model.editavel);

    Color borderCard = isEdit ? ConstColors.orange : ConstColors.blue;
    String id = model.id?.toString() ?? 'no_value'.tr;
    String atendimentoId = model.atendimentoId?.toString() ?? 'no_value'.tr;
    String dataLocal = commonsController.dateFormat(model.dataLocal);
    String utcEvento = model.utcEvento?.toString() ?? 'no_value'.tr;
    String descricao = model.titulo?.toString() ?? 'no_value'.tr;

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
                expansionCallback: (int index, bool isExpanded) => commonsController.expansionCallback(itemIndex, isExpanded),
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
                                  ItemTextCommons(title: 'Título', description: descricao),
                                  SizedBox(height: 10.hEx),
                                  ItemTextCommons(title: 'Profissional', description: profissional),
                                  Text(nameConselho, style: const TextStyle(fontSize: 12)),
                                  SizedBox(height: 10.hEx),
                                  ItemTextCommons(title: 'Data (UTC $utcEvento)', description: dataLocal),
                                  Visibility(visible: !(commonsController.isExpandedIndex.value == itemIndex), child: SizedBox(height: 10.hEx)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    isExpanded: commonsController.isExpandedIndex.value == itemIndex,
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
                                  ItemTextCommons(title: 'n° Atendimento', description: atendimentoId),
                                  SizedBox(width: 60.wEx),
                                  ItemTextCommons(title: 'ID REGISTRO', description: id),
                                ],
                              ),
                              SizedBox(height: 10.hEx),
                              const ItemTextCommons(title: 'Uni. atendimento', description: 'Sbis'),
                              SizedBox(height: 10.hEx),
                              ItensAnamnese(title: "Motivo do Atendimento: ", subTitle: model.motivoAtendimento),
                              ItensAnamnese(title: "HDA - Hist. da Doença Atual: ", subTitle: model.descricaoHda),
                              ItensAnamnese(title: "HPP - Hist. das Patologias Pregressas: ", subTitle: model.descricaoHpp),
                              ItensAnamnese(title: "Hábitos e Estilo de Vida: ", subTitle: model.descricaoHabito),
                              ItensAnamnese(title: "Drogas/Tabagismo/Álcool: ", subTitle: model.descricaoVicio),
                              ItensAnamnese(title: "Histórico Mental e Social: ", subTitle: model.historicoMental),
                              ItensAnamnese(title: "Histórico Familiar: ", subTitle: model.historicoFamiliar),
                              ItensAnamnese(title: "Outros: ", subTitle: model.outros),
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
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => FormNewAnamnese(
                                        controller: controller,
                                        params: paramsToNavigationPage,
                                        edit: isEdit,
                                        itemAnamnese: model,
                                        title: 'Editar Anamnese'.tr.toUpperCase(),
                                      ),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                },
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
            })),
      ),
    );
  }
}

class ItensAnamnese extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const ItensAnamnese({Key? key, this.title, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: subTitle?.isNotEmpty ?? false,
      child: Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(title?.toUpperCase() ?? '--', style: TextStyle(color: ConstColors.cinza2, fontSize: 10.spEx, fontWeight: FontWeight.w400)),
            ),
            AppHtml(onData: subTitle, textStyle: TextStyle(color: ConstColors.cinza, fontSize: 14.spEx, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
