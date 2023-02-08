import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/medical.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/domain/entities/exams_entitie.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/external/datasource/exams_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/infra/models/exams_model.dart';
import 'package:medicinadireta/routes/app_pages.dart';

import '/constants/const_strings.dart';
import '/core/alert/app_alert.dart';
import '/core/enum/app_loading_status.dart';
import '/core/helpers/formats_datetime.dart';
import '/core/models/request/query_parameters.dart';
import '/core/network/check_connecting_network.dart';
import '/core/shared/shared_preferences.dart';
import '/core/widgets/app_log.dart';
import '/modules/patient_information/submodules/allergy/domain/entities/allergy.dart';
import '/modules/patient_information/submodules/allergy/external/datasource/allergy_datasource_impl.dart';

class ExamsController extends GetxController {
  final ExamsDatasourceImpl request;
  final CheckConnectingNetwork connectingNetwork;
  final SharedPreferencesHelper sharedPreferencesHelper;

  ExamsController({required this.connectingNetwork, required this.request, required this.sharedPreferencesHelper});
  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);

  RxList<ExamsModel> listExams = RxList<ExamsModel>();
  final RxInt isExpandedIndex = RxInt(9999);
  final RxInt storageUserId = RxInt(0);

  void Function(int, bool)? expansionCallback(int index, bool isExpanded) {
    if (isExpanded) {
      isExpandedIndex.value = 9999;
    } else {
      isExpandedIndex.value = index;
    }
    return null;
  }
loadInfoUserStorage() async {
    String? data = await sharedPreferencesHelper.getDataCurrentAccess;
    if (data != null && data != ConstStrings.appValueNull) {
      var user = jsonDecode(data);
      storageUserId.value = user["id"];
    }
  }
    bool isEditExams({int? userId, String? edit}) {
    try {
      if (userId == null || edit == null) return false;
      if (storageUserId.value != 0 && edit == "S" && userId == storageUserId.value) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

   String dateFormatExams(String? dataLocal) {
    try {
      if (dataLocal == null) return "--";
      DateTime dateTime = DateTime.parse(dataLocal.toString());
      String formatDate = FormatsDatetime.formatDate(dateTime, FormatsDatetime.dateHourFormat);
      return formatDate;
    } catch (e) {
      return "--";
    }
  }

  getFirst({isFirst = false, int? pacienteId}) async {
    if (isFirst) {
      isLoading.value = AppLoadingStatus.shimmerLoading;
    } else {
      isLoading.value = AppLoadingStatus.fullLoading;
    }
    listExams.clear();
    await _getDataExams(pacienteId);
  }

  swipeRefresh(int? patientId) async {
    await getFirst(isFirst: true, pacienteId: patientId);
  }

  _getDataExams(int? patientId) async {
    try {
      bool isConnected = await connectingNetwork.appCheckConnectivity();
      if (!isConnected) {
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }

      if (patientId == null) {
        isLoading.value = AppLoadingStatus.notLoading;
        await AppAlert.alertError(title: "Oops!", body: 'Problema para identificar o paciente, tente recarregar a página', seconds: 15);
        return;
      }

      var paramts = QueryParameters(expand: "Profissional(\$select=nome)");
      var response = await request.findAllExamsDatasource(patientId, QueryParameters());

      bool status = response.statusCode == 200;

      if (!status) {
        isLoading.value = AppLoadingStatus.notLoading;
        await AppAlert.alertError(title: "Oops!", body: 'Problema para listar os dados ${response.statusCode} ${response.statusMessage}', seconds: 15);
        return;
      }

      listExams.clear();
      if (response.model?.isNotEmpty ?? false) {
        List<ExamsModel>? _data = response.model as List<ExamsModel>;
        if (_data.isNotEmpty) listExams.addAll(_data);
      }
      isLoading.value = AppLoadingStatus.notLoading;
    } catch (e, s) {
      isLoading.value = AppLoadingStatus.notLoading;
      AppLog.d("Não foi possível listar os registros cadastrados da receita, $e", name: "_getDataExams", stackTrace: s);
      await AppAlert.alertWarning(title: "Oops!", body: 'Não foi possível listar os dados $e', seconds: 5);
    }
  }
}
