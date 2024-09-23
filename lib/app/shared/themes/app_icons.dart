import 'package:flutter/material.dart';
import 'package:test_for_serial_port/app/shared/themes/app_colors.dart';
import 'package:test_for_serial_port/app/shared/themes/app_dimensions.dart';

class AppIcons {
  static Icon errorIcon = Icon(
    Icons.error,
    size: 200,
    color: AppColors.primary,
  );

  static Icon connectIcon = Icon(
    Icons.usb,
    size: 200,
    color: AppColors.primary,
  );

  static Icon noConnectIcon = Icon(
    Icons.usb_off,
    size: 200,
    color: AppColors.primary,
  );

  static Icon barChartIcon = Icon(
    Icons.bar_chart_outlined,
    size: AppDimensions.iconLarge,
    color: AppColors.primary,
  );

  static Icon homeIcon = Icon(
    Icons.home_outlined,
    size: AppDimensions.iconLarge,
    color: AppColors.primary,
  );

  static Icon historyIcon = Icon(
    Icons.history_outlined,
    size: AppDimensions.iconLarge,
    color: AppColors.primary,
  );

   static Icon errorIconSecondary = Icon(
    Icons.error,
    size: 200,
    color: AppColors.primary,
  );

  static Icon connectIconSecondary = Icon(
    Icons.usb,
    size: 200,
    color: AppColors.secondary,
  );

  static Icon noConnectIconSecondary = Icon(
    Icons.usb_off,
    size: 200,
    color: AppColors.secondary,
  );

  static Icon barChartIconSecondary = Icon(
    Icons.bar_chart_outlined,
    size: AppDimensions.iconLarge,
    color: AppColors.secondary,
  );

  static Icon homeIconSecondary = Icon(
    Icons.home_outlined,
    size: AppDimensions.iconLarge,
    color: AppColors.secondary,
  );

  static Icon historyIconSecondary = Icon(
    Icons.history_outlined,
    size: AppDimensions.iconLarge,
    color: AppColors.secondary,
  );
}
