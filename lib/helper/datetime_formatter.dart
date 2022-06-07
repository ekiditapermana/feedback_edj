import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateTimeFormatter {
  DateTimeFormatter(String checkinTime);

  static dynamic format(String dateTime, String format) {
    initializeDateFormatting();
    var result = DateFormat(format, 'id').format(DateTime.parse(dateTime));
    return result;
  }
}
