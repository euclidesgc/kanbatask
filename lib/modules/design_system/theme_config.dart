// Configuração de temas do Design System
// Implemente aqui a configuração de temas (ThemeData, ColorScheme, etc.)

import 'package:flutter/material.dart';

import 'kanba_colors.dart';
import 'kanba_text.dart';

class ThemeConfig {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: KanbaColors.primary,
        onPrimary: KanbaColors.white,
        secondary: KanbaColors.secondary,
        onSecondary: KanbaColors.grey900,
        error: KanbaColors.error,
        onError: KanbaColors.white,
        surface: KanbaColors.white,
        onSurface: KanbaColors.grey900,
      ),
      scaffoldBackgroundColor: KanbaColors.backgroundBlue,
      cardColor: KanbaColors.white,
      textTheme: TextTheme(
        displayLarge: KanbaText.h1,
        displayMedium: KanbaText.h2,
        displaySmall: KanbaText.h3,
        headlineMedium: KanbaText.h4,
        headlineSmall: KanbaText.h5,
        titleLarge: KanbaText.h6,
        bodyLarge: KanbaText.bodyLarge,
        bodyMedium: KanbaText.bodyMedium,
        bodySmall: KanbaText.bodySmall,
        labelSmall: KanbaText.bodyXSmall,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: KanbaColors.primary,
        iconTheme: const IconThemeData(color: KanbaColors.white),
        titleTextStyle: KanbaText.h5.copyWith(color: KanbaColors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: KanbaColors.primary,
          foregroundColor: KanbaColors.white,
          textStyle: KanbaText.bodyLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: KanbaColors.secondary,
        foregroundColor: KanbaColors.grey900,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: KanbaColors.white,
        labelStyle: const TextStyle(color: KanbaColors.grey700),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: KanbaColors.primary),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: KanbaColors.primary,
        contentTextStyle: TextStyle(color: KanbaColors.white),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.all(KanbaColors.primary),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(KanbaColors.primary),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(KanbaColors.primary),
        trackColor: WidgetStateProperty.all(
          KanbaColors.primary.withAlpha(128), // 50% de opacidade
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: KanbaColors.primary,
        onPrimary: KanbaColors.grey900,
        secondary: KanbaColors.secondary,
        onSecondary: KanbaColors.grey900,
        error: KanbaColors.error,
        onError: KanbaColors.white,
        surface: KanbaColors.dark2,
        onSurface: KanbaColors.white,
      ),
      scaffoldBackgroundColor: KanbaColors.dark1,
      cardColor: KanbaColors.dark2,
      textTheme: TextTheme(
        displayLarge: KanbaText.h1.copyWith(color: KanbaColors.white),
        displayMedium: KanbaText.h2.copyWith(color: KanbaColors.white),
        displaySmall: KanbaText.h3.copyWith(color: KanbaColors.white),
        headlineMedium: KanbaText.h4.copyWith(color: KanbaColors.white),
        headlineSmall: KanbaText.h5.copyWith(color: KanbaColors.white),
        titleLarge: KanbaText.h6.copyWith(color: KanbaColors.white),
        bodyLarge: KanbaText.bodyLarge.copyWith(color: KanbaColors.white),
        bodyMedium: KanbaText.bodyMedium.copyWith(color: KanbaColors.white),
        bodySmall: KanbaText.bodySmall.copyWith(color: KanbaColors.white),
        labelSmall: KanbaText.bodyXSmall.copyWith(color: KanbaColors.white),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: KanbaColors.dark2,
        iconTheme: const IconThemeData(color: KanbaColors.white),
        titleTextStyle: KanbaText.h5.copyWith(color: KanbaColors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: KanbaColors.primary,
          foregroundColor: KanbaColors.white,
          textStyle: KanbaText.bodyLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: KanbaColors.secondary,
        foregroundColor: KanbaColors.grey900,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: KanbaColors.dark2,
        labelStyle: const TextStyle(color: KanbaColors.grey400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: KanbaColors.primary),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: KanbaColors.primary,
        contentTextStyle: TextStyle(color: KanbaColors.white),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.all(KanbaColors.primary),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(KanbaColors.primary),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(KanbaColors.primary),
        trackColor: WidgetStateProperty.all(
          KanbaColors.primary.withAlpha(128), // 50% de opacidade
        ),
      ),
    );
  }
}
