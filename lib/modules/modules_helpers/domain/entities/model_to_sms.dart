import 'package:equatable/equatable.dart';

class ModelToSms extends Equatable {
  final int? codModeloSms;
  final String? assuntoModeloSms;
  final int? id;
  ModelToSms({this.codModeloSms, this.assuntoModeloSms, this.id});

  @override
  List<Object?> get props => [codModeloSms, assuntoModeloSms,id];
}