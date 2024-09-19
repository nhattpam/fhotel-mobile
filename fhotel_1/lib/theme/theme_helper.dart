import 'package:flutter/material.dart';

import '../../core/app_export.dart';

String _appTheme = "primary";

/// Helper class for managing themes and colors.
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedCustomColor.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedColorScheme.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.onPrimaryContainer,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.h),
          ),
          shadowColor: appTheme.black900.withOpacity(0.3),
          elevation: 2,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: colorScheme.primary,
            width: 2.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return appTheme.teal700;
          }
          return colorScheme.onSurface;
        }),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return appTheme.teal700;
          }
          return colorScheme.onSurface;
        }),
        side: BorderSide(
          width: 1,
        ),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.blue50,
      ),
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        displaySmall: TextStyle(
          color: appTheme.blueGray900,
          fontSize: 38.fSize,
          fontFamily: 'Jost',
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: appTheme.blueGray900,
          fontSize: 24.fSize,
          fontFamily: 'Jost',
          fontWeight: FontWeight.w600,
        ),
        labelLarge: TextStyle(
          color: appTheme.gray700,
          fontSize: 13.fSize,
          fontFamily: 'Mulish',
          fontWeight: FontWeight.w700,
        ),
        labelMedium: TextStyle(
          color: appTheme.blueGray900,
          fontSize: 11.fSize,
          fontFamily: 'Mulish',
          fontWeight: FontWeight.w800,
        ),
        labelSmall: TextStyle(
          color: appTheme.blueGray900,
          fontSize: 9.fSize,
          fontFamily: 'Mulish',
          fontWeight: FontWeight.w800,
        ),
        titleLarge: TextStyle(
          color: appTheme.blueGray900,
          fontSize: 21.fSize,
          fontFamily: 'Jost',
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: appTheme.blueGray900,
          fontSize: 16.fSize,
          fontFamily: 'Jost',
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: appTheme.gray700,
          fontSize: 14.fSize,
          fontFamily: 'Mulish',
          fontWeight: FontWeight.w700,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final primaryColorScheme = ColorScheme.light(
    // Primary colors
    primary: Color(0XFFFF9300),
    primaryContainer: Color(0XFF073862),
    secondaryContainer: Color(0XFFA9A9A9),

    // Error colors
    errorContainer: Color(0XFF8E5AA3),
    onErrorContainer: Color(0XFF0E0E0E),

    // On colors(text colors)
    onPrimary: Color(0XFF1C1C1B),
    onPrimaryContainer: Color(0XFFFFFFFF),
  );
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {
  // Amber
  Color get amber700 => Color(0XFFFF9C07);

  Color get amberA200 => Color(0XFFFAC840);

  Color get amberA20001 => Color(0XFFFCCB40);

  Color get amberA400 => Color(0XFFFCC202);

  // Black
  Color get black900 => Color(0XFF000000);

  // Blue
  Color get blue50 => Color(0XFFE8F1FF);

  Color get blue600 => Color(0XFF1B97DF);

  // BlueGray
  Color get blueGray100 => Color(0XFFC9C9D2);

  Color get blueGray10001 => Color(0XFFD7D7D7);

  Color get blueGray200 => Color(0XFFB4BDC4);

  Color get blueGray20001 => Color(0XFFBCC1CD);

  Color get blueGray400 => Color(0XFF88889D);

  Color get blueGray50 => Color(0XFFEFEFF1);

  Color get blueGray900 => Color(0XFF202244);

  // DeepOrange
  Color get deepOrange400 => Color(0XFFFF7648);

  // Gray
  Color get gray100 => Color(0XFFF6F6F5);

  Color get gray10001 => Color(0XFFF3F3F3);

  Color get gray10002 => Color(0XFFF5F5F5);

  Color get gray40001 => Color(0XFFC8C2B9);

  Color get gray200 => Color(0XFFEAEAEA);

  Color get gray400 => Color(0XFFBFBFBF);

  Color get gray50 => Color(0XFFFAF9F9);

  Color get gray500 => Color(0XFF9B9B9B);

  Color get gray50001 => Color(0XFFA0A4AB);

  Color get gray50002 => Color(0XFFB2A5A5);

  Color get gray5001 => Color(0XFFF4F8FE);

  Color get gray700 => Color(0XFF545454);

  Color get gray70001 => Color(0XFF6C6262);

  Color get gray800 => Color(0XFF472D2D);

  Color get gray80001 => Color(0XFF505050);

  Color get gray900 => Color(0XFF111223);

  Color get gray90001 => Color(0XFF1F0E31);

  Color get gray90002 => Color(0XFF202525);

  Color get gray90003 => Color(0XFF212525);

  // Green
  Color get green500 => Color(0XFF50B747);

  Color get green50 => Color(0XFFD7FAE0);

  Color get greenA700 => Color(0XFF00AB56);

  // Indigo
  Color get indigo500 => Color(0XFF3046CC);

  Color get indigo700 => Color(0XFF332DA1);

  Color get indigo900 => Color(0XFF292E63);

  // Lime
  Color get lime400 => Color(0XFFBFE15C);

  Color get lime50 => Color(0XFFFCF6EE);

  // Orange
  Color get orange300 => Color(0XFFFFB64A);

  Color get orange50 => Color(0XFFFFF1DE);

  Color get orange5001 => Color(0XFFFFF0DC);

  Color get orange600 => Color(0XFFE68B01);

  Color get orangeA200 => Color(0XFFEBB039);

  Color get orangeA700 => Color(0XFFFF6B00);

  // Red
  Color get red600 => Color(0XFFDD2D44);

  Color get redA400 => Color(0XFFFF001E);

  Color get redA200 => Color(0XFFFF424E);

  Color get red50 => Color(0XFFFFF0F1);

  // Teal
  Color get teal700 => Color(0XFF167F71);

  Color get teal900 => Color(0XFF033B58);

  Color get teal800 => Color (0XFF007D3A);
  // Yellow
  Color get yellow50 => Color(0XFFFFF8EB);

  Color get yellow700 => Color(0XFFEFC73B);

  Color get yellow100 => Color(0XFFFFF5C7);

  // White
  Color get whiteA700 => Color(0XFFFFFFFF);

  //Gray
  Color get gray600 => Color(0XFF7F7F89);
}

PrimaryColors get appTheme => ThemeHelper().themeColor();

ThemeData get theme => ThemeHelper().themeData();