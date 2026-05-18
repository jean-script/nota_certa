import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat("d 'de' MMMM, y", 'pt_BR').format(date);
}
