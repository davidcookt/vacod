import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vacod/utils/colors.dart';

/// Used for all animations in the  app
class Times {
  static const Duration fastest = const Duration(milliseconds: 150);
  static const fast = const Duration(milliseconds: 250);
  static const medium = const Duration(milliseconds: 350);
  static const slow = const Duration(milliseconds: 700);
  static const slower = const Duration(milliseconds: 1000);
}

//custom textStyle
const TextStyle kHeaderStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);
const TextStyle kSubHeaderStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
);
const TextStyle kTitleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);
const TextStyle kSubtitleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
);
const TextStyle kNormalStyle = TextStyle(
  fontSize: 14,
);
const TextStyle kCaptionStyle = TextStyle(
  fontSize: 12,
);

//extension

extension styleExtension on TextStyle {
  TextStyle get black => this.apply(color: Colors.black);
  TextStyle get white => this.apply(color: Colors.white);
  TextStyle get red => this.apply(color: Colors.red);
  TextStyle get grey => this.apply(color: Colors.grey);
  TextStyle get green => this.apply(color: Colors.green);
  TextStyle get primary => this.apply(color: lightPrimaryColor);
  TextStyle get accent => this.apply(color: lightAccentColor);
  TextStyle get underline => this.apply(decoration: TextDecoration.underline);
}

class Corners {
  static const double sm = 3;
  static const BorderRadius smBorder = const BorderRadius.all(smRadius);
  static const Radius smRadius = const Radius.circular(sm);

  static const double med = 5;
  static const BorderRadius medBorder = const BorderRadius.all(medRadius);
  static const Radius medRadius = const Radius.circular(med);

  static const double lg = 8;
  static const BorderRadius lgBorder = const BorderRadius.all(lgRadius);
  static const Radius lgRadius = const Radius.circular(lg);
}

class Strokes {
  static const double thin = 1;
  static const double thick = 4;
}

class Shadows {
  static List<BoxShadow> get universal => [
        BoxShadow(
            color: Color(0xff333333).withOpacity(.15),
            spreadRadius: 0,
            blurRadius: 10),
      ];
  static List<BoxShadow> get small => [
        BoxShadow(
            color: Color(0xff333333).withOpacity(.15),
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(0, 1)),
      ];
}

///material textStyle
/// Font Sizes
/// You can use these directly if you need, but usually there should be a predefined style in TextStyles.
class FontSizes {
  /// Provides the ability to nudge the app-wide font scale in either direction
  static double get scale => 1;
  static double get s10 => 10 * scale;
  static double get s11 => 11 * scale;
  static double get s12 => 12 * scale;
  static double get s14 => 14 * scale;
  static double get s16 => 16 * scale;
  static double get s22 => 22 * scale;
  static double get s24 => 24 * scale;
  static double get s48 => 48 * scale;
}

/// Fonts - A list of Font Families, this is uses by the TextStyles class to create concrete styles.
class Fonts {
  static const String raleway = "Raleway";
  static const String fraunces = "Fraunces";
  static const String inter = "Inter";
  static const String poppins = "Poppins";
}

/// TextStyles - All the core text styles for the app should be declared here.
/// Don't try and create every variant in existence here, just the high level ones.
/// More specific variants can be created on the fly using `style.copyWith()`
/// `newStyle = TextStyles.body1.copyWith(lineHeight: 2, color: Colors.red)`
class TextStyles {
  /// Declare a base style for each Family
  static const TextStyle raleway = const TextStyle(
      fontFamily: Fonts.raleway,
      fontWeight: FontWeight.w400,
      height: 1,
      color: lightTextColor);
  static const TextStyle fraunces = const TextStyle(
      fontFamily: Fonts.fraunces,
      fontWeight: FontWeight.w400,
      height: 1,
      color: lightTextColor);
  static const TextStyle poppins = const TextStyle(
      fontFamily: Fonts.poppins,
      fontWeight: FontWeight.w400,
      height: 1,
      color: lightTextColor);
  static TextStyle inter = GoogleFonts.inter();

  static TextStyle get h1 => inter.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: FontSizes.s48,
      letterSpacing: -1,
      color: lightTextColor,
      height: 1.17);
  static TextStyle get h2 =>
      h1.copyWith(fontSize: FontSizes.s22, letterSpacing: -.5, height: 1.16);
  static TextStyle get h3 =>
      h1.copyWith(fontSize: FontSizes.s14, letterSpacing: -.05, height: 1.29);
  static TextStyle get title1 => poppins.copyWith(
      fontWeight: FontWeight.bold, fontSize: FontSizes.s16, height: 1.31);
  static TextStyle get title2 => title1.copyWith(
      fontWeight: FontWeight.w500, fontSize: FontSizes.s14, height: 1.36);
  static TextStyle get body1 => poppins.copyWith(
      fontWeight: FontWeight.normal, fontSize: FontSizes.s14, height: 1.71);
  static TextStyle get body2 =>
      body1.copyWith(fontSize: FontSizes.s12, height: 1.5, letterSpacing: .2);
  static TextStyle get body3 => body1.copyWith(
      fontSize: FontSizes.s12, height: 1.5, fontWeight: FontWeight.bold);
  static TextStyle get callout1 => raleway.copyWith(
      fontWeight: FontWeight.w800,
      fontSize: FontSizes.s12,
      height: 1.17,
      letterSpacing: .5);
  static TextStyle get callout2 =>
      callout1.copyWith(fontSize: FontSizes.s10, height: 1, letterSpacing: .25);
  static TextStyle get caption => raleway.copyWith(
      fontWeight: FontWeight.w500, fontSize: FontSizes.s11, height: 1.36);
}

class InputDecorTheme {
  static InputDecoration textFieldStyle(
      {String labelTextStr = "", String hintTextStr = ""}) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(14),
      hintText: hintTextStr,
      hintStyle: TextStyles.body1,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: lightSplashColor,
        ),
      ),
    );
  }
}
