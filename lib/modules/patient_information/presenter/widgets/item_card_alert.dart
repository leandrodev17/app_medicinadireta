import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/helpers/helpers.dart';
import 'package:medicinadireta/modules/patient_alert/infra/models/patient_alert_model.dart';
import 'package:medicinadireta/modules/patient_alert/presenter/controller/patient_alert_controller.dart';

class ItemCardAlert extends StatelessWidget {
  final PatientAlertController controller;
  final Map<String, List<PatientAlertModel>> alerts;

  const ItemCardAlert({Key? key, required this.alerts, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: alerts.keys.toList().length,
      itemBuilder: (_, index) {
        List<String> _key = alerts.keys.toList();
        String _typeKey = _key[index];
        return Obx(() {
          return Card(
            elevation: 0,
            child: ClipPath(
              clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.rEx))),
              child: ExpansionPanelList(
                elevation: 0,
                animationDuration: const Duration(milliseconds: 600),
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (int indexExpanded, bool isExpanded) {
                  controller.changeAbaAlert(index);
                },
                children: [
                  ExpansionPanel(
                    backgroundColor: Color(controller.coresAlerts[_typeKey] ?? 0xFF0C2D59),
                    canTapOnHeader: true,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.rEx), topLeft: Radius.circular(5.rEx)),
                          ),
                          width: 50.wEx,
                          height: MediaQuery.of(context).size.height,
                          child: Icon(Icons.warning_amber, size: 30.wEx, color: Colors.white),
                        ),
                        title: Text(
                          controller.titleAlerts[_typeKey].toString(),
                          style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16.spEx),
                        ),
                      );
                    },
                    isExpanded: controller.abaAlert.value == index,
                    body: _body(context, alerts[_typeKey], _typeKey),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  _body(BuildContext context, List<PatientAlertModel>? datas, String type) {
    return Card(
      elevation: 0,
      child: ClipPath(
        clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.rEx))),
        child: Container(
          color: ConstColors.white,
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(border: Border(left: BorderSide(color: ConstColors.white, width: 5.wEx))),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                PatientAlertModel? item = datas?[index];
                DateTime? time = item?.dataEvento != null ? DateTime.parse(item!.dataEvento.toString()) : null;
                String dataEvento = time != null ? FormatsDatetime.formatDate(time, FormatsDatetime.dateFormat) : '--';
                String medical = item?.descricao.toString() ?? '';
                String alergia = (item?.alergia != null && (item?.alergia?.isNotEmpty ?? false)) ? "${item!.alergia}\n" : '';
                String description = medical;
                return ListTile(
                  title: wi('DATA DO REGISTRO:\n', dataEvento),
                  subtitle: wi('DESCRIÇÃO:\n', description, subtitleAlergia: alergia),
                );
              },
              separatorBuilder: (_, index) => const Divider(),
              itemCount: datas?.length ?? 0,
            ),
          ),
        ),
      ),
    );
  }

  wi(String label, String subtitle, {String subtitleAlergia = ''}) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: RichText(
          text: TextSpan(
            text: label,
            style: GoogleFonts.openSans(fontSize: 16.0, color: ConstColors.cinza2, fontWeight: FontWeight.w700),
            children: [
              TextSpan(
                text: Helpers.parseHtmlString(subtitleAlergia),
                style: GoogleFonts.openSans(fontSize: 14.0, color: ConstColors.ff7D7D7D, fontWeight: FontWeight.w700),
              ),
              TextSpan(
                text: Helpers.parseHtmlString(subtitle),
                style: GoogleFonts.openSans(fontSize: 14.0, color: ConstColors.ff7D7D7D, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      );
}
