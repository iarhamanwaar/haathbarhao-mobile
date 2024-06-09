import 'package:intl/intl.dart';

DateTime convertToDateTime(String dateString) {
  // Create a DateFormat object with the pattern 'dd-MM-yyyy'
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  // Parse the date string into a DateTime object
  return formatter.parse(dateString);
}
