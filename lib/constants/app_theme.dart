/// Creating custom color palettes is part of creating a custom app. The idea is to create
/// your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
/// object with those colors you just defined.
///
/// Resource:
/// A good resource would be this website: http://mcg.mbitson.com/
/// You simply need to put in the colour you wish to use, and it will generate all shades
/// for you. Your primary colour will be the `500` value.
///
/// Colour Creation:
/// In order to create the custom colours you need to create a `Map<int, Color>` object
/// which will have all the shade values. `const Color(0xFF...)` will be how you create
/// the colours. The six character hex code is what follows. If you wanted the colour
/// #114488 or #D39090 as primary colours in your setting, then you would have
/// `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
///
/// BAHN COLOR: 0xFFfa1c28
///
///
/// Usage:
/// In order to use this newly created setting or even the colours in it, you would just
/// `import` this file in your project, anywhere you needed it.
/// `import 'path/to/setting.dart';`
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static const _lightFillColor = Color(0x333);
  static const _darkFillColor = Color(0xfff);

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      fontFamily: GoogleFonts.openSans().fontFamily,
      colorScheme: colorScheme,
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.titleMedium!.apply(color: _darkFillColor),
      ),
    );
  }

  static const _black = Color(0xff333333);
  static const _strongWhite = Color(0xffffffff);
  static const _white = Color(0xfffafafa);

  static ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFfa1c28),
    onPrimary: _white,
    primaryContainer: _strongWhite,
    secondaryContainer: Color(0xffeeeeee),
    secondary: Color(0xff1338BE),
    onSecondary: _white,
    background: _white,
    surface: _white,
    onSurface: _black,
    onBackground: _black,
    // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFfa1c28),
    onPrimary: _white,
    primaryContainer: Color(0xff888888),
    secondaryContainer: Color(0xff555555),
    onSecondaryContainer: _white,
    secondary: Color(0xFF4D1F7C),
    onSecondary: _white,
    background: Color(0xff252020),
    surface: Color(0xff333333),
    onSurface: _white,
    onBackground: _black,
    // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headlineLarge: GoogleFonts.montserrat(
        fontWeight: _bold, fontSize: 28.0, color: _strongWhite),
    headlineMedium: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 20.0),
    headlineSmall: GoogleFonts.oswald(fontWeight: _medium, fontSize: 16.0),
    bodyLarge: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 14.0),
    bodyMedium: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 16.0),
    bodySmall: GoogleFonts.oswald(fontWeight: _semiBold, fontSize: 16.0),
    titleLarge: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 20.0),
    titleMedium: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 16.0),
    titleSmall: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 14.0),
    labelLarge: GoogleFonts.montserrat(fontWeight: _semiBold, fontSize: 18.0),
    labelMedium: GoogleFonts.montserrat(fontWeight: _semiBold, fontSize: 14.0),
    labelSmall: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 12.0),
  );
}
