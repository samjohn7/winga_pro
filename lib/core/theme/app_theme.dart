import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(

    scaffoldBackgroundColor:
        AppColors.background,

    primaryColor:
        AppColors.primary,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    inputDecorationTheme:
        InputDecorationTheme(

      filled: true,
      fillColor: Colors.white,

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),

        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
    ),

    elevatedButtonTheme:
        ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(
        backgroundColor:
            AppColors.primary,

        foregroundColor: Colors.white,

        padding:
            const EdgeInsets.symmetric(
          vertical: 16,
        ),

        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
      ),
    ),
  );
}