import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/mixin/basic_page_mixin.dart';
import 'package:medicinadireta/core/models/params/model_details_reschedule.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/validators/app_validators.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/core/widgets/form/app_date_time_field.dart';
import 'package:medicinadireta/core/packages/dropdown_search_package/app_dropdown_widget_search_impl.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/commitement_details.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/doctor_commitment_ext.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/widgets/shimmer_new_appointment.dart';
import 'package:medicinadireta/modules/reschedule_committed/domain/entities/network/request_reschedule_default.dart';
import 'package:medicinadireta/modules/reschedule_committed/presenter/controller/reschedule_committed_controller.dart';
import 'package:medicinadireta/modules/reschedule_committed/presenter/pages/reschedule/modal_reschedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewReschedule extends BasePage {
  ViewReschedule({Key? key}) : super(key: key);

  @override
  State<ViewReschedule> createState() => _ViewRescheduleState();
}

class _ViewRescheduleState extends BaseState<ViewReschedule> with WidgetsBindingObserver, BasicPage {
  /// Dados do paciente para poupular o card de usuário
  final CommitementDetails _commitementDetails = Get.arguments[0];

  /// Parametros com dados do médico na hora do clique, esses dados pode mudar conforme a necessidade do usuário na tela.
  ParamsToNavigationPage _params = Get.arguments[1];

  ///Dados do usuário do card que teve o clique
  // ModelDetailsReschedule _modelDetailsReschedule = Get.arguments[2];

  final _controller = Get.find<RescheduleCommittedController>();
  final _formKey = GlobalKey<FormState>();

  /// Model com novos valores alterado, outro médico, outra data e horário
  var _newModelDetails = ModelDetailsReschedule();

  ///Valores que seram enviados para o servidor
  var _modelRequestServer = RequestReschedule();

  /// Reescrevendo valores dos paramsNavigators para esse novo objeto, objetivo é facilitar a reescrita durante o formulario e carregamento conforme altera os dados
  var _paramsDoctorAndHors = ParamsToNavigationPage();

  @override
  String screenName() => 'reschedule'.tr;

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
      _paramsDoctorAndHors = ParamsToNavigationPage.fromMap(_params.toMap());
      _controller.searchListDoctors(_params);
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
        child: AnimatedFromColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Obx(() {
                    return AppDropdownWidgetSearchImpl(
                      items: _controller.listDoctorSchedule.map((e) => e.descricao?.toUpperCase()).toList(),
                      onChanged: (dynamic filter) async {
                        if (filter != null) {
                          var _list = _controller.listDoctorSchedule.firstWhere((e) => e.descricao?.toLowerCase() == filter?.toLowerCase());
                          _paramsDoctorAndHors = _paramsDoctorAndHors.copyWith(doutorId: _list.id, nomeDoMedico: _list.descricao, profissionalId: _list.profissionalId);
                          await _controller.changeDoctorAndDate(_paramsDoctorAndHors);
                        }
                      },
                      selectedItem: _controller.selectedItemDoctor.value,
                      validator: AppValidators.required(),
                      onSaved: (dynamic filter) {
                        if (filter != null) {
                          var _list = _controller.listDoctorSchedule.firstWhere((e) => e.descricao?.toLowerCase() == filter?.toLowerCase());
                          _newModelDetails = _newModelDetails.copyWith(nameDoctor: _list.descricao);
                        }
                      },
                      labelText: 'Responsável'.toUpperCase(),
                      hintText: 'Responsável',
                    );
                  }),
                  SizedBox(height: 10),
                  Obx(() {
                    _controller.loadingListDoctorCommittedHors.value;
                    return AppDateTime(
                      key: ValueKey(_controller.initialValueDateTime.value),
                      resetIcon: null,
                      label: 'Data do Agendamento'.toUpperCase(),
                      hintText: 'Data do Agendamento',
                      enabled: true,
                      initialValue: _controller.initialValueDateTime.value,
                      onChanged: (data) async {
                        if (data != null) {
                          var _dataSearch = FormatsDatetime.formatDate(data, FormatsDatetime.yearMonthDay);
                          _paramsDoctorAndHors = _paramsDoctorAndHors.copyWith(dataDoFiltroDePesquisa: _dataSearch);
                          await _controller.changeDoctorAndDate(_paramsDoctorAndHors);
                        }
                      },
                      timer: false,
                      allowBefore: true,
                      allowAfter: true,
                      suffix: Icon(Icons.date_range_outlined, color: ConstColors.blue),
                      validator: AppValidators.dateRequired(),
                      onSaved: (d) {
                        if (d != null) {
                          // var _data = FormatsDatetime.formatDate(d, FormatsDatetime.dateFormat);
                          var _d = d.add(Duration(hours: -3));
                          _newModelDetails = _newModelDetails.copyWith(date: _d.toUtc().toIso8601String());
                        }
                      },
                    );
                  }),
                  Obx(() {
                    if (_controller.loadingListDoctorCommittedHors.value) {
                      return ShimmerNewAppointment();
                    }
                    if (_controller.listDoctorCommittedHors.isEmpty) {
                      return Container(
                        height: view.localWidgetSize!.height,
                        alignment: Alignment.center,
                        child: AppNotHasdata(visibleOnPressed: false),
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        DoctorCommitmentExt _model = _controller.listDoctorCommittedHors[index];
                        return Container(
                          color: ConstColors.white,
                          child: ListTile(
                            onTap: () async {
                              var formValid = _formKey.currentState?.validate() ?? false;
                              if (formValid) {
                                _formKey.currentState?.save();
                                _newModelDetails = _newModelDetails.copyWith(hora: _model.hourFormatStart);
                                _modelRequestServer = _modelRequestServer.copyWith(novoAgendamentoId: _model.id);

                                // _commitementDetails
                                await Navigator.of(context).push<void>(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => ModalReschedule(
                                      newModelDetails: _newModelDetails,
                                      requestReschedule: _modelRequestServer,
                                      modelCommitementDetails: _commitementDetails,
                                      params: _params,
                                    ),
                                    fullscreenDialog: true,
                                  ),
                                );
                              }
                            },
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            title: Text(_model.hourFormatStart),
                            trailing: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).colorScheme.secondary),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Container(height: 5),
                      itemCount: _controller.listDoctorCommittedHors.length,
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
