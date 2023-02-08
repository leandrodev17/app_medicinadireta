import '/core/network/network_request.dart';
import 'package:equatable/equatable.dart';

class RequestNewMedicalAppointmentNotification extends Equatable implements NetworkRequest {
  final String? assunto;
  final int? modeloCorreioId;
  final int? corpara;
  final int? idAgendamento;
  final String? emailPaciente;
  final String? dataEnvio;
  final String? horaEnvio;
  final String? tituloAgenda;
  final int? modeloSmsId;
  final int? smspara;
  final int? idAgenda;
  final int? smsDe;
  final int? corde;
  final String? smsPaciente;

  RequestNewMedicalAppointmentNotification({
    this.assunto,
    this.modeloCorreioId,
    this.corpara,
    this.idAgendamento,
    this.emailPaciente,
    this.dataEnvio,
    this.horaEnvio,
    this.tituloAgenda,
    this.modeloSmsId,
    this.smspara,
    this.smsPaciente,
    this.idAgenda,
    this.smsDe,
    this.corde,
  });

  _map() {
    Map<String, dynamic> _map = Map<String, dynamic>();
    if (assunto != null) _map['assunto'] = assunto;
    if (modeloCorreioId != null) _map['modeloCorreioId'] = modeloCorreioId;
    if (corpara != null) _map['corpara'] = corpara;
    if (idAgendamento != null) _map['idAgendamento'] = idAgendamento;
    if (emailPaciente != null) _map['emailPaciente'] = emailPaciente;
    if (dataEnvio != null) _map['dataEnvio'] = dataEnvio;
    if (tituloAgenda != null) _map['tituloAgenda'] = tituloAgenda;
    if (horaEnvio != null) _map['horaEnvio'] = horaEnvio;
    if (modeloSmsId != null) _map['modeloSmsId'] = modeloSmsId;
    if (smspara != null) _map['smspara'] = smspara;
    if (smsPaciente != null) _map['smsPaciente'] = smsPaciente;
    if (idAgenda != null) _map['idAgenda'] = idAgenda;
    if (smsDe != null) _map['smsDe'] = smsDe;
    if (corde != null) _map['corde'] = corde;
    return _map;
  }

  @override
  toMap() => _map();

  @override
  List<Object> get props => [
        assunto!,
        modeloCorreioId!,
        corpara!,
        idAgendamento!,
        emailPaciente!,
        dataEnvio!,
        horaEnvio!,
        tituloAgenda!,
        modeloSmsId!,
        smspara!,
        smsPaciente!,
        idAgenda!,
        smsDe!,
        corde!,
      ];
}
