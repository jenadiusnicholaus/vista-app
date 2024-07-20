import 'package:intl/intl.dart' as intl;

moneyFormater(property) {
  return '${property.currency} ${intl.NumberFormat('#,##0.00', property.currency == "Tsh" ? "sw_TZ" : "en_US").format(double.parse(property.price.toString()))}';
}
