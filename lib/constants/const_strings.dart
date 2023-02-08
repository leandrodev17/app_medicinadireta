class ConstStrings {
  ConstStrings._();

  //CONFIGS
  static const String appName = 'Medicina Direta';
  static const fontFamily = 'Open Sans';
  static const localeLanguage = 'pt_BR';
  static const localeCode = 'pt';
  static const appValueNull = '-null-';

  //SUPPORT
  static const contactEmail = 'suporte@medicinadireta.com.br';
  static const contactPhone = '55 11 5184-4700';
  static const contactPhoneWhats = '5184-4714';
  static const textSupport =
      'Caso tenha alguma dúvida ou sugestão sobre este aplicativo ou qualquer outro serviço prestado pela Medicina Direta, entre em contato com nosso time por telefone ou email.';
  static const titleSupport = 'Como podemos ajudar?';
  static const String TOPICS_NOTIFICATION = "prod-medicina";

// 1'ALIMENTAR',
// 2'CUTÂNEA',
// 3'INSETOS',
// 4'LÁTEX',
// 5'MEDICAMENTOS'
// 6 'OCULAR',
// 7 'PELOS DE ANIMAIS',
// 8 'RESPIRATÓRIA',
// 9 'OUTRA',
// 10 'NÃO INFORMADO',
// 11 'PACIENTE NÃO RELATA ALERGIA',

  static const List<String> typeAlergy = [
    'ALIMENTAR',
    'CUTÂNEA',
    'INSETOS',
    'LÁTEX',
    'MEDICAMENTOS',
    'OCULAR',
    'PELOS DE ANIMAIS',
    'RESPIRATÓRIA',
    'OUTRA',
    'NÃO INFORMADO',
    'PACIENTE NÃO RELATA ALERGIA',
  ];
  static const List<Map<String, dynamic>> listUTC = [
    {"id": "-12:00", "value": "-12:00"},
    {"id": "-11:00", "value": "-11:00"},
    {"id": "-10:00", "value": "-10:00"},
    {"id": "-09:00", "value": "-09:00"},
    {"id": "-08:00", "value": "-08:00"},
    {"id": "-07:00", "value": "-07:00"},
    {"id": "-06:00", "value": "-06:00"},
    {"id": "-05:00", "value": "-05:00"},
    {"id": "-04:00", "value": "-04:00"},
    {"id": "-03:00", "value": "-03:00"},
    {"id": "-02:00", "value": "-02:00"},
    {"id": "-01:00", "value": "-01:00"},
    {"id": "00:00", "value": "00:00"},
    {"id": "+01:00", "value": "+01:00"},
    {"id": "+02:00", "value": "+02:00"},
    {"id": "+03:00", "value": "+03:00"},
    {"id": "+04:00", "value": "+04:00"},
    {"id": "+05:00", "value": "+05:00"},
    {"id": "+06:00", "value": "+06:00"},
    {"id": "+07:00", "value": "+07:00"},
    {"id": "+08:00", "value": "+08:00"},
    {"id": "+09:00", "value": "+09:00"},
    {"id": "+10:00", "value": "+10:00"},
    {"id": "+11:00", "value": "+11:00"},
    {"id": "+12:00", "value": "+12:00"},
  ];

  static const List<Map<String, dynamic>> origemInfo = [
    {"id": 5, "value": "CUIDADOR"},
    {"id": 1, "value": "ENFERMAGEM"},
    {"id": 2, "value": "FAMILIAR"},
    {"id": 3, "value": "IMUNOALERGOLOGISTA"},
    {"id": 6, "value": "OUTROS"},
    {"id": 4, "value": "PACIENTE"},
  ];
  static const List<Map<String, dynamic>> origemTipo = [
    {"id": 1, "value": "ALIMENTAR"},
    {"id": 2, "value": "CUTÂNEA"},
    {"id": 3, "value": "INSETOS"},
    {"id": 4, "value": "LÁTEX"},
    {"id": 5, "value": "MEDICAMENTOS"},
    {"id": 10, "value": "NÃO INFORMADO"},
    {"id": 6, "value": "OCULAR"},
    {"id": 9, "value": "OUTRA"},
    {"id": 11, "value": "PACIENTE NÃO RELATA ALERGIA"},
    {"id": 7, "value": "PELOS DE ANIMAIS"},
    {"id": 8, "value": "RESPIRATÓRIA"},
  ];
  static const List<Map<String, dynamic>> statusAllergy = [
    {"id": 1, "value": "ATIVO"},
    {"id": 2, "value": "INATIVO"},
    {"id": 3, "value": "RESOLVIDO"},
    {"id": 4, "value": "EVOLUIU"},
    {"id": 5, "value": "INDETERMINADO"},
  ];
  static const List<Map<String, dynamic>> typeSeveridade = [
    {"id": 1, "value": "MUITO ALTA"},
    {"id": 2, "value": "ALTA"},
    {"id": 3, "value": "MÉDIA"},
    {"id": 4, "value": "BAIXA"},
  ];

  static const List<Map<String, dynamic>> statusConfirm = [
    {"id": "C", "value": "CONFIRMADO"},
    {"id": "S", "value": "SUSPEITO"},
  ];

  static const List<Map<String, dynamic>> statusReacao = [
    {"id": "A", "value": "ALERGIA"},
    {"id": "I", "value": "INTOLERÂNCIA"},
  ];

  static const List<Map<String, dynamic>> statusOcorrido = [
    {"id": "A", "value": "APROXIMADA"},
    {"id": "E", "value": "EXATA"},
    {"id": "N", "value": "NÃO INFORMADO"},
  ];

  ///Cadastro do medicamento
  static const List<Map<String, dynamic>> typeMedical = [
    {"id": "FITOTERAPICO", "value": "FITOTERÁPICO"},
    {"id": "ALOPATICO", "value": "ALOPÁTICO"},
    {"id": "HOMEOPATICO", "value": "HOMEOPÁTICO"},
    {"id": "SIMILAR", "value": "SIMILAR"},
    {"id": "GENERICO", "value": "GENÉRICO"},
    {"id": "REFERENCIA", "value": "REFERÊNCIA"},
    {"id": "MANIPULADO", "value": "MANIPULADO"},
  ];
  static const List<Map<String, dynamic>> typeMedicalAdm = [
    {"id": "BUCAL", "value": "BUCAL"},
    {"id": "CAPILAR", "value": "CAPILAR"},
    {"id": "DERMATOLÓGICA", "value": "DERMATOLÓGICA"},
    {"id": "EPIDURAL", "value": "EPIDURAL"},
    {"id": "EXTERNO", "value": "EXTERNO"},
    {"id": "INALATÓRIA", "value": "INALATÓRIA"},
    {"id": "INALATÓRIA POR VIA NASAL", "value": "INALATÓRIA POR VIA NASAL"},
    {"id": "INALATÓRIA POR VIA ORAL", "value": "INALATÓRIA POR VIA ORAL"},
    {"id": "INTERNO", "value": "INTERNO"},
    {"id": "INTRA-ARTERIAL", "value": "INTRA-ARTERIAL"},
    {"id": "INTRA-ARTICULAR", "value": "INTRA-ARTICULAR"},
    {"id": "INTRADÉRMICA", "value": "INTRADÉRMICA"},
    {"id": "INTRAMUSCULAR", "value": "INTRAMUSCULAR"},
    {"id": "INTRATECAL", "value": "INTRATECAL"},
    {"id": "INTRAUTERINA", "value": "INTRAUTERINA"},
    {"id": "INTRAVENOSA", "value": "INTRAVENOSA"},
    {"id": "INTRAVÍTREA", "value": "INTRAVÍTREA"},
    {"id": "IRRIGAÇÃO", "value": "IRRIGAÇÃO"},
    {"id": "NASAL", "value": "NASAL"},
    {"id": "OFTÁLMICA", "value": "OFTÁLMICA"},
    {"id": "ORAL", "value": "ORAL"},
    {"id": "OTOLÓGICA", "value": "OTOLÓGICA"},
    {"id": "RETAL", "value": "RETAL"},
    {"id": "SONDA DE GASTROSTOMIA", "value": "SONDA DE GASTROSTOMIA"},
    {"id": "SONDA GASTROSTOMIA", "value": "SONDA GASTROSTOMIA"},
    {"id": "SONDA NASOENTERAL", "value": "SONDA NASOENTERAL"},
    {"id": "SONDA NASOENTÉRICA", "value": "SONDA NASOENTÉRICA"},
    {"id": "SUBCUTÂNEA", "value": "SUBCUTÂNEA"},
    {"id": "SUBLINGUAL", "value": "SUBLINGUAL"},
    {"id": "TÓPICO", "value": "TÓPICO"},
    {"id": "TRANSDÉRMICA", "value": "TRANSDÉRMICA"},
    {"id": "URETRAL", "value": "URETRAL"},
    {"id": "VAGINAL", "value": "VAGINAL"},
  ];

  static const List<Map<String, dynamic>> typeMedicalUsoContinuo = [
    {"id": "S", "value": "SIM"},
    {"id": "N", "value": "NÃO"},
  ];
  static const List<Map<String, dynamic>> typeMedicalTarja = [
    {"id": "SEM TARJA", "value": "SEM TARJA"},
    {"id": "VERMELHA", "value": "VERMELHA"},
    {"id": "VERMELHA SOB RESTRIÇÃO", "value": "VERMELHA SOB RESTRIÇÃO"},
    {"id": "PRETA", "value": "PRETA"},
  ];

  static const List<Map<String, dynamic>> typeMedicalAntimicrobiano = [
    {"id": "S", "value": "SIM"},
    {"id": "N", "value": "NÃO"},
  ];
  static const List<Map<String, dynamic>> listaControlado = [
    {"id": "A1", "value": "A1"},
    {"id": "A2", "value": "A2"},
    {"id": "A3", "value": "A3"},
    {"id": "B1", "value": "B1"},
    {"id": "B2", "value": "B2"},
    {"id": "C1", "value": "C1"},
    {"id": "C2", "value": "C2"},
    {"id": "C3", "value": "C3"},
    {"id": "C4", "value": "C4"},
    {"id": "C5", "value": "C5"},
  ];
  static const List<Map<String, dynamic>> listaUnitOfMeasurement = [
    {"id": "MCG", "value": "MCG"},
    {"id": "MCG/mL", "value": "MCG/mL"},
    {"id": "MG", "value": "MG"},
    {"id": "MG/ML", "value": "MG/ML"},
    {"id": "G", "value": "G"},
    {"id": "KG", "value": "KG"},
    {"id": "ML", "value": "ML"},
    {"id": "L", "value": "L"},
    {"id": "M³", "value": "M³"},
    {"id": "UFC", "value": "UFC"},
    {"id": "UFC/ml", "value": "UFC/ml"},
    {"id": "UFC/g", "value": "UFC/g"},
    {"id": "MILHAO(OES)/UFC", "value": "MILHAO(OES)/UFC"},
    {"id": "BILHAO(OES)/UFC", "value": "BILHAO(OES)/UFC"},
    {"id": "MILHAO(OES) UNIDADE(S)", "value": "MILHAO(OES) UNIDADE(S)"},
    {"id": "BILHAO(OES) UNIDADE(S)", "value": "BILHAO(OES) UNIDADE(S)"},
    {"id": "QSP", "value": "QSP"},
    {"id": "UI/mL", "value": "UI/mL"},
    {"id": "UI", "value": "UI"},
    {"id": "%", "value": "%"},
  ];

    static const List<Map<String, dynamic>> listStatus= [
    {"id": "A", "value": "ATIVO"},
    {"id": "I", "value": "INATIVO"},
  ];
}
