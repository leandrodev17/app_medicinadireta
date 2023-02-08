import 'dart:convert';

import 'package:equatable/equatable.dart';

class ModelDetailsReschedule extends Equatable {
  final String? namePatient;
  final String? nameDoctor;
  final String? titleConsult; // titulo da consulta
  final String? hora; //data e hora do agendamento
  final String? date; //data e hora do agendamento
  final String? description;
  ModelDetailsReschedule({
    this.namePatient,
    this.nameDoctor,
    this.titleConsult,
    this.hora,
    this.date,
    this.description,
  });

  ModelDetailsReschedule copyWith({
    String? namePatient,
    String? nameDoctor,
    String? titleConsult,
    String? hora,
    String? date,
    String? description,
  }) {
    return ModelDetailsReschedule(
      namePatient: namePatient ?? this.namePatient,
      nameDoctor: nameDoctor ?? this.nameDoctor,
      titleConsult: titleConsult ?? this.titleConsult,
      hora: hora ?? this.hora,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        this.namePatient,
        this.nameDoctor,
        this.titleConsult,
        this.hora,
        this.date,
        this.description,
      ];

  Map<String, dynamic> toMap() {
    return {
      'namePatient': namePatient,
      'nameDoctor': nameDoctor,
      'titleConsult': titleConsult,
      'hora': hora,
      'date': date,
      'description': description,
    };
  }

  factory ModelDetailsReschedule.fromMap(Map<String, dynamic> map) {
    return ModelDetailsReschedule(
      namePatient: map['namePatient'] != null ? map['namePatient'] : null,
      nameDoctor: map['nameDoctor'] != null ? map['nameDoctor'] : null,
      titleConsult: map['titleConsult'] != null ? map['titleConsult'] : null,
      hora: map['hora'] != null ? map['hora'] : null,
      date: map['date'] != null ? map['date'] : null,
      description: map['description'] != null ? map['description'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelDetailsReschedule.fromJson(String source) => ModelDetailsReschedule.fromMap(json.decode(source));
}
