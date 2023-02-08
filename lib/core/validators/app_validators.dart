import 'package:medicinadireta/core/validators/utils.dart';
import 'package:medicinadireta/core/validators/validators.dart';
import 'package:flutter/widgets.dart' show FormFieldValidator, TextEditingController;
import 'package:get/get_utils/src/extensions/internacionalization.dart';


import 'cnpj.dart';
import 'cpf.dart';

class AppValidators {
  AppValidators._();

  static FormFieldValidator required({String m = 'requiredField'}) {
    return (v) {
      if (v?.isEmpty ?? true) return m.tr;
      return null;
    };
  }

  static FormFieldValidator<String> min(int min, String m) {
    return (v) {
      if (v?.isEmpty ?? true) return null;
      if ((v?.length ?? 0) < min) return m.tr;
      return null;
    };
  }

  static FormFieldValidator<String> max(int max, String m) {
    return (v) {
      if (v?.isEmpty ?? true) return null;
      if ((v?.length ?? 0) > max) return m.tr;
      return null;
    };
  }

  static FormFieldValidator<String> phone({String m = 'phone_invalid'}) {
    return (v) {
      if (v?.isEmpty ?? true) return null;
      if (!validatorRegex.phone(v!)) return m.tr;
      return null;
    };
  }

  /// Validates if the field has at least `minimumLength` and at most `maximumLength`
  ///
  /// e.g.: AppValidators.between(6, 10, 'password must have between 6 and 10 digits')
  static FormFieldValidator<String> between(
    int minimumLength,
    int maximumLength,
    String errorMessage,
  ) {
    assert(minimumLength < maximumLength);
    return multiple([
      min(minimumLength,  errorMessage),
      max(maximumLength,  errorMessage),
    ]);
  }

  // AppValidators.number('Value not a number')
  static FormFieldValidator<String> number(String m) {
    return (v) {
      if (v?.isEmpty ?? true) return null;
      if (double.tryParse(v!) != null)
        return null;
      else
        return m.tr;
    };
  }

  // AppValidators.email('Value is not email')
  static FormFieldValidator<String> email({String m = 'mail_invalid'}) {
    return (v) {
      if (v?.isEmpty ?? true) return null;
      if (validatorRegex.email(v!)) return null;
      return m.tr;
    };
  }

  // AppValidators.cpf('This CPF is not valid')
  static FormFieldValidator<String> cpf({String m = 'cpf_invalid'}) {
    return (v) {
      if (v?.isEmpty ?? true) return null;
      if (CpfValidator.isValid(v!))
        return null;
      else
        return m.tr;
    };
  }

  // AppValidators.cnpj('This CNPJ is not valid')
  static FormFieldValidator<String> cnpj({String m = 'cnpj_invalid'}) {
    return (v) {
      if (v?.isEmpty ?? true) return null;
      if (CNPJValidator.isValid(v!))
        return null;
      else
        return m.tr;
    };
  }

  static FormFieldValidator<String> cnpjCpf() {
    return (v) {
      if (v?.isEmpty ?? true) return null;
      var _data = v?.replaceAll('.', '').replaceAll('-', '').replaceAll('/', '');
      if (_data!.length > 11 && !CNPJValidator.isValid(_data)) return 'cnpj_invalid'.tr;
      if (_data.length <= 11 && !CpfValidator.isValid(_data)) return 'cpf_invalid'.tr;
      return null;
    };
  }

  // AppValidators.multiple([
  //   AppValidators.email('Value is not email')
  //   AppValidators.max(4, 'field max 4')
  // ])
  static FormFieldValidator<String> multiple(List<FormFieldValidator<String>> v) {
    return (value) {
      for (final validator in v) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }

  static FormFieldValidator<DateTime?> birthdate({String m = 'invalid_date_of_birth'}) {
    return (v) {
      if (v == null) return 'requiredField'.tr;
      if (isAdult(v))
        return null;
      else
        return m.tr;
    };
  }

    static FormFieldValidator<DateTime?> dateRequired({String m = 'requiredField'}) {
    return (v) {
      if (v == null) return m.tr;
        return null;
    };
  }

  /// Validates if the field has a valid date according to `DateTime.tryParse`
  ///
  /// e.g.: AppValidators.date('invalid date')
  static FormFieldValidator<String> date(String errorMessage) {
    return (value) {
      final date = DateTime.tryParse(value ?? '');
      if (date == null) {
        return errorMessage;
      }
      return null;
    };
  }

  // Compare two values using desired input controller
  /// e.g.: AppValidators.compare(inputController, 'Passwords do not match')
  static FormFieldValidator<String> compare(TextEditingController? controller, String message) {
    return (value) {
      final textCompare = controller?.text ?? '';
      if (value == null || textCompare != value) {
        return message.tr;
      }
      return null;
    };
  }
}
