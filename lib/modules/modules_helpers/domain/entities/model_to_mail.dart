import 'package:equatable/equatable.dart';

class ModelToMail extends Equatable {
  final int? codModeloEmail;
  final String? assuntoModeloEmail;
  final int? id;
  ModelToMail({this.codModeloEmail, this.assuntoModeloEmail, this.id});

  @override
  List<Object?> get props => [codModeloEmail, assuntoModeloEmail,id];
}