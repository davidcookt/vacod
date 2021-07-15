import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vacod/utils/colors.dart';
import 'package:vacod/utils/style_docoration.dart';

class AppTheme {
  static final _pageTransitionsTheme = PageTransitionsTheme(
    builders: const {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );

  static final ThemeData light = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: lightTextColor),
    ),
    accentColor: lightAccentColor,
    backgroundColor: lightBackgroundColor,
    pageTransitionsTheme: _pageTransitionsTheme,
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: lightPrimaryColor,
      centerTitle: true,
      iconTheme: IconThemeData(color: lightTextColor),
      titleTextStyle: TextStyles.bodyS16B.copyWith(color: lightTextColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.bodyS14,
      contentPadding: EdgeInsets.only(left: 20, top: 13, bottom: 16),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: lightSplashColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: lightSplashColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: lightSplashColor,
        ),
      ),
      filled: true,
      fillColor: lightPrimaryColor,
    ),
  );

  static final ThemeData dark = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    accentColor: darkAccentColor,
    canvasColor: darkCanvasColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    cardColor: darkCardColor,
    dividerColor: darkDividerColor,
    dialogBackgroundColor: darkCardColor,
    pageTransitionsTheme: _pageTransitionsTheme,

    // textTheme: GoogleFonts.rubikTextTheme(ThemeData.dark().textTheme),
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  );
}
