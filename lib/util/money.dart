import 'package:intl/intl.dart';

class Money {
  static final _rsd = NumberFormat.currency(locale: 'sr_RS', symbol: 'RSD', decimalDigits: 0);
  static String rsd(int value) => _rsd.format(value);
}