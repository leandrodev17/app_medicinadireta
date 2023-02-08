import 'package:equatable/equatable.dart';

import 'authentication_token.dart';
import 'authetication_access.dart';

class Authentication extends Equatable {
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
  final AuthenticationToken? token;
  final int? tipoEvolucao;
   final List<AutheticationAccess>? acessos;

  const Authentication({
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
    this.token,
    this.tipoEvolucao,
    this.acessos,
  });

  @override
  List<Object?> get props => [
        id,
        nome,
        utc,
        cpf,
        email,
        login,
        isAtivado,
        sexo,
        tipoProfissional,
        isFuncionarioSus,
        especialidadeId,
        token,
        tipoEvolucao,
    acessos,
      ];
}
