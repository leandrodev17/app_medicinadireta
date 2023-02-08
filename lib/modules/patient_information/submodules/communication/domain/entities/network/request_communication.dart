import '/core/network/network_request.dart';
import 'package:equatable/equatable.dart';

class RequestCommunication extends Equatable implements NetworkRequest {
  final int? corPara;
  final int? smsPara;
  final String? assunto;
  final String? dddCelular;
  final String? mensagem;
  final String? emailPaciente;
  final String? dataEnvio;
  final String? horaEnvio;
  final int? remetenteId;

  RequestCommunication({
    this.corPara,
    this.smsPara,
    this.assunto,
    this.dddCelular,
    this.mensagem,
    this.emailPaciente,
    this.dataEnvio,
    this.horaEnvio,
    this.remetenteId,
  });

  _map() {
    Map<String, dynamic> _maps = Map<String, dynamic>();

    if (this.corPara != null) _maps["corPara"] = this.corPara;
    if (this.smsPara != null) _maps["smsPara"] = this.smsPara;
    if (this.assunto != null) _maps["assunto"] = this.assunto;
    if (this.dddCelular != null) _maps["dddCelular"] = this.dddCelular;
    if (this.mensagem != null) _maps["mensagem"] = this.mensagem;
    if (this.emailPaciente != null) _maps["emailPaciente"] = this.emailPaciente;

    if (this.dataEnvio != null) _maps["dataEnvio"] = this.dataEnvio;
    if (this.horaEnvio != null) _maps["horaEnvio"] = this.horaEnvio;
    if (this.remetenteId != null) _maps["remetenteId"] = this.remetenteId;

    return _maps;
  }

  @override
  toMap() => _map();

  @override
  List<Object> get props => [
        corPara!,
        smsPara!,
        assunto!,
        dddCelular!,
        mensagem!,
        emailPaciente!,
        dataEnvio!,
        horaEnvio!,
        remetenteId!,
      ];
}
