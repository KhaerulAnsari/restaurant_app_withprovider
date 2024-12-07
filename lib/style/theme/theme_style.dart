import 'package:flutter/material.dart';
import 'package:restaurant_app/style/typography/typografy_style.dart';

class ThemeStyle {
  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: TypografyStyle.whiteColor,
      brightness: Brightness.light,
      cardColor: Colors.white,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: TypografyStyle.whiteColor,
      brightness: Brightness.dark,
      cardColor: TypografyStyle.blackColor,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: TypografyStyle.displayLarge,
      displayMedium: TypografyStyle.displayMedium,
      displaySmall: TypografyStyle.displaySmall,
      headlineLarge: TypografyStyle.headlineLarge,
      headlineMedium: TypografyStyle.headlineMedium,
      headlineSmall: TypografyStyle.headlineSmall,
      titleLarge: TypografyStyle.titleLarge,
      titleMedium: TypografyStyle.titleMedium,
      titleSmall: TypografyStyle.titleSmall,
      bodyLarge: TypografyStyle.bodyLargeBold,
      bodyMedium: TypografyStyle.bodyLargeMedium,
      bodySmall: TypografyStyle.bodyLargeRegular,
      labelLarge: TypografyStyle.labelLarge,
      labelMedium: TypografyStyle.labelMedium,
      labelSmall: TypografyStyle.labelSmall,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      toolbarTextStyle: _textTheme.titleLarge,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
    );
  }
}
