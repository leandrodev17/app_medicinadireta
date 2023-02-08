import 'package:medicinadireta/lang/app_translation.dart';
import 'package:intl/intl.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormatsDatetime {
  FormatsDatetime._();

  //,_locale aparentimente não está afetando o formato da data

  static String get _locale => Intl.getCurrentLocale();

  static DateFormat get apiDateFormat => DateFormat('yyyy-MM-ddTHH:mm:ss', _locale);
  static DateFormat get apiTimeFormat => DateFormat('HH:mm:ss', _locale);
  static DateFormat get timeFormatHHMM => DateFormat('HH:mm', _locale);
  static DateFormat get apiOnlyDateFormat => DateFormat('yyyy-MM-ddT00:00:00', _locale);
  static DateFormat get dateHourFormat => DateFormat('dd/MM/yyyy  HH:mm', _locale);
  static DateFormat get dateFormat => DateFormat('dd/MM/yyyy', _locale);
  static DateFormat get yearMonthDay => DateFormat('yyyy-MM-dd', _locale);
  static DateFormat get monthYearFormat => DateFormat('MMMM yyyy', _locale);
  static DateFormat get dateFormatSeparated => DateFormat('dd MMMM yyyy', _locale);
  static DateFormat get dateDayOfWeekFormatSeparated => DateFormat('EEEE dd/MM/yyyy', _locale);
  static DateFormat get dateDay => DateFormat('EEEE', _locale);

  static String formatTime(String time, {bool withSeconds = false}) {
    String timeString = time.substring(0, time.length > 8 ? 8 : time.length).replaceAll('PT', '').replaceAll('H', ':').replaceAll('S', ':').replaceAll('M', '');
    var _time = timeString.split(':');
    if (timeString.endsWith(':')) timeString = '$timeString\00';
    if (withSeconds && timeString.length <= 5) timeString = '$timeString:\00';
    int _minutes = _time[1] != '' ? int.parse(_time[1].toString()) : 0;
    if (_minutes > 0 && _minutes < 10) return "${_time[0]}:0${_time[1]}";
    if (timeString != '0') return "$timeString";
    return '';
  }

  static String formatDate(DateTime time, DateFormat format) {
    return format.format(time);
  }

  static DateTime formatDateTime(DateTime time, DateFormat format) {
    return DateTime.parse(format.format(time));
  }

  static DateTime formatDateTimeString(String? dateTime, DateFormat format) {
    if (dateTime == null || dateTime == '') return DateTime.now();
    var _date = DateTime.parse(dateTime);
    return formatDateTime(_date, format);
  }

  // retorna o nome do mes e ano conforme o parametro
  static String stringMesYear(DateTime tm, {bool dayMonthYearString = false}) {
    var _month = '';
    switch (tm.month) {
      case 1:
        _month = "january";
        break;
      case 2:
        _month = "february";
        break;
      case 3:
        _month = "march";
        break;
      case 4:
        _month = "april";
        break;
      case 5:
        _month = "may";
        break;
      case 6:
        _month = "june";
        break;
      case 7:
        _month = "july";
        break;
      case 8:
        _month = "august";
        break;
      case 9:
        _month = "september";
        break;
      case 10:
        _month = "october";
        break;
      case 11:
        _month = "november";
        break;
      case 12:
        _month = "december";
        break;
    }
    if (dayMonthYearString) return "${AppTranslationString.string(FormatsDatetime.dateDay.format(tm).toLowerCase())} ${tm.day}/${tm.month}/${tm.year}";
    return "${AppTranslationString.string(_month)} ${tm.year}";
  }

  // retorna o nome do mes e ano abreviado conforme o parametro
  static String stringMesYearAbbreviation(DateTime tm) {
    var _month = '';
    switch (tm.month) {
      case 1:
        _month = "Jan";
        break;
      case 2:
        _month = "Fev";
        break;
      case 3:
        _month = "Mar";
        break;
      case 4:
        _month = "Abr";
        break;
      case 5:
        _month = "Mai";
        break;
      case 6:
        _month = "Jun";
        break;
      case 7:
        _month = "Jul";
        break;
      case 8:
        _month = "Ago";
        break;
      case 9:
        _month = "Set";
        break;
      case 10:
        _month = "Out";
        break;
      case 11:
        _month = "Nov";
        break;
      case 12:
        _month = "Dez";
        break;
    }
    return AppTranslationString.string(_month);
  }
}
