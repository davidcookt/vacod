import 'package:flutter/material.dart';

class AppConstant {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
