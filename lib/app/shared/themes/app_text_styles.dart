import 'package:flutter/material.dart';
import 'package:test_for_serial_port/app/shared/themes/app_colors.dart';

class AppTextStyles {
  static TextStyle display = TextStyle(
    color: AppColors.primary,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle headline = TextStyle(
    color: AppColors.primary,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle titleMedium = TextStyle(
    color: AppColors.primary,
    fontSize: 16.0,
  );

  static TextStyle bodyText1 = TextStyle(
    color: AppColors.primary,
    fontSize: 12.0,
  );

  static TextStyle bodyText2 = TextStyle(
    color: AppColors.primary,
    fontSize: 8.0,
  );
}
