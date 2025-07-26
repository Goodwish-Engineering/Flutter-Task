import 'package:flutter/material.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/utils/device_dimension.dart';

class AppThemeData {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.scaffoldBackgroundLight,
      primarySwatch: Colors.cyan,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(),
        },
      ),
      fontFamily: GoogleFonts.poppins().fontFamily,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(context.screenWidth, 50),
          backgroundColor: AppColor.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      cardColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: AppColor.textColorLight,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColor.textColorLight,
        ),
        iconTheme: IconThemeData(color: AppColor.textColorLight),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColor.scaffoldBackgroundLight,
      ),
      textTheme: TextTheme().copyWith(
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColor.textColorLight,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColor.textColorLightGrey,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColor.textColorLightGrey,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorLight,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorLight,
        ),
        titleSmall: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorLight,
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorLight,
        ),
        labelMedium: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorLight,
        ),
        labelSmall: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorLight,
        ),
        displayLarge: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorLight,
        ),
        displayMedium: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorLight,
        ),
        displaySmall: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorLight,
        ),
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorLight,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorLight,
        ),
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorLight,
        ),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.scaffoldBackgroundDark,
      primarySwatch: Colors.cyan,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(),
        },
      ),
      fontFamily: GoogleFonts.poppins().fontFamily,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(context.screenWidth, 50),
          backgroundColor: AppColor.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      cardColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        foregroundColor: AppColor.textColorDark,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColor.textColorDark,
        ),
        iconTheme: IconThemeData(color: AppColor.textColorDark),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColor.scaffoldBackgroundDark,
      ),
      textTheme: TextTheme().copyWith(
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColor.textColorDark,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColor.textColorDarkGrey,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColor.textColorDarkGrey,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorDark,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorDark,
        ),
        titleSmall: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorDark,
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorDark,
        ),
        labelMedium: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorDark,
        ),
        labelSmall: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorDark,
        ),
        displayLarge: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorDark,
        ),
        displayMedium: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorDark,
        ),
        displaySmall: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorDark,
        ),
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorDark,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorDark,
        ),
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColor.textColorDark,
        ),
      ),
    );
  }
}
