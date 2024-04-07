import 'package:flutter/material.dart';
import 'package:maids_tasks_manager/src/theme/app_colors.dart';

abstract class AppTheme {
  static ThemeData lightTheme() => ThemeData(
        appBarTheme: _appBarTheme,
        colorScheme: ColorScheme.fromSwatch(
            backgroundColor: AppColors.white, primarySwatch: Colors.blue),
        inputDecorationTheme: _inputDecorationTheme(AppColors.blue),
        scaffoldBackgroundColor: AppColors.whiteSmoke,
        elevatedButtonTheme: _elevatedButtonThemeData(),
        tabBarTheme: _tabBarTheme,
      );

  static AppBarTheme get _appBarTheme => const AppBarTheme(
      elevation: 0.0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.white),
      backgroundColor: AppColors.blue,
      titleTextStyle: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.white));

  static TabBarTheme get _tabBarTheme =>
      const TabBarTheme(labelColor: AppColors.black);

  static ElevatedButtonThemeData _elevatedButtonThemeData() =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(AppColors.white),
            backgroundColor: MaterialStateProperty.all(AppColors.blue),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)))),
            textStyle: MaterialStateProperty.all(const TextStyle(
              fontSize: 20,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            )),
            minimumSize:
                MaterialStateProperty.all(const Size(double.infinity, 60))),
      );

  static InputBorder outlineInputBorder(Color primaryColor) =>
      const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      );

  static InputDecorationTheme _inputDecorationTheme(Color primaryColor) =>
      InputDecorationTheme(
        hintStyle: const TextStyle(color: AppColors.gray),
        border: outlineInputBorder(primaryColor),
        enabledBorder: outlineInputBorder(primaryColor),
        focusedBorder: outlineInputBorder(primaryColor),
        errorBorder: outlineInputBorder(Colors.red),
      );
}
