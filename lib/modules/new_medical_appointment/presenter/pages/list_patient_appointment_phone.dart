import 'dart:typed_data';

import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/animation/animated_from_column.dart';
import 'package:medicinadireta/core/drawer/search.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/helpers/helpers.dart';
import 'package:medicinadireta/core/models/patient/patient_model_ext.dart';
import 'package:medicinadireta/core/responsive/responsive_builder.dart';
import 'package:medicinadireta/core/widgets/app_not_hasdata.dart';
import 'package:medicinadireta/core/widgets/card_list_patient_finance.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_scaffold.dart';
import 'package:medicinadireta/modules/new_medical_appointment/presenter/controller/new_medical_appointment_controller.dart';
import 'package:medicinadireta/modules/patient/presenter/widgets/shimmer_patient.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class ListPatientAppointmentPhone extends StatefulWidget {
  const ListPatientAppointmentPhone({Key? key}) : super(key: key);

  @override
  _ListPatientAppointmentPhoneState createState() => _ListPatientAppointmentPhoneState();
}

class _ListPatientAppointmentPhoneState extends State<ListPatientAppointmentPhone> with WidgetsBindingObserver {
  final _scrollController = ScrollController();
  final _controller = Get.find<NewMedicalAppointmentController>();
  final _debouncer = Debouncer(delay: const Duration(seconds: 1));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.controllerListPatient.listPatientSearch.clear();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: ConstColors.backgroundDefault,
      body: SafeArea(
        child: AppScaffold(
          backgroundColor: ConstColors.backgroundDefault,
          appBar: AppBarDefault.bar(titleApp: 'patients'),
          body: ResponsiveBuilder(builder: (context, view) {
            return CupertinoScrollbar(
              controller: _scrollController,
              thumbVisibility: false,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(3),
                controller: _scrollController,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AnimatedFromColumn(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Search(
                        onPressed: () => _controller.controllerListPatient.searchPatient(),
                        onChanged: (data) {
                          _controller.controllerListPatient.onChangeSearchPatient(data);
                          _debouncer(() async {
                            if (data != '' && data.length > 3) {
                              await _controller.controllerListPatient.searchPatient(findPatientToNewAppointment: true);
                            } else {
                              _controller.controllerListPatient.isLoading.value = AppLoadingStatus.notLoading;
                            }
                          });
                        },
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "search_patient".tr,
                      ),
                      const SizedBox(height: 10),
                      Obx(() {
                        if (_controller.controllerListPatient.isLoading.value == AppLoadingStatus.searchLoading) {
                          if (_controller.controllerListPatient.isLoadingSearch.value) return const ShimmerPatient();
                          if (_controller.controllerListPatient.listPatientSearch.isEmpty) {
                            return Container(
                              height: view.localWidgetSize!.height,
                              alignment: Alignment.center,
                              child: AppNotHasdata(message: "Não foi possível localizar o paciente, por favor, verifique o nome informado.", visibleOnPressed: false),
                            );
                          }
                          return ListItemPatientAppointment(_controller.controllerListPatient.listPatientSearch, _controller);
                        } else {
                          return Container(
                            height: view.localWidgetSize!.height,
                            alignment: Alignment.center,
                            child: AppNotHasdata(message: "Por favor, informe o nome do paciente no campo de pesquisa.", visibleOnPressed: false),
                          );
                        }
                      }),
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
}

class ListItemPatientAppointment extends StatelessWidget {
  final List<PatientModelExt> listPatient;
  final NewMedicalAppointmentController controller;
  const ListItemPatientAppointment(this.listPatient, this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        final PatientModelExt model = listPatient[index];
        var prontuario = model.prontuario ?? "no_value".tr;
        var name = model.nome ?? "no_value".tr;
        Uint8List? foto = Helpers.convertBase64MemoryImage(model.fotoBase64);
        return CardListPatientFinance(
          foto: foto,
          key: ValueKey(model.id),
          name: name,
          prontuario: prontuario.toString(),
          onTap: () async => controller.setValuePatient(model),
          isAddAppointment: true,
        );
      },
      itemCount: listPatient.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}
