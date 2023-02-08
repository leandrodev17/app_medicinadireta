import 'package:equatable/equatable.dart';

class AuthenticationToken extends Equatable {
  final String? chave;
  final DateTime? duracao;
  AuthenticationToken({this.chave, this.duracao});

  @override
  List<Object?> get props => [chave, duracao];
}
