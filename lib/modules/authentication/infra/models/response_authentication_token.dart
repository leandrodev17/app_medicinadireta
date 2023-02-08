import '/modules/authentication/domain/entities/authentication_token.dart';

class ResponseAuthenticationToken extends AuthenticationToken {
  final String? chave;
  final DateTime? duracao;
  ResponseAuthenticationToken({this.chave, this.duracao});

  factory ResponseAuthenticationToken.fromMap(Map<String, dynamic> json) => ResponseAuthenticationToken(
        chave: json["chave"],
        duracao: DateTime.parse(json["duracao"]),
      );

  Map<String, dynamic> toMap() => {
        "chave": chave,
        "duracao": duracao!.toIso8601String(),
      };
}
