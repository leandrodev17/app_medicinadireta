import 'package:get/get.dart';

import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/patient_alert/external/datasources/patient_alert_datasource_impl.dart';
import 'package:medicinadireta/modules/patient_alert/infra/models/patient_alert_model.dart';

class PatientAlertController extends GetxController {
  final PatientAlertDatasourceImpl request;
  final CheckConnectingNetwork checkConnecting;

  PatientAlertController(this.request, this.checkConnecting);

  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);
  // final RxList<PatientAlertModel> listPatientAlerts = RxList<PatientAlertModel>();
  final RxMap<String, List<PatientAlertModel>> listPatientAlerts = RxMap<String, List<PatientAlertModel>>();

  RxInt abaAlert = RxInt(99);

  Future<dynamic> getFirstPage(int? patientId) async {
    isLoading.value = AppLoadingStatus.shimmerLoading;
    listPatientAlerts.clear();
    await _getFindPatientAlert(patientId);
  }

// Informação(Azul)
// Alerta(Amarelo)
// Crítico(Vermelho)
// Alérgico(Rosa)
  Map<String, String> titleAlerts = {"info": "INFORMAÇÃO", "warning": "ALERTA", "crit": "CRÍTICO", "alergia": "ALERGIA"};
  Map<String, int> coresAlerts = {"info": 0xFF67B1FF, "warning": 0xFFF9BA00, "crit": 0xFFFF4F4F, "alergia": 0xFFA674FF};

  void changeAbaAlert(int index) {
    if (abaAlert.value == index) {
      abaAlert.value = 99;
    } else {
      abaAlert.value = index;
    }
  }

  _getFindPatientAlert(int? patientId) async {
    try {
      final bool check = await checkConnecting.appCheckConnectivity();
      if (!check) {
        await AppAlert.alertWarning(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 5);
        isLoading.value = AppLoadingStatus.notLoading;
        return;
      }
      var parameters = QueryParameters(filter: "pacienteId eq $patientId", count: true);

      if (patientId == null) {
        await AppAlert.alertWarning(title: "Oops!", body: "Identificamos um problema nos dados da requisição, por favor, recarregue a tela e tente novamente!", seconds: 5);
        isLoading.value = AppLoadingStatus.notLoading;
        return;
      }

      final resp = await request.listAlertPatientDatasource(parameters);
      if (resp.statusCode != 200) {
        await AppAlert.alertWarning(title: 'Oops!', body: resp.errorMessage.toString());
        isLoading.value = AppLoadingStatus.notLoading;
        return;
      }

      if (resp.model != null) {
        Map<String, List<PatientAlertModel>> _data = <String, List<PatientAlertModel>>{};

        for (var i = 0; i < resp.model!.length; i++) {
          PatientAlertModel _itens = resp.model![i] as PatientAlertModel;
          String avisoTipo = _itens.avisoTipo ?? '-';

          if (!_data.containsKey(avisoTipo)) {
            _data[avisoTipo] = [_itens];
          } else {
            List<PatientAlertModel>? _old = _data[avisoTipo];
            _old?.add(_itens);
            _data[avisoTipo] = _old!;
          }
        }
        listPatientAlerts.addAll(_data);
      }
      // AppLog.i("${listPatientAlerts.toJson()}");
      isLoading.value = AppLoadingStatus.notLoading;
    } catch (e) {
      AppLog.d('Problema para listar os dados do paciente ===> $e', name: 'getFindPatient');
      isLoading.value = AppLoadingStatus.notLoading;
      AppAlert.alertError(title: 'Oops!', body: 'Problema para listar os alertas do paciente - $e');
    }
  }
}
