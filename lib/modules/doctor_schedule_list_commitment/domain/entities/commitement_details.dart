import 'package:equatable/equatable.dart';

//somente para passar o paciente para o card das telas
class CommitementDetails extends Equatable {
  /// haveInfoPatient : O tipo de cadastro COMPROMISSO não traz os dados do paciente, parece que esse compromisso ainda vai ser
  /// atrelado a um paciente final. Por este motivo criei essa flag para exibir um card personalizado e remover o click.
  final String? name;
  final String? nameContact;
  final String? age;
  final String? phone;
  final String? mail;
  final String? hourFormatStart;
  final String? descricao;
  final int? cor;
  final String? titulo;
  final String? observacao;
  final int? numberProntuario;
  final int? id;
  final int? pacienteId;
  final int? agendaStatusId;
  final int? profissionalId;
  final int? agendaConfigId;
  final String? tipoAtendimento;
  final int? organizacaoId;
  final bool haveInfoPatient;
  final bool openCardPatient;
  CommitementDetails({
    this.name,
    this.nameContact,
    this.age,
    this.phone,
    this.mail,
    this.hourFormatStart,
    this.descricao,
    this.cor,
    this.titulo,
    this.observacao,
    this.numberProntuario,
    this.id,
    this.pacienteId,
    this.agendaStatusId,
    this.profissionalId,
    this.agendaConfigId,
    this.tipoAtendimento,
    this.organizacaoId,
    this.haveInfoPatient = true,
    this.openCardPatient = false,
  });

  @override
  List<Object?> get props => [
        this.name,
        this.nameContact,
        this.age,
        this.phone,
        this.mail,
        this.hourFormatStart,
        this.descricao,
        this.cor,
        this.titulo,
        this.observacao,
        this.numberProntuario,
        this.id,
        this.pacienteId,
        this.agendaStatusId,
        this.profissionalId,
        this.agendaConfigId,
        this.tipoAtendimento,
        this.organizacaoId,
        this.haveInfoPatient,
        this.openCardPatient,
      ];

  CommitementDetails copyWith({
    String? name,
    String? nameContact,
    String? age,
    String? phone,
    String? mail,
    String? hourFormatStart,
    String? descricao,
    int? cor,
    String? titulo,
    String? observacao,
    int? numberProntuario,
    int? id,
    int? pacienteId,
    int? agendaStatusId,
    int? profissionalId,
    int? agendaConfigId,
    String? tipoAtendimento,
    int? organizacaoId,
    bool? haveInfoPatient,
    bool? openCardPatient,
  }) {
    return CommitementDetails(
      name: name ?? this.name,
      nameContact: nameContact ?? this.nameContact,
      age: age ?? this.age,
      phone: phone ?? this.phone,
      mail: mail ?? this.mail,
      hourFormatStart: hourFormatStart ?? this.hourFormatStart,
      descricao: descricao ?? this.descricao,
      cor: cor ?? this.cor,
      titulo: titulo ?? this.titulo,
      observacao: observacao ?? this.observacao,
      numberProntuario: numberProntuario ?? this.numberProntuario,
      id: id ?? this.id,
      pacienteId: pacienteId ?? this.pacienteId,
      agendaStatusId: agendaStatusId ?? this.agendaStatusId,
      profissionalId: profissionalId ?? this.profissionalId,
      agendaConfigId: agendaConfigId ?? this.agendaConfigId,
      tipoAtendimento: tipoAtendimento ?? this.tipoAtendimento,
      organizacaoId: organizacaoId ?? this.organizacaoId,
      haveInfoPatient: haveInfoPatient ?? this.haveInfoPatient,
      openCardPatient: openCardPatient ?? this.openCardPatient,
    );
  }
}
