import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/calendar/date_strip_widget.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/widgets/animate_expanded.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_not_connecting.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/commitement_details.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/controllers/doctor_commitment_controller.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/widgets/app_bar_doctor_commitment.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/widgets/shimmer_doctor_commitment.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class DoctorCommitmentPhone extends StatefulWidget {
  DoctorCommitmentPhone({Key? key}) : super(key: key);

  @override
  _DoctorCommitmentPhoneState createState() => _DoctorCommitmentPhoneState();
}

class _DoctorCommitmentPhoneState extends State<DoctorCommitmentPhone> with WidgetsBindingObserver {
  final DoctorCommitmentController _controller = Get.find<DoctorCommitmentController>();

  // Parametros de navegação entre telas para facilitar a o cadastro da consulta
  ParamsToNavigationPage _params = Get.arguments;

  bool isExpandedTest = false;
  double h = 100;

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.selectedDate.value = _params.dataDoFiltroDePesquisa != null ? DateTime.parse(_params.dataDoFiltroDePesquisa!) : DateTime.now();
      _params = _params.copyWith(dataDoFiltroDePesquisa: _controller.selectedDate.value.toString());
      _controller.getFirstPage(_params);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: ConstColors.backgroundDefault,
      onWillPop: () async => await Get.toNamed(Routes.DOCTOR_ACHEDULE),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      bottomNavigationBar: AppBottomNavigationBar(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 65),
        child: FloatingActionButton(
          onPressed: () => _controller.onPressedAppointment(_params),
          backgroundColor: ConstColors.orange,
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: AppScaffold(
          backgroundColor: ConstColors.backgroundDefault,
          appBar: appBarDoctorCommitment(
            context,
            _controller,
            nameDoctor: _params.nomeDoMedico ?? '',
            onSelectCalendar: () => _controller.selectDateTime(context, _params),
          ),
          body: ResponsiveBuilder(builder: (context, view) {
            return RefreshIndicator(
              onRefresh: () async => await _controller.swipeRefresh(_params),
              child: CupertinoScrollbar(
                thumbVisibility: false,
                controller: scrollController,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(3),
                  controller: scrollController,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AnimatedFromColumn(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: ClipPath(
                            clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                            child: Container(
                                decoration: BoxDecoration(border: Border(left: BorderSide(color: Color(_controller.formatColor(_params.cardColor)), width: 8))),
                                child: ListTile(
                                  minVerticalPadding: 8,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                  dense: false,
                                  horizontalTitleGap: 30,
                                  title: Text(
                                    _params.nomeDoMedico?.toUpperCase().trim() ?? '--',
                                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 14.spEx, fontWeight: FontWeight.w500, color: ConstColors.graphite),
                                  ),
                                )),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(() {
                          return Container(
                            // height: 100,
                            key: ValueKey(_controller.selectedDate.value),
                            child: DateStripWidget(
                              selectedDate: _controller.selectedDate.value,
                              onDateSelected: (dateSearch) async {
                                _controller.selectedDate.value = dateSearch;
                                _params = _params.copyWith(dataDoFiltroDePesquisa: dateSearch.toString());
                                await _controller.searchByDayCommitment(_params, dateSearch);
                              },
                            ),
                          );
                        }),
                        Obx(() {
                          if (_controller.isLoading.value == AppLoadingStatus.notConnecting) {
                            return Container(
                              height: view.localWidgetSize!.height,
                              alignment: Alignment.center,
                              child: AppNotConnecting(loadData: () async => await _controller.getFirstPage(_params)),
                            );
                          }
                          if ((_controller.isLoading.value == AppLoadingStatus.notLoading) || (_controller.isLoading.value == AppLoadingStatus.nextPageLoading)) {
                            if (_controller.listPatientDetails.isEmpty) {
                              return Container(
                                height: view.localWidgetSize!.height,
                                alignment: Alignment.center,
                                child: AppNotHasdata(loadData: () async => await _controller.getFirstPage(_params)),
                              );
                            }
                            return ListView.builder(
                              itemCount: _controller.listPatientDetails.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              // separatorBuilder: (_, index) => Divider(),
                              itemBuilder: (_, index) {
                                CommitementDetails _model = _controller.listPatientDetails[index];
                                var _title = _model.titulo != null ? _model.titulo : '--';
                                var _description = _model.descricao != null ? _model.descricao : '--';

                                var _dataSearch = FormatsDatetime.formatDate(_controller.selectedDate.value, FormatsDatetime.yearMonthDay);
                                // var _dataSearchModel = FormatsDatetime.formatDate(_controller.selectedDate.value, FormatsDatetime.dateFormat);
                                // ParamsNavigator(doctorId: _model.id, nameDoctor: _model.descricao, profissionalId: _model.profissionalId),
                                var _newParams = ParamsToNavigationPage(
                                  doutorId: _params.doutorId,
                                  nomeDoMedico: _params.nomeDoMedico,
                                  dataDoFiltroDePesquisa: _dataSearch,
                                  pacienteId: _model.pacienteId,
                                  profissionalId: _model.profissionalId,
                                  agendaConfigId: _model.agendaConfigId,
                                  organizacaoId: _model.organizacaoId,
                                  agendamentoId: _model.id,
                                  email: _model.mail,
                                  horaDoAgendamento: _model.hourFormatStart,
                                  idade: _model.age,
                                  nomeDoPaciente: _model.name,
                                  numeroDoProtuario: _model.numberProntuario,
                                  observacaoDoAgendamento: _description,
                                  agendaStatusId: _model.agendaStatusId,
                                  telefone: _model.phone,
                                  tituloDaConsulta: _title,
                                  voltarParaPagina: Routes.DOCTOR_ACHEDULE,
                                );

                                return AnimateExpanded(model: _model, params: _newParams, controller: _controller, indexList: index);
                              },
                            );
                          } else {
                            if (_controller.isLoading.value == AppLoadingStatus.shimmerLoading) {
                              return ShimmerDoctorCommitment();
                            } else {
                              return Container(child: CupertinoActivityIndicator());
                            }
                          }
                        }),
                        Obx(() {
                          return Visibility(
                            visible: _controller.isLoading.value == AppLoadingStatus.nextPageLoading,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: CupertinoActivityIndicator(),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
