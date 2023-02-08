import 'dart:convert';

import 'package:get/get.dart';

import '../../external/datasource/anthropometry_datasource_impl.dart';
import '../../infra/models/anthropometry_model.dart';
import '/constants/const_strings.dart';
import '/core/alert/app_alert.dart';
import '/core/enum/app_loading_status.dart';
import '/core/helpers/formats_datetime.dart';
import '/core/network/check_connecting_network.dart';
import '/core/shared/shared_preferences.dart';
import '/core/widgets/app_log.dart';

class AnthropometryController extends GetxController {
  final AnthropometryDatasourceImpl request;
  final CheckConnectingNetwork connectingNetwork;
  final SharedPreferencesHelper sharedPreferencesHelper;

  AnthropometryController({required this.connectingNetwork, required this.request, required this.sharedPreferencesHelper});
  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);

  RxList<AnthropometryModel> listAnthropometry = RxList<AnthropometryModel>();
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

  bool isEditAllergys({int? userId, String? edit}) {
    try {
      if (userId == null || edit == null) return false;
      if (storageUserId.value != 0 && edit == "S" && userId == storageUserId.value) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  String dateFormatAllergy(String? dataLocal) {
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
    listAnthropometry.clear();
    await _getDataAnthropometry(pacienteId);
  }

  swipeRefresh(int? patientId) async {
    await getFirst(isFirst: true, pacienteId: patientId);
  }

  _getDataAnthropometry(int? patientId) async {
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

      var response = await request.findAllAnthropometryDatasource(patientId);
      bool status = response.statusCode == 200;

      if (!status) {
        isLoading.value = AppLoadingStatus.notLoading;
        await AppAlert.alertError(title: "Oops!", body: 'Problema para listar os dados ${response.statusCode} ${response.statusMessage}', seconds: 15);
        return;
      }

      listAnthropometry.clear();
      if (response.model?.isNotEmpty ?? false) {
        List<AnthropometryModel>? _data = response.model as List<AnthropometryModel>;
        if (_data.isNotEmpty) listAnthropometry.addAll(_data);
      }
      isLoading.value = AppLoadingStatus.notLoading;
    } catch (e, s) {
      isLoading.value = AppLoadingStatus.notLoading;
      AppLog.d("Não foi possível listar os registros Anthropometry, $e", name: "_getDataAnthropometry", stackTrace: s);
      await AppAlert.alertWarning(title: "Oops!", body: 'Não foi possível listar os dados $e', seconds: 5);
    }
  }
}
