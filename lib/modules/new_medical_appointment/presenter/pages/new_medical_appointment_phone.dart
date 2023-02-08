import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/validators/app_validators.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/form/app_text_field_simple.dart';
import 'package:medicinadireta/core/widgets/form/radio_button_group.dart';
import 'package:medicinadireta/core/widgets/form/render_when.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/doctor_commitment_ext.dart';
import 'package:medicinadireta/modules/new_medical_appointment/presenter/controller/new_medical_appointment_controller.dart';
import 'package:medicinadireta/modules/reschedule_committed/domain/entities/network/model_from_request_to_snap.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/alert/app_alert.dart';
import '../../../../core/widgets/app_log.dart';
import '../widgets/item_datetime.dart';
import '../widgets/widget_option_find_patient.dart';
import '../widgets/widget_option_new_patient.dart';
import '../widgets/widget_option_select_contact.dart';
import '../widgets/widget_send_mail.dart';
import '../widgets/widget_send_sms.dart';

class NewMedicalAppointmentPhone extends StatefulWidget {
  const NewMedicalAppointmentPhone({Key? key}) : super(key: key);

  @override
  _NewMedicalAppointmentPhoneState createState() => _NewMedicalAppointmentPhoneState();
}

class _NewMedicalAppointmentPhoneState extends State<NewMedicalAppointmentPhone> with WidgetsBindingObserver {
  final _scrollController = ScrollController();
  final _controller = Get.find<NewMedicalAppointmentController>();

  final _titleEC = TextEditingController();
  final _appointmentEC = TextEditingController();

  /// Parametros de navegação entre telas para facilitar a o cadastro da consulta
  final ParamsToNavigationPage _params = Get.arguments[0];

  final DoctorCommitmentExt _modelCommitmentExt = Get.arguments[1];

  /// Se for encaixe escolhe o horario que quiser
  bool _isSnap = false;

  /// Recebe valor isNap para identificar se é um encaixe ou agemento comum.
  final Map<String, String?> _parameters = Get.parameters;

  final _formKey = GlobalKey<FormState>();

  /// Model de request para agendamento do tipo Encaixe
  // var _modelRequestSnap = ModelFromRequestToSnap();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.requestToSnap = ModelFromRequestToSnap();
      _controller.datetimeCurrent.value = DateTime.now();
      _controller.textFieldNamePatientFind.clear();

      ///Prepara Data e Hora para serem enviados no envio do e-mail
      _controller.formatDateTimeSchedule(_modelCommitmentExt);

      ///Limpa os campos (Talvez será removido esse bloco)
      _controller.emptyDataSendToServer();

      /// Pesquisa os contatos
      _controller.findContats();

      /// Lista os modelos de e-mails
      _controller.findModelToMail();

