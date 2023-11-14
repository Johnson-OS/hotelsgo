

import 'package:intl/intl.dart';

class Utils {

  Utils();

  static String getCurrencySymbol({String? currency}){
    var format = NumberFormat.simpleCurrency(name: currency??'USD');
    return format.currencySymbol;
  }

  static String formatCurrency(double number){

    final numberFormat = NumberFormat("#,##0");
    return numberFormat.format(number);
  }

 static String formatCurrencyFull(double number, {String? currency}){

    final numberFormat = NumberFormat("#,##0");
    return getCurrencySymbol(currency: currency)+numberFormat.format(number);
  }
}