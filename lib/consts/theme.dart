import 'package:flutter/material.dart';
import 'package:moj_projekat/consts/app_colors.dart';

class Style{
  static ThemeData light(){
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackgroung,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        contentPadding: const EdgeInsets.all(12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
}
  static ThemeData dark(){
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary, brightness: Brightness.dark),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        contentPadding: const EdgeInsets.all(12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}