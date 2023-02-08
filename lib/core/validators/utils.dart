import 'package:intl/intl.dart';

String removeWhiteSpace(str) {
  if (str.length <= 0) return '';
  return str.trim().replaceAll(RegExp(r'\s+'), '');
}

String? removeSpecialChars(str) {
  if (str != null) return str.replaceAll(RegExp(r'[^a-zA-Z 0-9]+'), '');
  return null;
}

bool allEqual(str) {
  final RegExp re = RegExp(r'^(\d)\1+$');
  return re.hasMatch(str);
}

String charAt(String subject, int position) {
  if (subject is! String ||
      subject.length <= position ||
      subject.length + position < 0) {
    return '';
  }

  final _realPosition = position < 0 ? subject.length + position : position;
  return subject[_realPosition];
}

bool validatorLetter(value) {
  final RegExp re = RegExp(r'^[a-zA-Z]+$');
  final bool matches = re.hasMatch(value);
  return !matches;
}

bool isAdult(DateTime birthDateString) {
  final DateFormat formatter = DateFormat("dd-MM-yyyy");
  final String formatted = formatter.format(birthDateString);

  String datePattern = "dd-MM-yyyy";

  // Current time - at this moment
  DateTime today = DateTime.now();

  // Parsed date to check
  DateTime birthDate = DateFormat(datePattern).parse(formatted);

  // Date to check but moved 18 years ahead
  DateTime adultDate = DateTime(
    birthDate.year + 18,
    birthDate.month,
    birthDate.day,
  );

  return adultDate.isBefore(today);
}

bool isAllEqual(str) {
  final RegExp re = RegExp(r'^(\d)\1+$');
  return re.hasMatch(str);
}

String charAtPosition(String subject, int position) {
  if (subject is! String ||
      subject.length <= position ||
      subject.length + position < 0) {
    return '';
  }

  final _realPosition = position < 0 ? subject.length + position : position;
  return subject[_realPosition];
}

bool validatorNumber(value) {
  final RegExp re = RegExp(r'^[0-9]+$');
  final bool matches = re.hasMatch(value);
  return !matches;
}
