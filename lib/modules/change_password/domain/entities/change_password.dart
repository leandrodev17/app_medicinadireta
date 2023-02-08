import 'package:equatable/equatable.dart';

class ChangePassword extends Equatable{
  final String? responseText;
  final String? data;
  final bool? sucesso;
  ChangePassword({
    this.responseText,
    this.data,
    this.sucesso,
  });

  @override
  List<Object?> get props => [
    responseText,
    data,
    sucesso,
  ];

}