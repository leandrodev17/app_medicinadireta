import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/constants/const_drawables.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/calendar/date_strip_widget.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_button_elevated.dart';
import 'package:medicinadireta/core/widgets/app_not_connecting.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/doctor_schedule/presenter/widgets/item_grid_doctor_schedule.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/doctor_commitment_ext.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/controllers/list_appointment_controller.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/presenter/widgets/shimmer_new_appointment.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ListAppointmentPhone extends StatefulWidget {
  ListAppointmentPhone({Key? key}) : super(key: key);

  @override
  _ListAppointmentPhoneState createState() => _ListAppointmentPhoneState();
}

class _ListAppointmentPhoneState extends State<ListAppointmentPhone> with WidgetsBindingObserver {
  final _controller = Get.find<ListAppointmentController>();
  final _scrollController = ScrollController();

  // Parametros de navegação entre telas para facilitar a o cadastro da consulta
  ParamsToNavigationPage _paramsNavigator = Get.arguments;

  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _dateTime = _paramsNavigator.dataDoFiltroDePesquisa != null ? DateTime.parse(_paramsNavigator.dataDoFiltroDePesquisa!) : DateTime.now();
      _controller.getFirstPage(_paramsNavigator, _dateTime);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: ConstColors.backgroundDefault,
      onWillPop: () async => await Future.value(true),
      bottomNavigationBar: AppBottomNavigationBar(),
      body: SafeArea(
        child: AppScaffold(
          backgroundColor: ConstColors.backgroundDefault,
          appBar: AppBarDefault.bar(
            backIcon: ConstDrawables.appIconBackClose,
            leadingSizeIcon: 30,
            leadingColors: ConstColors.graphite,
            title: Text(
              'Inserir consulta',
              style: GoogleFonts.openSans(
                color: ConstColors.graphite,
                fontWeight: FontWeight.w500,
                fontSize: 18.spEx,
              ),
            ),
            actions: [
              AppButtonElevated(
                onPressed: () async => await Get.toNamed(Routes.NEW_MEDICAL_APPOINTMENT, arguments: [_paramsNavigator, DoctorCommitmentExt()], parameters: {"snap": "1"}),
                child: Row(
                  children: [
                    Text(
                      'Encaixe',
                      style: GoogleFonts.openSans(fontSize: 14.spEx, color: ConstColors.orange, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ],
          ),
          body: ResponsiveBuilder(builder: (context, view) {
            return RefreshIndicator(
              onRefresh: () async => await _controller.swipeRefresh(_paramsNavigator, _dateTime),
              child: CupertinoScrollbar(
                thumbVisibility: false,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  controller: _scrollController,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: AnimatedFromColumn(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() {
                          return Container(
                            key: ValueKey(_controller.selectedDateAppointment.value),
                            child: DateStripWidget(
                              selectedDate: _controller.selectedDateAppointment.value,
                              onDateSelected: (dateSearch) async {
                                _paramsNavigator = _paramsNavigator.copyWith(dataDoFiltroDePesquisa: dateSearch.toString());
                                _controller.getFirstPage(_paramsNavigator, dateSearch);
                              },
                            ),
                          );
                        }),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'schedule_available'.tr,
                            style: GoogleFonts.openSans(color: ConstColors.graphite, fontWeight: FontWeight.w500, fontSize: 14.spEx),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Obx(() {
                          if (_controller.isLoading.value == AppLoadingStatus.notConnecting) {
                            return Container(
                              height: view.localWidgetSize!.height,
                              alignment: Alignment.center,
                              child: AppNotConnecting(loadData: () async => await _controller.getFirstPage(_paramsNavigator, _dateTime)),
                            );
                          }
                          if ((_controller.isLoading.value == AppLoadingStatus.notLoading) || (_controller.isLoading.value == AppLoadingStatus.nextPageLoading)) {
                            if (_controller.listAppointment.isEmpty) {
                              return Container(
                                height: view.localWidgetSize!.height,
                                alignment: Alignment.center,
                                child: AppNotHasdata(loadData: () async => await _controller.getFirstPage(_paramsNavigator, _dateTime)),
                              );
                            }

                            return GestureDetector(
                              onTap: () {},
                              child: GridView.builder(
                                itemBuilder: (_, index) {
                                  DoctorCommitmentExt model = _controller.listAppointment[index];
                                  return Container(
                                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: ConstColors.scheduleGridColor,
                                      border: Border.all(width: 1.0, color: ConstColors.scheduleGridColorText),
                                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: ItemGridDoctorSchedule(
                                      label: model.hourFormatStart.toString(),
                                      onTab: () async => await Get.toNamed(Routes.NEW_MEDICAL_APPOINTMENT, arguments: [_paramsNavigator, model], parameters: {"snap": "0"}),
                                    ),
                                  );
                                },
                                itemCount: _controller.listAppointment.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisExtent: 70),
                              ),
                            );
                          } else {
                            if (_controller.isLoading.value == AppLoadingStatus.shimmerLoading) {
                              return ShimmerNewAppointment();
                            } else {
                              return Container(child: CupertinoActivityIndicator());
                            }
                          }
                        }),
                        Obx(() {
                          return Visibility(
                            visible: _controller.isLoading.value == AppLoadingStatus.nextPageLoading,
                            child: Padding(padding: EdgeInsets.all(20), child: CupertinoActivityIndicator()),
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
