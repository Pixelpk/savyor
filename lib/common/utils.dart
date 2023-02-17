import 'package:intl/intl.dart';

class Utils {
  bool isEmail(String email) {
    try {
      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    } catch (e) {
      return false;
    }
  }

  String symbolText(dynamic text, String symbol, [bool isAfter = true]) {
    return text == null
        ? '-'
        : isAfter
            ? '${NumberFormat.decimalPattern().format(text)} $symbol'
            : '$symbol ${NumberFormat.decimalPattern().format(text)}';
  }

  double cast(int? value) => value?.toDouble() ?? 0.0;

  String compactText(dynamic value) => value == null ? '-' : value.toString();

  T compactEnumText<T>(int? value, T) => value == null ? '-' : T[value];
}
