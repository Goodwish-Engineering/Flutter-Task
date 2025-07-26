import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studentprofileapp/common/constant/constant_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    iconTheme: const IconThemeData(color: Colors.black),
    cardColor: AppColors.black,
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll<Color?>(
          AppColors.backgroundLightColor,
        ),
      ),
    ),
    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.backgroundLightColor,
    textTheme: TextTheme(
      // for  heading
      bodyLarge: TextStyle(color: AppColors.black, fontSize: 26.sp),
      // for body text
      bodyMedium: TextStyle(color: AppColors.black, fontSize: 16.sp),

      // for description text
      bodySmall: TextStyle(color: AppColors.grey, fontSize: 15.sp),
    ),

    inputDecorationTheme: InputDecorationTheme(
      errorMaxLines: 3,

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(width: 2.w, color: AppColors.red),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(width: 1.w, color: AppColors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(width: 1.w, color: AppColors.blue),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(width: 2.w, color: AppColors.red),
      ),
      border: InputBorder.none,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    iconTheme: const IconThemeData(color: Colors.white),
    cardColor: AppColors.grey,
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll<Color?>(
          AppColors.backgroundDarkColor,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorMaxLines: 3,

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(width: 2.w, color: AppColors.red),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(width: 1.w, color: AppColors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(width: 1.w, color: AppColors.blue),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(width: 2.w, color: AppColors.red),
      ),
      border: InputBorder.none,
    ),
    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.backgroundDarkColor,
    textTheme: TextTheme(
      // for  heading
      bodyLarge: TextStyle(color: AppColors.white, fontSize: 26.sp),
      // for body text
      bodyMedium: TextStyle(color: AppColors.white, fontSize: 16.sp),

      // for description text
      bodySmall: TextStyle(color: AppColors.white, fontSize: 15.sp),
    ),
  );
}
