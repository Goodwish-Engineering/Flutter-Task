import 'package:intl/intl.dart';

String formatDateTime(bool isDob, String value) {
  if (isDob) {
    try {
      // Try to parse the date if it's in ISO format
      DateTime dateTime = DateTime.parse(value);
      return DateFormat('MMM dd, yyyy').format(dateTime);
    } catch (e) {
      // If parsing fails, return the original value
      return value;
    }
  }
  return value;
}
