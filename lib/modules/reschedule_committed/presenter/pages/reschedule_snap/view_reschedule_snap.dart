import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/mixin/basic_page_mixin.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/validators/app_validators.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/form/app_date_time_field.dart';
import 'package:medicinadireta/core/packages/dropdown_search_package/app_dropdown_widget_search_impl.dart';
import 'package:medicinadireta/core/widgets/form/app_text_field.dart';
import 'package:medicinadireta/core/widgets/form/render_when.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/commitement_details.dart';
import 'package:medicinadireta/modules/reschedule_committed/domain/entities/network/request_reschedule_default.dart';
import 'package:medicinadireta/modules/reschedule_committed/presenter/controller/reschedule_committed_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewRescheduleSnap extends BasePage {
  ViewRescheduleSnap({Key? key}) : super(key: key);

  @override
  _ViewRescheduleSnapState createState() => _ViewRescheduleSnapState();
}

class _ViewRescheduleSnapState extends BaseState<ViewRescheduleSnap> with WidgetsBindingObserver, BasicPage {
  /// Dados do paciente para poupular o card de usuário
  final CommitementDetails _commitementDetails = Get.arguments[0];

  /// Parametros com dados do médico na hora do clique, esses dados pode mudar conforme a necessidade do usuário na tela.
  ParamsToNavigationPage _params = Get.arguments[1];

  ///Dados do usuário do card que teve o clique
  // ModelDetailsReschedule _modelDetailsReschedule = Get.arguments[2];

  ///Valores que seram enviados para o servidor
  var _modelRequestServer = RequestRescheduleSnap();

  /// Reescrevendo valores dos paramsNavigators para esse novo objeto, objetivo é facilitar a reescrita durante o formulario e carregamento conforme altera os dados
  // var _paramsToNavigationPage = ParamsToNavigationPage();

  final _controller = Get.find<RescheduleCommittedController>();
  final _formKey = GlobalKey<FormState>();

  @override
  String screenName() => 'reschedule_snap'.tr;

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  AppBottomNavigationBar? bottomNavigationBar() => AppBottomNavigationBar();

  @override
  Function()? onPressedLeading() => () => Get.back();

  @override
  ParamsToNavigationPage? screenCardPatient() => _commitementDetails.tipoAtendimento != "3" ? _params : null;

  @override
  List<Widget>? actions() => [];

  @override
  Widget? floatingActionButton() => null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.titleRescheduleSanp.text = _params.tituloDaConsulta ?? '';
      _controller.searchListDoctors(_params);
      // _controller.formatDateTime(_modelDetailsReschedule);

      // AppLog.d('_paramsNavigator ${_params.toMap()}');
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget body() => _body();

  Widget _body() {
    return ResponsiveBuilder(builder: (context, view) {
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Form(
          key: _formKey,
          child: AnimatedFromColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() {
                return AppDropdownWidgetSearchImpl(
                  items: _controller.listDoctorSchedule.map((e) => e.descricao?.toUpperCase()).toList(),
                  selectedItem: _controller.selectedItemDoctor.value,
                  validator: AppValidators.required(),
                  onSaved: (dynamic filter) {
                    if (filter != null) {
                      var _list = _controller.listDoctorSchedule.firstWhere((e) => e.descricao?.toLowerCase() == filter?.toLowerCase());
                      _modelRequestServer = _modelRequestServer.copyWith(agendaConfigId: _list.id);
                      print('Paciente selecionado ${_list.toMap()}');
                    }
                  },
                  labelText: 'Responsável'.toUpperCase(),
                );
              }),
              SizedBox(height: 10),
              Obx(() {
                _controller.loadingListDoctorCommittedHors.value;
                return AppDateTime(
                  key: ValueKey(_controller.initialValueDateTimeRescheduleSnap?.value),
                  resetIcon: null,
                  label: 'Data do Agendamento'.toUpperCase(),
                  hintText: 'Data do Agendamento',
                  enabled: true,
                  initialValue: _controller.initialValueDateTimeRescheduleSnap?.value,
                  timer: true,
                  allowBefore: true,
                  allowAfter: true,
                  suffix: Icon(Icons.date_range_outlined, color: ConstColors.blue),
                  validator: AppValidators.dateRequired(),
                  onSaved: (d) {
                    if (d != null) {
                      var _time = FormatsDatetime.formatDate(d, FormatsDatetime.apiTimeFormat);
                      _modelRequestServer = _modelRequestServer.copyWith(data: d.toUtc().toIso8601String(), horaEncaixe: _time);
                    }
                  },
                );
              }),
              SizedBox(height: 10),
              SizedBox(height: 10),
              Obx(() {
                return AppTextField(
                  controller: _controller.titleRescheduleSanp,
                  maxLength: 100,
                  labelText: 'title'.tr.toUpperCase(),
                  hintText: 'title'.tr,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  enabled: !_controller.savingRescheduleSnap.value,
                  textCapitalization: TextCapitalization.characters,
                  onSaved: (data) => _modelRequestServer = _modelRequestServer.copyWith(titulo: data),
                  validator: AppValidators.multiple([
                    AppValidators.required(),
                  ]),
                );
              }),
              SizedBox(height: 20),
              Obx(() {
                return AppTextField(
                  controller: _controller.descriptionRescheduleSanp,
                  maxLines: 20,
                  minLines: 5,
                  labelText: 'observation'.tr.toUpperCase(),
                  hintText: 'observation'.tr,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  enabled: !_controller.savingRescheduleSnap.value,
                  onSaved: (data) => _modelRequestServer = _modelRequestServer.copyWith(observacoes: data),
                  // validator: AppValidators.multiple([
                  //   AppValidators.required(),
                  // ]),
                );
              }),
              SizedBox(height: 25),
              Column(
                children: [
                  Obx(() {
                    return AppButton(
                      minWidth: MediaQuery.of(context).size.width - 50,
                      colorBackground: ConstColors.blue,
                      onPressed: () async {
                        var formValid = _formKey.currentState?.validate() ?? false;
                        if (formValid) {
                          _formKey.currentState?.save();
                          _modelRequestServer = _modelRequestServer.copyWith(tipoAtendimento: _commitementDetails.tipoAtendimento);
                          AppLog.i(_modelRequestServer.toMap().toString());
                          await _controller.saveRescheduleSnap(_modelRequestServer, _commitementDetails.id!, _params);
                        }
                      },
                      childRaisedButton: RenderWhen(
                        text: 'toSchedule'.tr,
                        isLoading: _controller.savingRescheduleSnap.value,
                      ),
                    );
                  })
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
