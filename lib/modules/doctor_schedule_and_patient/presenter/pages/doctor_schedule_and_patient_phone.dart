import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/calendar/date_strip_widget.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';
import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_bottom_navigator.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/infra/models/doctor_schedule_and_patient_ext.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/presenter/controllers/doctor_schedule_and_patient_controller.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/presenter/widgets/shimmer_doctor_schedule_and_patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '/core/animation/animated_from_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorScheduleAndPatientPhone extends StatefulWidget {
  DoctorScheduleAndPatientPhone({Key? key}) : super(key: key);

  @override
  _DoctorScheduleAndPatientPhoneState createState() => _DoctorScheduleAndPatientPhoneState();
}

class _DoctorScheduleAndPatientPhoneState extends State<DoctorScheduleAndPatientPhone> with WidgetsBindingObserver {
  final _controller = Get.find<DoctorScheduleAndPatientController>();
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getFirstPageAndPatient(true);
      scrollController.addListener(() {
        _controller.onScrollAndPatient(scrollController.position.pixels, scrollController.position.maxScrollExtent);
      });
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: ConstColors.backgroundDefault,
      bottomNavigationBar: AppBottomNavigationBar(),
      body: SafeArea(
        child: AppScaffold(
          backgroundColor: ConstColors.backgroundDefault,
          appBar: AppBarDefault.bar(
            actions: <Widget>[
              IconButton(icon: const Icon(Icons.calendar_today), onPressed: () async => await _controller.selectDateTimeCalendarAndPatient(context)),
            ],
            title: Obx(
              () => Text(
                FormatsDatetime.stringMesYear(_controller.selectedDateDoctorAndPatient.value).toUpperCase(),
                style: GoogleFonts.openSans(
                  color: ConstColors.cinza,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.spEx,
                ),
                key: ValueKey("0088${_controller.selectedDateDoctorAndPatient.value}"),
              ),
            ),
          ),
          body: ResponsiveBuilder(builder: (context, view) {
            return RefreshIndicator(
              onRefresh: () async => await _controller.swipeRefreshAndPatient(),
              child: CupertinoScrollbar(
                thumbVisibility: false,
                controller: scrollController,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: scrollController,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AnimatedFromColumn(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() {
                          return Container(
                            key: ValueKey("0099${_controller.selectedDateDoctorAndPatient.value}"),
                            child: DateStripWidget(
                              selectedDate: _controller.selectedDateDoctorAndPatient.value,
                              onDateSelected: (dateSearch) async {
                                _controller.selectedDateDoctorAndPatient.value = dateSearch;
                                await _controller.selectDateTimeAndPatient(dateSearch);
                              },
                            ),
                          );
                        }),
                        const SizedBox(height: 20),
                        Obx(() {
                          if (_controller.isLoading.value == AppLoadingStatus.notConnecting) {
                            return Container(
                              height: view.localWidgetSize!.height,
                              alignment: Alignment.center,
                              child: AppNotHasdata(loadData: () async => await _controller.getFirstPageAndPatient(true)),
                            );
                          }
                          if ((_controller.isLoading.value == AppLoadingStatus.notLoading) || (_controller.isLoading.value == AppLoadingStatus.nextPageLoading)) {
                            if (_controller.listDoctorScheduleAndPatient.isEmpty) {
                              return Container(
                                height: view.localWidgetSize!.height,
                                alignment: Alignment.center,
                                child: AppNotHasdata(loadData: () async => await _controller.getFirstPageAndPatient(true)),
                              );
                            }
                            return ListItemPatient(_controller.listDoctorScheduleAndPatient);
                          } else {
                            if (_controller.isLoading.value == AppLoadingStatus.shimmerLoading) {
                              return ShimmerDoctorScheduleAndPatient();
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

class ListItemPatient extends StatelessWidget {
  final List<DoctorScheduleAndPatientExt> listPatient;

  ListItemPatient(this.listPatient, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        final DoctorScheduleAndPatientExt _model = listPatient[index];
        String? _cor = _model.agendaStatus?.cor?.replaceAll('#', '').toUpperCase() ?? null;
        String? _string = _cor != null && _cor != '' ? "0xFF$_cor" : null;
        int? _corFormat = _string != null ? int.parse(_string.toString()) : null;
        Color _borderCard = _corFormat != null ? Color(_corFormat) : Color(0xFFB6B9D0);

        return Card(
          key: ValueKey(_model.id),
          elevation: 0,
          child: ClipPath(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(border: Border(left: BorderSide(color: _borderCard, width: 5.wEx))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${_model.hourFormatStart}', style: TextStyle(color: _borderCard, fontSize: 20.spEx, fontWeight: FontWeight.bold)),
                      Flexible(
                        child: Text(
                          _model.agendaStatus?.descricao?.trim().toUpperCase() ?? "no_value".tr,
                          style: TextStyle(color: _borderCard, fontSize: 10.spEx, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Color(0xFFEEEEEE), thickness: 1),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('schedule'.tr.toUpperCase(), style: TextStyle(color: Color(0xFF656565), fontSize: 10.spEx, fontWeight: FontWeight.w400)),
                      Text(
                        _model.agendaConfig?.descricao?.trim().toUpperCase() ?? "no_value".tr,
                        style: TextStyle(color: Color(0xFF656565), fontSize: 12.spEx, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.hEx),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('patient'.tr.toUpperCase(), style: TextStyle(color: Color(0xFF656565), fontSize: 10.spEx, fontWeight: FontWeight.w400)),
                      Text(
                        _model.paciente?.nome?.trim().toUpperCase() ?? "no_value".tr,
                        style: TextStyle(color: Color(0xFF656565), fontSize: 12.spEx, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.hEx),
                ],
              ),
            ),
            clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.rEx))),
          ),
        );
      },
      itemCount: listPatient.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // separatorBuilder: (_, index) => Divider(),
    );
  }
}
