import 'package:get/get.dart';

class CommonsController extends GetxController {
  // new_medical_appointment_phone.dart
  // QUANDO CADASTRA UM NOVO PACIENTE PARA UM NOVA CONSULTA OS VALORES NOME E ID SÃO ATRIBUÍDOS A ESSAS VARIÁVEIS namePatient e idPatient PARA SEREM RESGATADAS NA VIEW DE CADASTRA DA NOVA CONSULTA.
  // namePatient = ALTERA O VALOR DO SELECT
  // idPatient = VALOR QUE SERÁ ENVIADO NA REQUISIÇÃO.
  // O MESMO PARA PESQUISA DO USUÁRIO
  final RxString namePatient = RxString('');
  final RxInt idPatient = RxInt(0);

  // ESTÁ SENDO UTILIZADO PARA FAZER A PESQUISA DE NOVOS HORÁRIOS PARA CRIAR CONSULTAS E ALTERAR O VALOR DO CABEÇALHO.
  // RESGATADO NA VIEW HORÁRIOS DISPONÍVEIS list_appointment_phone.dart
  final Rx<DateTime> dateTimeNewMedicalAppointment = Rx<DateTime>(DateTime.now());

  @override
  void dispose() {
    namePatient.value = '';
    idPatient.value = 0;
    dateTimeNewMedicalAppointment.value = DateTime.now();
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
