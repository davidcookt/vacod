import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppConstant {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static double getHeightDevice(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidthDevice(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static String formatMoney(int money) {
    return NumberFormat.simpleCurrency(locale: 'vi').format(money);
  }
}
