import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientDetailsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final RxBool isOpenCar = RxBool(true);
  final RxBool isOpenCardDataGeneral = RxBool(false);
  void openCardDataGeneral() => isOpenCardDataGeneral.value = !isOpenCardDataGeneral.value;
  final RxBool isOpenCardSoap = RxBool(false);
  final RxBool isOpenCardSoapSubjetivo = RxBool(false);
  final RxBool isOpenCardSoapObjetivo = RxBool(false);
  final RxBool isOpenCardSoapPlano = RxBool(false);
  void openCardSoap() {
    isOpenCardSoap.value = !isOpenCardSoap.value;
    isOpenCardSoapSubjetivo.value = true;
    isOpenCardSoapObjetivo.value = true;
    isOpenCardSoapPlano.value = true;
  }

  void openCardSoapSubjetivo() => isOpenCardSoapSubjetivo.value = !isOpenCardSoapSubjetivo.value;
  void openCardSoapObjetivo() => isOpenCardSoapObjetivo.value = !isOpenCardSoapObjetivo.value;
  void openCardSoapPlano() => isOpenCardSoapPlano.value = !isOpenCardSoapPlano.value;

  openCardAlert(int index) {
    ItemAlertModel data = alerts2[index];
    bool _open = !data.itemOpenCard;
    ItemAlertModel newItem = ItemAlertModel(itemOpenCard: _open, colorTitulo: data.colorTitulo, itens: data.itens, nomeTipoAlerta: data.nomeTipoAlerta);
    alerts2.removeAt(index);
    alerts2.insert(index, newItem);
  }

  final RxList<AlertModel> alerts = RxList<AlertModel>.generate(2, (index) => AlertModel(titulo1: "17/02/2022 UTC -3:00", titulo2: "1234$index", titulo3: "1234567$index"));
  final RxList<ItemAlertModel> alerts2 = RxList<ItemAlertModel>.from([
    ItemAlertModel(itemOpenCard: false, colorTitulo: 0xFF67B1FF, nomeTipoAlerta: 'INFORMAÇÃO', itens: [
      SubItemAlert(tipo: 'LÁTEX', medicamento: 'DIPIRONA', titulo: '#11139 - CARLOS FLUTTER CRM-SP 123654 - 16/02/2022 às 21:32'),
      SubItemAlert(tipo: 'LÁTEX', medicamento: 'DIPIRONA 1', titulo: '#11139 - CARLOS FLUTTER CRM-SP 123654 - 16/02/2022 às 21:32'),
      SubItemAlert(tipo: 'LÁTEX', medicamento: 'DIPIRONA 2', titulo: '#111394 - CARLOS FLUTTER CRM-SP 123654 - 16/02/2022 às 21:32'),
    ]),
    ItemAlertModel(itemOpenCard: false, colorTitulo: 0xFFF9BA00, nomeTipoAlerta: 'ALERTA', itens: [
      SubItemAlert(tipo: 'INSERTOS', medicamento: 'DIPIRONA', titulo: '#11139 - CARLOS FLUTTER CRM-SP 123654 - 16/02/2022 às 21:32'),
      SubItemAlert(tipo: 'INSERTOS', medicamento: 'DIPIRONA 1', titulo: '#11139 - CARLOS FLUTTER CRM-SP 123654 - 16/02/2022 às 21:32'),
      SubItemAlert(tipo: 'INSERTOS', medicamento: 'DIPIRONA 2', titulo: '#111394 - CARLOS FLUTTER CRM-SP 123654 - 16/02/2022 às 21:32'),
    ]),
    ItemAlertModel(itemOpenCard: false, colorTitulo: 0xFFFF4F4F, nomeTipoAlerta: 'CRÍTICO', itens: [
      SubItemAlert(tipo: 'ALIMENTAR', medicamento: 'DIPIRONA', titulo: '#11139 - CARLOS FLUTTER CRM-SP 123654 - 16/02/2022 às 21:32'),
      SubItemAlert(tipo: 'ALIMENTAR', medicamento: 'DIPIRONA', titulo: '#11139 - CARLOS FLUTTER CRM-SP 123654 - 16/02/2022 às 21:32'),
      SubItemAlert(tipo: 'ALIMENTAR', medicamento: 'DIPIRONA', titulo: '#11139 - CARLOS FLUTTER CRM-SP 123654 - 16/02/2022 às 21:32'),
    ]),
    ItemAlertModel(itemOpenCard: false, colorTitulo: 0xFFA674FF, nomeTipoAlerta: 'ALÉRGICO', itens: [
      SubItemAlert(tipo: 'MEDICAMENTO', medicamento: 'DIPIRONA', titulo: '#11139 - CARLOS FLUTTER CRM-SP 123654 - 16/02/2022 às 21:32'),
      SubItemAlert(tipo: 'MEDICAMENTO', medicamento: 'DIPIRONA', titulo: '#11139 - CARLOS FLUTTER CRM-SP 123654 - 16/02/2022 às 21:32'),
      SubItemAlert(tipo: 'MEDICAMENTO', medicamento: 'DIPIRONA', titulo: '#111394 - CARLOS FLUTTER CRM-SP 123654 - 16/02/2022 às 21:32'),
      SubItemAlert(tipo: 'MEDICAMENTO', medicamento: 'DIPIRONA', titulo: '#111395 - CARLOS FLUTTER CRM-SP 123654 - 16/02/2022 às 21:32'),
      SubItemAlert(tipo: 'MEDICAMENTO', medicamento: 'DIPIRONA', titulo: '#111396 - CARLOS FLUTTER CRM-SP 123654 - 16/02/2022 às 21:32'),
      SubItemAlert(tipo: 'MEDICAMENTO', medicamento: 'DIPIRONA', titulo: '#111397 - CARLOS FLUTTER CRM-SP 123654 - 16/02/2022 às 21:32'),
    ]),
  ]);

  void openItemMenu(int index) {
    ItemAlertModel data = alerts2[index];
    bool _open = !data.itemOpenCard;
    ItemAlertModel newItem = ItemAlertModel(itemOpenCard: _open, colorTitulo: data.colorTitulo, itens: data.itens, nomeTipoAlerta: data.nomeTipoAlerta);
    alerts2.removeAt(index);
    alerts2.insert(index, newItem);
  }

  openCardPatient() async {
    isOpenCar.value = !isOpenCar.value;
  }

  viewPhoto(ParamsToNavigationPage params) async {
    bool _isExistsPhoto = params.photoPerfil != null && (params.photoPerfil?.isNotEmpty ?? false);
    await Get.defaultDialog(
      radius: 4,
      title: params.nomeDoPaciente ?? 'Visualização',
      titleStyle: Theme.of(Get.context!).textTheme.subtitle1,
      content: Container(
        padding: const EdgeInsets.all(10),
        child: _isExistsPhoto ? Image.memory(params.photoPerfil!) : Container(),
      ),
      textCancel: "Fechar",
      // onCancel: () => Get.back(),
    );
  }
}

class AlertModel {
  final String? titulo1;
  final String? titulo2;
  final String? titulo3;

  AlertModel({this.titulo1, this.titulo2, this.titulo3});
}

class ItemAlertModel {
  final bool itemOpenCard;
  final int? colorTitulo;
  final String? nomeTipoAlerta;
  final List<SubItemAlert>? itens;

  ItemAlertModel({this.nomeTipoAlerta, this.itens, this.colorTitulo, this.itemOpenCard = false});
}

class SubItemAlert {
  final String? titulo;
  final String? tipo;
  final String? medicamento;

  SubItemAlert({this.titulo, this.tipo, this.medicamento});
}
