import 'package:flutter/material.dart';
import 'package:semco_app_asistio/core/theme/app_colors.dart';

class ThemeApp {
  final bool darkMode;

  ThemeApp({required this.darkMode});

  ThemeData getTheme() => ThemeData(
    brightness: darkMode ? Brightness.dark : Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryWC,
          brightness: darkMode ? Brightness.dark : Brightness.light,
          ),
        useMaterial3: true,
      );
}
