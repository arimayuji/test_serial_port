import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:test_for_serial_port/app/shared/themes/app_colors.dart';
import 'package:test_for_serial_port/app/shared/themes/app_dimensions.dart';
import 'package:test_for_serial_port/app/shared/themes/app_text_styles.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.secondary,
    splashColor: Colors.transparent,
    shadowColor: AppColors.primary,
    fontFamily: GoogleFonts.poppins().fontFamily,
    dividerColor: AppColors.primary,
    dividerTheme: DividerThemeData(
      color: AppColors.primary,
      thickness: AppDimensions.borderMedium,
      indent: 5,
      endIndent: 5,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      textStyle: WidgetStatePropertyAll(
          AppTextStyles.headline.copyWith(fontWeight: FontWeight.bold)),
      elevation: const WidgetStatePropertyAll(8),
      shape: const WidgetStatePropertyAll(StadiumBorder()),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          vertical: AppDimensions.paddingMedium,
          horizontal: AppDimensions.paddingExtraLarge,
        ),
      ),
    )),
    radioTheme: RadioThemeData(
      fillColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return Colors.grey;
      }),
    ),
    dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusLarge,
          ),
        ),
        alignment: AlignmentDirectional.center,
        backgroundColor: AppColors.secondary,
        surfaceTintColor: AppColors.secondary),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.display,
      headlineLarge: AppTextStyles.headline,
      titleMedium: AppTextStyles.titleMedium,
      bodyLarge: AppTextStyles.bodyText1,
      bodyMedium: AppTextStyles.bodyText2,
    ),
    cardTheme: CardTheme(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.primary, width: 1.7),
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusSmall * 0.5,
        ),
      ),
      color: AppColors.secondary,
      elevation: 6,
      shadowColor: AppColors.primary,
      surfaceTintColor: AppColors.secondary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: AppTextStyles.titleMedium,
      hintStyle:
          AppTextStyles.titleMedium.copyWith(color: AppColors.secondaryGrey),
      contentPadding: const EdgeInsets.only(
        left: AppDimensions.paddingMedium,
        right: AppDimensions.paddingMedium,
        top: AppDimensions.paddingExtraLarge,
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.error,
          width: 1,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.error,
          width: 1,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 1)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 1)),
      floatingLabelStyle: AppTextStyles.headline,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        gapPadding: AppDimensions.paddingSmall,
        borderSide: BorderSide(
            color: AppColors.primary,
            width: AppDimensions.borderThin * 1.5,
            style: BorderStyle.solid),
      ),
    ),
    iconTheme: IconThemeData(
      color: AppColors.primary,
      size: AppDimensions.iconLarge,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.all(
          AppColors.primary,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppColors.secondary,
      surfaceTintColor: AppColors.secondary,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.primary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.secondary,
      error: AppColors.error,
      shadow: AppColors.primary,
      onError: AppColors.error,
      surface: AppColors.secondary,
      onSurface: AppColors.secondary,
    ),
  );
}
