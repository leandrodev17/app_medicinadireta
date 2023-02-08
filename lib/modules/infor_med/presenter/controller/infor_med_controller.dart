import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/enum/app_loading_status.dart';
import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/infor_med/domain/entities/contents_info_med.dart';
import 'package:medicinadireta/modules/infor_med/external/datasource/info_med_datasource_impl.dart';
import 'package:get/get.dart';

class InforMedController extends GetxController {
  final InfoMedDatasourceImpl datasourceImpl;
  final SharedPreferencesHelper sharedPreferences;
  final CheckConnectingNetwork checkConnecting;

  InforMedController({required this.datasourceImpl, required this.checkConnecting, required this.sharedPreferences});
  static const SPECIALTY_TODOS = "TODOS";
  static const SPECIALTY_ADULTO = "ADULTO";
  static const SPECIALTY_PEDIATRIA = "PEDIATRIA";

  @override
  void onInit() async {
    await _auth();
    super.onInit();
  }

  @override
  void dispose() {
    print("dispose ok");
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final RxBool  filterAllCategory = RxBool(false);

  List<Map<String, dynamic>> listSortItem = [
    {"id": "recentes", "value": "Mais recentes", "visible": false},
    {"id": "antigos", "value": "Mais antigos", "visible": false},
    {"id": "autores-asc", "value": "Autores de A-Z", "visible": false},
    {"id": "autores-des", "value": "Autores de Z-A", "visible": false},
    {"id": "titulo-asc", "value": "Títulos de A-Z", "visible": false},
    {"id": "titulo-des", "value": "Títulos de Z-A", "visible": false},
  ];

  /// Filtros
  RxList<Map<String, dynamic>> filterCategory = RxList<Map<String, dynamic>>([
    {"id": "diagnostico_e_tratamento", "value": "Diagnostico e Tratamento", "visible": true},
    {"id": "artigo", "value": "Artigo", "visible": true},
    {"id": "capitulo", "value": "Capitulo", "visible": true},
    {"id": "consulta_rapida_e_recomendacoes", "value": "Consulta Rapida e Recomendações", "visible": true},
    {"id": "aula", "value": "Aula", "visible": true},
    {"id": "podcast", "value": "Podcast", "visible": true},
    {"id": "habilidades_clinicas", "value": "Habilidades Clinicas", "visible": true},
    {"id": "webinar", "value": "Webinar", "visible": true},
    {"id": "medicamento", "value": "Medicamento", "visible": true},
    {"id": "figura", "value": "Figura", "visible": true},
    {"id": "fluxograma", "value": "Fluxograma", "visible": true},
    {"id": "tabela", "value": "Tabela", "visible": true},
    {"id": "diretriz", "value": "Diretriz", "visible": true},
  ]);

  /// Manipula o valor boleano para exibir ou nao o campo
  changeCategorys(int index) {
    try {
      var _data = filterCategory[index];
      Map<String, dynamic> _map = {"id": _data['id'], "value": _data['value'], "visible": !_data['visible']};
      filterCategory.removeAt(index);
      filterCategory.insert(index, _map);
    } catch (e) {
      AppLog.d("Não foi possível alterar o estado da variável $e", name: "changeStateVisibleFields");
    }
  }

  checkAll({bool visible = false}) {
    try {
      filterAllCategory.value = !filterAllCategory.value;
      print("visible $visible === ${filterAllCategory.value}");
      List<Map<String, dynamic>> _category = <Map<String, dynamic>>[];
      for (var i = 0; i < filterCategory.length; i++) {
        var _data = filterCategory[i];
        Map<String, dynamic> _map = {"id": _data['id'], "value": _data['value'], "visible": !visible};
        _category.add(_map);
      }
      filterCategory.clear();
      filterCategory.addAll(_category);
    } catch (e) {
      AppLog.d("Não foi possível alterar o estado da variável $e", name: "checkAll");
    }
  }

  String _filter =
      "diagnostico_e_tratamento,artigo,capitulo,consulta_rapida_e_recomendacoes,aula,podcast,habilidades_clinicas,webinar,medicamento,figura,fluxograma,tabela,diretriz";

  String get _filterCategory {
    List<Map<String, dynamic>> _cat = filterCategory.where((p) => p['visible'] == true).toList();
    var _d = _cat.map((e) => e['id']);
    var _category = _d.join(",");
    return _category.isNotEmpty ? _category : _filter;
  }

  // final RxBool loadingInforMed = RxBool(false);
  final RxList<ContentsInfoMed> resultSearchInforMed = RxList.empty();
  final RxList<ContentsInfoMed> resultSearchContentsIDInforMed = RxList.empty();

  final Rx<AppLoadingStatus> isLoading = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);
  final Rx<AppLoadingStatus> isLoadingSearchContentsId = Rx<AppLoadingStatus>(AppLoadingStatus.notLoading);

