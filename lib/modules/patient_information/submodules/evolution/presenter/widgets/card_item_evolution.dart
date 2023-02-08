import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/validators/validators.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/presenter/controller/form_evolution_controller.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/presenter/widgets/form_evolution.dart';
import '../../../../../../core/models/profissional/conselho.dart';
import '../../../../../../core/widgets/app_html.dart';

import '../../../../commons/controllers/commons_controller_soap.dart';
import '../../../../commons/widgets/item_text_commons.dart';
import '../../infra/models/evolution_ext.dart';
import '../controller/evolution_controller.dart';
import '/constants/const_colors.dart';
import '/core/extension/size_screen_extension.dart';
import '/core/widgets/form/app_button_simple.dart';

class CardItemEvolution extends StatelessWidget {
  final EvolutionController controller;
  final CommonsControllerSoap commonsController;
  final EvolutionExt model;
  final int itemIndex;
  final ParamsToNavigationPage paramsToNavigationPage;
  final FormEvolutionController formEvolutionController;
  const CardItemEvolution({
    Key? key,
    required this.controller,
    required this.commonsController,
    required this.model,
    required this.itemIndex,
    required this.paramsToNavigationPage,
    required this.formEvolutionController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Conselho>? _conselho = model.profissional?.conselho;
    bool isNotEmptyConselho = _conselho != null && _conselho.isNotEmpty;

    String profissional = model.profissional?.nome?.toString() ?? 'no_value'.tr;
    String? conselhoTipo = _conselho != null && isNotEmptyConselho ? _conselho.first.conselhoTipo : '';
    String? numeroConselho = _conselho != null && isNotEmptyConselho ? _conselho.first.numeroConselho : '';
    String nameConselho = (model.profissional?.nome != null && isNotEmptyConselho) ? "$conselhoTipo | $numeroConselho" : '';

    bool isEdit = controller.isEditEvolucao(userId: int.parse(model.logUsuario?.toString() ?? '0'), edit: model.editavel);

    Color borderCard = isEdit ? ConstColors.orange : ConstColors.blue;
    String id = model.id?.toString() ?? 'no_value'.tr;
    String atendimentoId = model.atendimentoId?.toString() ?? 'no_value'.tr;
    String dataLocal = commonsController.dateFormat(model.dataLocal);
    String utcEvento = model.dataAgendaUtc?.toString() ?? 'no_value'.tr;
    String descricao = model.localAgenda?.toString() ?? 'no_value'.tr;

    bool isHtml = validatorRegex.htmlTags(model.historico ?? '');

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
                              Visibility(
                                visible: model.tipoEditor == 'H' || isHtml,
                                replacement: ItemTextCommons(title: 'Histórico: ', description: model.historico ?? '-'),
                                child: ItensEvolution(title: "Histórico: ", subTitle: model.historico),
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
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => FormEvolution(
                                        editForm: true,
                                        arguments: paramsToNavigationPage,
                                        controller: formEvolutionController,
                                        itemModel: model,
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

class ItensEvolution extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const ItensEvolution({Key? key, this.title, this.subTitle}) : super(key: key);

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
