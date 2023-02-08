import 'dart:convert';

import 'package:medicinadireta/constants/const_strings.dart';
import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/params_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/evolution_ext.dart';
import 'package:get/get.dart';

import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/external/datasource/evolution_datasource_impl.dart';

class EvolutionController extends GetxController {
  final EvolutionDatasourceImpl request;
  final CheckConnectingNetwork connecting;
  final SharedPreferencesHelper shared;

  EvolutionController({required this.request, required this.connecting, required this.shared});

  final RxList<EvolutionExt> listEvolution = RxList<EvolutionExt>();

  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);

  final RxInt storageUserId = RxInt(0);

  @override
  void onInit() async {
    await loadInfoUserStorage();
    super.onInit();
  }

  // final RxInt indexOpenList = RxInt(99999);
  // openItemCardEvolution(int index) {
  //   indexOpenList.value = index;
  //   var _modelOld = listEvolution[index];
  //   EvolutionExt _modelUpdate = _modelOld;
  //   listEvolution.removeAt(index);
  //   listEvolution.insert(index, _modelUpdate);
  // }

  loadInfoUserStorage() async {
    String? _data = await SharedPreferencesHelper().getDataCurrentAccess;
    if (_data != null && _data != ConstStrings.appValueNull) {
      var _user = jsonDecode(_data);
      storageUserId.value = _user["id"];
    }
  }

  bool isEditEvolucao({int? userId, String? edit}) {
    print('${storageUserId.value} userId: $userId edit $edit');
    try {
      if (userId == null || edit == null) return false;
      if (storageUserId.value != 0 && edit == "S" && userId == storageUserId.value) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  getFirstPage({required int patientId}) async {
    isLoading.value = AppLoadingStatus.shimmerLoading;
    listEvolution.clear();
    await _getPage(patientId: patientId);
  }

  swipeRefresh({required int patientId}) async {
    await getFirstPage(patientId: patientId);
  }

  _getPage({required int patientId}) async {
    try {
      final isConnecting = await connecting.appCheckConnectivity();

      if (!isConnecting) {
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 15);
        return;
      }

      var _params = ParamsEvolution(orderBy: "id desc", expand: "Profissional(\$expand=Conselho)");
      final _response = await request.evolutionDatasource(_params, patientId);

      if (_response.statusCode != 200) {
        await AppAlert.alertError(title: "Oops!", body: 'Não foi possível listar os dados', seconds: 5);
        isLoading.value = AppLoadingStatus.notLoading;
      }

      if (_response.model?.isNotEmpty ?? false) {
        listEvolution.clear();
        listEvolution.addAll(_response.model!);
      }
      isLoading.value = AppLoadingStatus.notLoading;
    } catch (e) {
      AppLog.d('Não foi possível listar as evoluções do usuário $e', name: '_getPage');
      isLoading.value = AppLoadingStatus.notLoading;
      await AppAlert.alertError(title: "Oops!", body: 'Não foi possível listar os dados', seconds: 5);
    }
  }
}