      /// Lista os modelos para o envio do SMS
      _controller.findModelToSms();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    _titleEC.dispose();
    _appointmentEC.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) => _body();
  _body() {
    _isSnap = _parameters['snap'] == "1";
    return AppScaffold(
      backgroundColor: ConstColors.backgroundDefault,
      onWillPop: () async => await Future.value(true),
      bottomNavigationBar: const AppBottomNavigationBar(),
      body: SafeArea(
        child: AppScaffold(
          backgroundColor: ConstColors.backgroundDefault,
          appBar: AppBarDefault.bar(titleApp: _isSnap ? "ENCAIXE" : 'new_schedule'),
          body: ResponsiveBuilder(builder: (context, view) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              controller: _scrollController,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: AnimatedFromColumn(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppTextFieldSimple(
                        controller: _titleEC,
                        maxLength: 150,
                        hintText: 'Escreva o título*'.tr,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        enabled: !_controller.loadingSave.value,
                        textCapitalization: TextCapitalization.characters,
                        onSaved: (data) => _controller.requestToSnap = _controller.requestToSnap.copyWith(titulo: data),
                        validator: AppValidators.multiple(
                          [
                            AppValidators.required(),
                            AppValidators.min(4, 'Informe mais detalhes para o título'),
                          ],
                        ),
                      ),

                      /// Fluxo de insert normal
                      Visibility(visible: !_isSnap, child: ItemDatetime(controller: _controller, time: _modelCommitmentExt.hourFormatStart, datetime: _modelCommitmentExt.dataInicioFormat)),
                      Visibility(
                        visible: _isSnap,
                        child: Obx(() {
                          return ItemDatetime(
                            controller: _controller,
                            time: FormatsDatetime.formatDate(_controller.datetimeCurrent.value, FormatsDatetime.timeFormatHHMM),
                            datetime: FormatsDatetime.formatDate(_controller.datetimeCurrent.value, FormatsDatetime.dateFormat),
                            isSnap: true,
                          );
                        }),
                      ),
                      Obx(() {
                        return Container(
                          decoration: BoxDecoration(color: ConstColors.white, borderRadius: BorderRadius.circular(8)),
                          child: RadioButtonGroup(
                            title: null,
                            labels: _controller.typeRegisted,
                            groupValue: _controller.indexTypeRegisted.value,
                            onChanged: _controller.onChangeTypeRegisted,
                            visibleStyle: true,
                          ),
                        );
                      }),
                      const SizedBox(height: 10),
                      Obx(() => Visibility(visible: _controller.indexTypeRegisted.value == 0, child: WidgetOptionNewPatient(controller: _controller))),
                      Obx(() => Visibility(visible: _controller.indexTypeRegisted.value == 1, child: WidgetOptionFindPatient(controller: _controller))),
                      Obx(() => Visibility(visible: _controller.indexTypeRegisted.value == 2, child: WidgetOptionSelectContact(controller: _controller))),
                      const SizedBox(height: 10),

                      Obx(() => Visibility(visible: _controller.indexTypeRegisted.value != 2, child: WidgetSendMail(controller: _controller))),
                      const SizedBox(height: 5),
                      Obx(() => Visibility(visible: _controller.indexTypeRegisted.value != 2, child: WidgetSendSms(controller: _controller))),

                      const SizedBox(height: 20),
                      Obx(() {
                        return AppButton(
                          minWidth: MediaQuery.of(context).size.width,
                          colorBackground: ConstColors.blue,
                          onPressed: _controller.loadingSave.value ? null : () async => await onPressed(),
                          childRaisedButton: RenderWhen(
                            text: 'toSchedule'.tr.toUpperCase(),
                            isLoading: _controller.loadingSave.value,
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  onPressed() async {
    try {
      var formValid = _formKey.currentState?.validate() ?? false;
      if (formValid) {
        _formKey.currentState?.save();

        ModelFromRequestToSnap modelReq = ModelFromRequestToSnap(
          dataInicio: _controller.requestToSnap.dataInicio,
          dataFim: _controller.requestToSnap.dataFim,
          horaInicio: _controller.requestToSnap.horaInicio,
          horaFim: _controller.requestToSnap.horaFim,
          titulo: _controller.requestToSnap.titulo,
          pacienteId: _params.pacienteId,
        );

        if (_controller.indexTypeRegisted.value != 2) {
          if (_controller.typeSendMail.value) {
            modelReq = modelReq.copyWith(
              idEmail: _controller.requestToSnap.idEmail,
              codModeloEmail: _controller.requestToSnap.codModeloEmail,
              assuntoModeloEmail: _controller.requestToSnap.assuntoModeloEmail,
              emailEnviar: _controller.requestToSnap.emailEnviar,
              email: _controller.requestToSnap.email,
            );
          }

          if (_controller.typeSendSms.value) {
            modelReq = modelReq.copyWith(
              idSms: _controller.requestToSnap.idSms,
              codModeloSms: _controller.requestToSnap.codModeloSms,
              assuntoModeloSms: _controller.requestToSnap.assuntoModeloSms,
              smsEnviar: _controller.requestToSnap.smsEnviar,
              smsTelefone: _controller.requestToSnap.smsTelefone,
            );
          }
        }

        ///Agendamento normal
        if (!_isSnap) {
          String date = FormatsDatetime.formatDate(_modelCommitmentExt.dataInicio!, FormatsDatetime.apiDateFormat);
          String horaEnvio = FormatsDatetime.formatTime(_modelCommitmentExt.horaInicio ?? '00:00', withSeconds: false);
          modelReq = modelReq.copyWith(
            dataInicio: date,
            dataFim: date,
            horaInicio: horaEnvio,
            horaFim: horaEnvio,
          );
        }

        if (_isSnap) {
          await _controller.saveScheduleSnap(_params, modelReq);
        } else {
          await _controller.saveSchedule(_params, modelReq);
        }
      }
    } catch (e) {
      AppLog.d('Problema para agendar o compromisso - $e', name: 'NewMedicalAppointmentPhone');
      AppAlert.alertError(title: "Oops!", body: "Não foi possível enviar os dados $e", seconds: 10);
    }
  }
}
