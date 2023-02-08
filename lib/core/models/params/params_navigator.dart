//Primeiro fluxo: DoctorSchedulePhone => DoctorCommitmentPhone => ListAppointmentPhone => NewMedicalAppointmentPhone => FIM
// Conclusão do cadastro da nova consulta : FIM <= DoctorCommitmentPhone <= NewMedicalAppointmentPhone

class ParamsNavigatorxxx {
  final int? doctorId;
  final int? agendaConfigId;
  final int? profissionalId;
  final int? organizacaoId;
  final int? pacienteId;
  final String? nameDoctor;
  final String? dataInicio;
  ParamsNavigatorxxx({
    this.doctorId,
    this.agendaConfigId,
    this.profissionalId,
    this.organizacaoId,
    this.pacienteId,
    this.nameDoctor,
    this.dataInicio,
  });

  Map<String, dynamic> toMap() => {
        "doctorId": this.doctorId,
        "agendaConfigId": this.agendaConfigId,
        "profissionalId": this.profissionalId,
        "organizacaoId": this.organizacaoId,
        "pacienteId": this.pacienteId,
        "nameDoctor": this.nameDoctor,
        "dataInicio": this.dataInicio,
      };
}