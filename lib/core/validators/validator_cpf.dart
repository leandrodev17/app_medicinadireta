class ValidatorCPF {
  ValidatorCPF._();
  // Formatar número de CPF
  static String format(String cpf) {
    // Obter somente os números do CPF
    var numeros = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    // Testar se o CPF possui 11 dígitos
    if (numeros.length != 11) return cpf;

    // Retornar CPF formatado
    return "${numeros.substring(0, 3)}.${numeros.substring(3, 6)}.${numeros.substring(6, 9)}-${numeros.substring(9)}";
  }

  // Validar número de CPF
  static bool isValid(String cpf) {
    // Obter somente os números do CPF
    var numeros = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    // Testar se o CPF possui 11 dígitos
    if (numeros.length != 11) return false;

    // Testar se todos os dígitos do CPF são iguais
    if (RegExp(r'^(\d)\1*$').hasMatch(numeros)) return false;

    // Dividir dígitos
    List<int> digitos =
    numeros.split('').map((String d) => int.parse(d)).toList();

    // Calcular o primeiro dígito verificador
    var _dvi1 = 0;
    for (var i in Iterable<int>.generate(9, (i) => 10 - i)) {
      _dvi1 += digitos[10 - i] * i;
    }
    _dvi1 %= 11;
    var dv1 = _dvi1 < 2 ? 0 : 11 - _dvi1;

    // Testar o primeiro dígito verificado
    if (digitos[9] != dv1) return false;

    // Calcular o segundo dígito verificador
    var _dv2 = 0;
    for (var i in Iterable<int>.generate(10, (i) => 11 - i)) {
      _dv2 += digitos[11 - i] * i;
    }
    _dv2 %= 11;
    var dv2 = _dv2 < 2 ? 0 : 11 - _dv2;

    // Testar o segundo dígito verificador
    if (digitos[10] != dv2) return false;

    return true;
  }
}