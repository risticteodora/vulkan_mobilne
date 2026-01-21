import 'package:flutter/material.dart';
import 'package:moj_projekat/consts/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';


class Style{
  static ThemeData light(){
    return ThemeData(
      textTheme: GoogleFonts.playfairDisplayTextTheme().apply(
        bodyColor: Colors.black,
        displayColor: Colors.black
      ),
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackgroung,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor:AppColors.lightBackgroung,
        foregroundColor: Colors.black,
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
      textTheme: GoogleFonts.playfairDisplayTextTheme().apply(
        bodyColor: Colors.white,
        displayColor: Colors.white
      ),
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary, brightness: Brightness.dark),
      cardTheme: CardThemeData(
        color: const Color.fromARGB(140, 99, 5, 5),
        elevation: 3
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor:AppColors.darkBackground,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        contentPadding: const EdgeInsets.all(12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}