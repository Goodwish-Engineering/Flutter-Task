import 'package:studentprofileapp/common/constant/constant_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// snackbar message
void snackBarMessage(BuildContext context, String text, ThemeData appTheme) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      backgroundColor: AppColors.blue,
      content: Center(
        child: Text(
          text,
          style: appTheme.textTheme.bodyMedium!.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    ),
  );
}
