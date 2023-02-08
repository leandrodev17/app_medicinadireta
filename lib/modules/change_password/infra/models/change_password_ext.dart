import 'package:medicinadireta/modules/change_password/domain/entities/change_password.dart';

class ChangePasswordExt extends ChangePassword{
  final String? responseText;
  final String? data;
  final bool? sucesso;
  ChangePasswordExt({
    this.responseText,
    this.data,
    this.sucesso,
  });

  ChangePasswordExt copyWith({
    String? responseText,
    String? data,
    bool? sucesso,
  }) =>
      ChangePasswordExt(
        responseText: responseText ?? this.responseText,
        data: data ?? this.data,
        sucesso: sucesso ?? this.sucesso,
      );

  factory ChangePasswordExt.fromMap(Map<String, dynamic> json) => ChangePasswordExt(
    responseText: json["responseText"],
    data: json["data"],
    sucesso: json["sucesso"],
  );

  Map<String, dynamic> toMap() => {
    "responseText": responseText,
    "data": data,
    "sucesso": sucesso,
  };
}