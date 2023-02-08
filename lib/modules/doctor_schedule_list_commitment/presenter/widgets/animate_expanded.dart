import 'package:google_fonts/google_fonts.dart';
import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/constants/const_drawables.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/commitement_details.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/controllers/doctor_commitment_controller.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'item_obs.dart';
import 'item_title.dart';

class AnimateExpanded extends StatefulWidget {
  final CommitementDetails model;
  final ParamsToNavigationPage params;
  final DoctorCommitmentController controller;
  final int indexList;

  const AnimateExpanded({Key? key, required this.model, required this.params, required this.controller, required this.indexList}) : super(key: key);
  @override
  _AnimateExpandedState createState() => _AnimateExpandedState();
}

class _AnimateExpandedState extends State<AnimateExpanded> {
  CommitementDetails get _model => widget.model;
  ParamsToNavigationPage get _params => widget.params;
  DoctorCommitmentController get _controller => widget.controller;
  int get _indexList => widget.indexList;

  @override
  Widget build(BuildContext context) {
    bool isObservacao = _model.observacao.toString() != '' && _model.observacao != null;
    bool isTitulo = _model.titulo.toString() != '' && _model.titulo != null;
    var width = MediaQuery.of(context).size.width;
    var title = _model.titulo ?? '--';
    var observacao = _model.observacao != null && (_model.observacao?.isNotEmpty ?? false) ? _model.observacao : null;
    var description = _model.descricao ?? '--';
    Color borderCard = _model.cor != null ? Color(_model.cor!) : const Color(0xFFB6B9D0);
    return Card(
      key: ValueKey(_model.id),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0,
      child: ClipPath(
        clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.rEx))),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(border: Border(left: BorderSide(color: borderCard, width: 8.wEx))),
          child: Column(
            children: [
              InkWell(
                onTap: _model.tipoAtendimento == "3" ? null : () => Get.toNamed(Routes.PATIENT_DETAILS, arguments: _params),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${_model.hourFormatStart}', style: GoogleFonts.openSans(color: borderCard, fontSize: 14.spEx, fontWeight: FontWeight.w700)),
                      Flexible(child: Text(description, style: GoogleFonts.openSans(color: borderCard, fontSize: 14.spEx, fontWeight: FontWeight.w400))),
                    ],
                  ),
                ),
              ),
              const Divider(color: Color(0xFFEEEEEE), thickness: 1),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(onTap: _model.tipoAtendimento == "3" ? null : () => Get.toNamed(Routes.PATIENT_DETAILS, arguments: _params), child: Text(_model.name?.toUpperCase() ?? "no_value".tr, style: TextStyle(color: ConstColors.graphite, fontSize: 14.spEx, fontWeight: FontWeight.bold))),
                        Visibility(visible: isObservacao, child: ItemOBS(obs: _model.observacao ?? '', openCardPatient: _model.openCardPatient)),
                        Visibility(visible: !isObservacao && isTitulo, child: ItemTitle(title: _model.titulo ?? '', openCardPatient: _model.openCardPatient)),
                      ],
                    ),
                  ),
                  IconButton(
                    iconSize: 0,
                    visualDensity: VisualDensity.compact,
                    icon: Icon(_model.openCardPatient ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: ConstColors.cinza3, size: 30.hEx),
                    onPressed: () => _controller.openItemCardFromList(_indexList),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
              _animatedOpacity(title, width, context, observacao)
            ],
          ),
        ),
      ),
    );
  }

  _animatedOpacity(String? title, double width, BuildContext context, String? observacao) {
    return AnimatedOpacity(
      opacity: _model.openCardPatient ? 1.0 : 0.0,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 900),
      child: Visibility(
        visible: _model.openCardPatient,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              maxLines: 1,
              text: TextSpan(
                text: 'Prontuário: ',
                style: GoogleFonts.openSans(color: const Color(0xFF656565), fontSize: 14.spEx, fontWeight: FontWeight.w300),
                children: [
                  TextSpan(
                    text: _model.numberProntuario?.toString() ?? '--',
                    style: GoogleFonts.openSans(color: ConstColors.graphite, fontSize: 14.spEx, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Visibility(visible: observacao != null && observacao.toString().trim() != '', child: SizedBox(height: 6.hEx)),
            Visibility(
              visible: observacao != null && observacao.toString().trim() != '',
              child: RichText(
                maxLines: 1,
                text: TextSpan(
                  text: 'Título: ',
                  style: GoogleFonts.openSans(color: const Color(0xFF656565), fontSize: 14.spEx, fontWeight: FontWeight.w300),
                  children: [
                    TextSpan(
                      text: title.toString().trim().toUpperCase(),
                      style: GoogleFonts.openSans(color: ConstColors.graphite, fontSize: 14.spEx, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(visible: observacao != null && observacao.toString().trim() != '', child: SizedBox(height: 8.hEx)),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(ConstColors.blue),
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
                    ),
                    onPressed: () async => await Get.toNamed(Routes.RESCHEDULE_SNAP, arguments: [_model, _params]),
                    child: Text(
                      'reschedule_snap'.tr,
                      style: GoogleFonts.openSans(
                        color: ConstColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.wEx),
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(ConstColors.blue),
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
                    ),
                    onPressed: () async => await Get.toNamed(Routes.RESCHEDULE, arguments: [_model, _params]),
                    child: Text(
                      'reschedule'.tr,
                      style: GoogleFonts.openSans(
                        color: ConstColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
