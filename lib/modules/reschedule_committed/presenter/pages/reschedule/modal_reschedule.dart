import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/models/params/model_details_reschedule.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/form/render_when.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/commitement_details.dart';
import 'package:medicinadireta/modules/reschedule_committed/domain/entities/network/request_reschedule_default.dart';
import 'package:medicinadireta/modules/reschedule_committed/presenter/controller/reschedule_committed_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModalReschedule extends StatelessWidget {
  final CommitementDetails modelCommitementDetails;
  final ModelDetailsReschedule newModelDetails;
  final RequestReschedule requestReschedule;
  final ParamsToNavigationPage params;
  ModalReschedule({Key? key, required this.newModelDetails, required this.requestReschedule, required this.modelCommitementDetails, required this.params}) : super(key: key);
// CommitementDetails
  final _controller = Get.find<RescheduleCommittedController>();

  @override
  Widget build(BuildContext context) {
    // var _dateOld = "ddddd";
    var _dateOld = FormatsDatetime.formatDate(DateTime.parse(params.dataDoFiltroDePesquisa.toString()), FormatsDatetime.dateFormat);
    var _dateNew = FormatsDatetime.formatDate(DateTime.parse(newModelDetails.date.toString()), FormatsDatetime.dateFormat);
    return AppScaffold(
      backgroundColor: ConstColors.backgroundDefault,
      bottomNavigationBar: AppBottomNavigationBar(),
      body: SafeArea(
        child: AppScaffold(
          backgroundColor: ConstColors.backgroundDefault,
          appBar: AppBarDefault.bar(titleApp: 'reschedule'),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              color: ConstColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              alignment: Alignment.center,
              child: AnimatedFromColumn(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Você Está Remarcando o Agendamento:'.tr, style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w500, color: ConstColors.orange)),
                  const SizedBox(height: 10),
                  _item(context, modelCommitementDetails.tipoAtendimento != "3" ? 'Paciente' : 'Contato', params.nomeDoPaciente.toString(), withOpacity: true),
                  _item(context, 'Agenda', params.nomeDoMedico.toString(), withOpacity: true),
                  _item(context, 'Título', params.tituloDaConsulta.toString(), withOpacity: true),
                  _item(context, 'Data e Hora da Agenda', '$_dateOld às ${params.horaDoAgendamento}', withOpacity: true),
                  const SizedBox(height: 20),
                  Divider(),
                  Text('Para o Novo Agendamento:', style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w500, color: ConstColors.orange)),
                  Divider(),
                  const SizedBox(height: 20),
                  _item(context, modelCommitementDetails.tipoAtendimento != "3" ? 'Paciente' : 'Contato', params.nomeDoPaciente.toString()),
                  _item(context, 'Agenda', newModelDetails.nameDoctor.toString()),
                  _item(context, 'Título', params.tituloDaConsulta.toString()),
                  _item(context, 'Data e Hora da Agenda', '$_dateNew às ${newModelDetails.hora}'),
                  const SizedBox(height: 40),
                  Obx(() {
                    return AppButton(
                      minWidth: MediaQuery.of(context).size.width - 50,
                      colorBackground: ConstColors.blue,
                      onPressed: () async => await _controller.saveRescheduleServer(requestReschedule, modelCommitementDetails.id!, params),
                      childRaisedButton: RenderWhen(
                        text: 'confirmar'.tr,
                        isLoading: _controller.savingReschedule.value,
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _item(BuildContext context, String title, String description, {bool withOpacity = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$title: ', style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w500, color: Colors.black)),
        Expanded(child: Text('$description'.toUpperCase(), style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w500, color: Colors.black54))),
        const SizedBox(height: 20),
      ],
    );
  }
}
