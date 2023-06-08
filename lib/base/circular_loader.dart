import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yummy/utils/colors.dart';

class CircularLoader extends StatelessWidget {
  const CircularLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 80.h,
        width: 80.w,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(80.w),
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: Colors.white,

        ),


      ),
    );
  }
}