  /// armazena o termo digitado
  final RxString searchTerm = RxString('');
  final RxInt filtroAbas = RxInt(1);

  filtroAbasUpdate(int data) => filtroAbas.value = data;

  String get _specialty {
    String _aba = filtroAbas.value == 1 ? SPECIALTY_TODOS : (filtroAbas.value == 2 ? SPECIALTY_ADULTO : SPECIALTY_PEDIATRIA);
    return _aba;
  }

  _auth() async {
    try {
      final isConnecting = await checkConnecting.appCheckConnectivity();
      isLoading.value = AppLoadingStatus.shimmerLoading;

      if (!isConnecting) {
        isLoading.value = AppLoadingStatus.notConnecting;
        await AppAlert.alertError(title: "Oops!", body: 'Verifique sua conexão, por favor.', seconds: 5);
      }
      var _map = {"email": "contato@medicinadireta.com.br", "password": "Medicina@2021", "codeTwoFactorAuthenticator": "false", "ip": "null"};

      var _resp = await datasourceImpl.loginInfoMedDatasource(_map);
      if (_resp.statusCode != 201) {
        await AppAlert.alertError(title: "Oops!", body: "Houve uma falha ao tentar habilitar o módulo de pesquisa", seconds: 10);
        isLoading.value = AppLoadingStatus.notLoading;
        return;
      }

      if (_resp.model?.token != null) {
        await sharedPreferences.removeKeyTokenInfoMed();
        await sharedPreferences.setCurrentTokenInfoMed(_resp.model!.token!);
      }

      isLoading.value = AppLoadingStatus.notLoading;
    } catch (e, s) {
      isLoading.value = AppLoadingStatus.notLoading;
      await AppAlert.alertError(title: "Oops!", body: "Houve uma falha ao tentar habilitar o módulo de pesquisa", seconds: 10);
      AppLog.d("Problema para se conectar o info med $e", name: "auth info med", stackTrace: s);
    }
  }

  searchInfoMed(String search) async {
    try {
      filtroAbasUpdate(1);
      resultSearchInforMed.clear();
      searchTerm.value = search;

      var _category = _filterCategory;

      var _map = {"term": search, "offset": 0, "filter": _category, "range": "", "specialty": _specialty};
      await _searchInfoMed(_map);
    } catch (e, s) {
      AppLog.d("Problema para se conectar o info med $e", name: "auth info med", stackTrace: s);
    }
  }

  messageAlert() async {
    try {
      await AppAlert.alertWarning(title: "Atenção!", body: 'Informe um termo antes de selecionar a categoria', seconds: 25, snackPosition: AppAlert.TOP);
      return;
    } catch (e, s) {
      AppLog.d("Problema para usar os filtros $e", name: "messageAlert", stackTrace: s);
    }
  }

  searchInfoMedFilter() async {
    Get.back();
    await _searchInfoMedFilter();
  }

  _searchInfoMedFilter() async {
    var _category = _filterCategory;
    try {
      if (searchTerm.value == '' || searchTerm.value.isEmpty) {
        await AppAlert.alertWarning(
          title: "Atenção!",
          body: 'Informe um termo antes de selecionar a categoria',
          seconds: 15,
          snackPosition: AppAlert.TOP,
        );
        return;
      }
      var _map = {"term": searchTerm.value, "offset": 0, "filter": _category, "range": "", "specialty": _specialty};
      await _searchInfoMed(_map);
    } catch (e, s) {
      searchTerm.value = '';
      Get.back();
      AppLog.d("Problema para usar os filtros $e", name: "searchInfoMedFilter", stackTrace: s);
    }
  }

  sortContentsInfoMed(String order) async {
    Get.back();
    await _sortContentsInfoMed(order);
  }

  _sortContentsInfoMed(String order) async {
    var _category = _filterCategory;
    try {
      if (searchTerm.value == '' || searchTerm.value.isEmpty) {
        await AppAlert.alertWarning(
          title: "Atenção!",
          body: 'Informe um termo antes de selecionar o tipo de ordenação',
          seconds: 15,
          snackPosition: AppAlert.TOP,
        );
        return;
      }
      var _map = {"term": searchTerm.value, "offset": 0, "filter": _category, "range": "", "specialty": _specialty, "order": order};
      await _searchInfoMed(_map);
    } catch (e, s) {
      searchTerm.value = '';
      Get.back();
      AppLog.d("Problema para usar os filtros $e", name: "searchInfoMedFilter", stackTrace: s);
    }
  }

