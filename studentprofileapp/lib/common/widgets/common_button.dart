import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studentprofileapp/common/constant/constant_colors.dart';

// button
class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.btnColor = AppColors.blue,
    this.height = 65
  });

  final void Function()? onPressed;
  final String buttonText;
  final Color btnColor;
 final double height ;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Center(
      child: SizedBox(
        height: height.h,
        width: 150.w,
        child: TextButton(
          // Using ElevatedButton for better default styling
          onPressed: onPressed,

          child: Ink(
            decoration: BoxDecoration(
              color: btnColor,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                buttonText,
                style: theme.bodyMedium!.copyWith(color: AppColors.white),
              ),

              // Show indicator if loading and it's the login button
            ),
          ),
        ),
      ),
    );
  }
}
