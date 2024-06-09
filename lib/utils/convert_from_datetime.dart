import 'package:intl/intl.dart';

String convertFromDateTime(DateTime dateTime) {
  // Create a DateFormat object with the pattern 'dd-MM-yyyy'
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  // Format the DateTime object into a string
  return formatter.format(dateTime);
}