  searchInfoMedFilterSpecialty({String? specialty}) async {
    try {
      var _category = _filterCategory;
      if (specialty == '' || specialty == null) {
        await AppAlert.alertWarning(title: "Atenção!", body: 'Não foi possível efetuar a pesquisa, tente novamente!', seconds: 25, snackPosition: AppAlert.TOP);
        return;
      }
      if (searchTerm.value == '' || searchTerm.value.isEmpty) {
        await AppAlert.alertWarning(
          title: "Atenção!",
          body: 'Informe um termo antes de selecionar o filtro',
          seconds: 15,
          snackPosition: AppAlert.TOP,
        );
        return;
      }
      int _value = specialty == SPECIALTY_TODOS ? 1 : (specialty == SPECIALTY_ADULTO ? 2 : 3);
      filtroAbasUpdate(_value);
      var _map = {"term": searchTerm.value, "offset": 0, "filter": _category, "range": "", "specialty": specialty};
      await _searchInfoMed(_map);
    } catch (e, s) {
      Get.back();
      AppLog.d("Problema para usar os filtros $e", name: "searchInfoMedFilterSpecialty", stackTrace: s);
    }
  }

  _searchInfoMed(Map<String, dynamic> map) async {
    try {
      resultSearchInforMed.clear();
      final isConnecting = await checkConnecting.appCheckConnectivity();
      isLoading.value = AppLoadingStatus.shimmerLoading;

      if (!isConnecting) {
        isLoading.value = AppLoadingStatus.notConnecting;
        await AppAlert.alertError(title: "Oops!", body: 'Verifique sua conexão, por favor.', seconds: 15);
        return;
      }

      var _resp = await datasourceImpl.searchInfoMedDatasource(map);
      if (_resp.statusCode != 201) {
        await AppAlert.alertError(title: "Oops!", body: "Não foi possível efetuar a pesquisa", seconds: 10);
        isLoading.value = AppLoadingStatus.notLoading;
        return;
      }
      if (_resp.model?.isNotEmpty ?? false) resultSearchInforMed.addAll(_resp.model!);

      isLoading.value = AppLoadingStatus.notLoading;
    } catch (e, s) {
      resultSearchInforMed.clear();
      isLoading.value = AppLoadingStatus.notLoading;
      await AppAlert.alertError(title: "Oops!", body: "Não foi possível efetuar a pesquisa", seconds: 10);
      AppLog.d("Problema para se conectar o info med $e", name: "auth info med", stackTrace: s);
    }
  }

  searchContentsIDInfoMed(String id) async {
    try {
      await _searchContentsIDInfoMed(id);
    } catch (e, s) {
      AppLog.d("Problema para se conectar o info med $e", name: "searchContentsIDInfoMed", stackTrace: s);
    }
  }

  _searchContentsIDInfoMed(String id) async {
    try {
      resultSearchContentsIDInforMed.clear();
      final isConnecting = await checkConnecting.appCheckConnectivity();
      isLoadingSearchContentsId.value = AppLoadingStatus.shimmerLoading;

      if (!isConnecting) {
        isLoadingSearchContentsId.value = AppLoadingStatus.notConnecting;
        await AppAlert.alertError(title: "Oops!", body: 'Verifique sua conexão, por favor.', seconds: 5);
      }

      var _resp = await datasourceImpl.searchContentsIDInfoMedDatasource(id);
      if (_resp.statusCode != 200) {
        await AppAlert.alertError(title: "Oops!", body: "${_resp.statusCode} Falha ao tentar localizar o conteúdo, tente novamentex2!", seconds: 20);
        isLoadingSearchContentsId.value = AppLoadingStatus.notLoading;
        return;
      }
      if (_resp.model != null) resultSearchContentsIDInforMed.add(_resp.model!);
      isLoadingSearchContentsId.value = AppLoadingStatus.notLoading;
    } catch (e, s) {
      AppLog.d("Problema para se conectar o info med $e", name: "_searchContentsIDInfoMed", stackTrace: s);
      resultSearchContentsIDInforMed.clear();
      isLoadingSearchContentsId.value = AppLoadingStatus.notLoading;
      await AppAlert.alertError(title: "Oops!", body: "Falha ao tentar localizar o conteúdo, tente novamentex1!", seconds: 20);
    }
  }
}
