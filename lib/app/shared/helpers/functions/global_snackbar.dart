import 'package:flutter/material.dart';
import 'package:test_for_serial_port/app/shared/themes/app_colors.dart';
import 'package:test_for_serial_port/app/shared/themes/app_text_styles.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

abstract class GlobalSnackBar {
  static void error(String message) {
    if (rootScaffoldMessengerKey.currentState != null) {
      rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        backgroundColor: AppColors.error,
        width: 500,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        content: Text(
          message,
          style: AppTextStyles.bodyText1.copyWith(color: AppColors.secondary),
        ),
      ));
    }
  }

  static void success(String message) {
    if (rootScaffoldMessengerKey.currentState != null) {
      rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        backgroundColor: AppColors.success,
        width: 600,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        content: Text(
          message,
          style: AppTextStyles.bodyText1.copyWith(color: AppColors.secondary),
        ),
      ));
    }
  }

   static void info(String message) {
    if (rootScaffoldMessengerKey.currentState != null) {
      rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        backgroundColor: AppColors.primary,
        width: 600,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        content: Text(
          message,
          style: AppTextStyles.bodyText1.copyWith(color: AppColors.secondary),
        ),
      ));
    }
  }
}
