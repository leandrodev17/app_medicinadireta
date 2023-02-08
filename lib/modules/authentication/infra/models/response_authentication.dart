import '/modules/authentication/domain/entities/authentication.dart';
import 'response_authentication_access.dart';
import 'response_authentication_token.dart';

class ResponseAuthentication extends Authentication {
  final int? id;
  final String? nome;
  final String? utc;
  final String? cpf;
  final String? email;
  final String? login;
  final String? isAtivado;
  final String? sexo;
  final String? tipoProfissional;
  final String? isFuncionarioSus;
  final String? especialidadeId;
  final int? tipoEvolucao;
  final ResponseAuthenticationToken? token;
  final List<ResponseAuthenticationAccess>? acessos;

  ResponseAuthentication({
    this.id,
    this.nome,
    this.utc,
    this.cpf,
    this.email,
    this.login,
    this.isAtivado,
    this.sexo,
    this.tipoProfissional,
    this.isFuncionarioSus,
    this.especialidadeId,
    this.tipoEvolucao,
    this.token,
    this.acessos,
  });

  factory ResponseAuthentication.fromMap(Map<String, dynamic> json) => ResponseAuthentication(
        id: json["id"],
        nome: json["nome"],
        utc: json["utc"],
        cpf: json["cpf"],
        email: json["email"],
        login: json["login"],
        isAtivado: json["isAtivado"],
        sexo: json["sexo"],
        tipoProfissional: json["tipoProfissional"],
        isFuncionarioSus: json["isFuncionarioSUS"],
        especialidadeId: json["especialidadeId"],
        tipoEvolucao: json["tipoEvolucao"],
        token: json["token"] != null ? ResponseAuthenticationToken.fromMap(json["token"]) : null,
        acessos: json["acessos"] != null ? List<ResponseAuthenticationAccess>.from(json["acessos"].map((data) => ResponseAuthenticationAccess.fromMap(data))) : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
        "utc": utc,
        "cpf": cpf,
        "email": email,
        "login": login,
        "isAtivado": isAtivado,
        "sexo": sexo,
        "tipoProfissional": tipoProfissional,
        "isFuncionarioSUS": isFuncionarioSus,
        "especialidadeId": especialidadeId,
        "tipoEvolucao": tipoEvolucao,
        "token": token != null ? token!.toMap() : null,
        "acessos": acessos != null ? acessos?.map((e) => e.toMap()).toList() : null,
      };
}
