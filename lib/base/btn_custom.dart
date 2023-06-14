
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yummy/utils/colors.dart';
import 'package:yummy/widgets/big_text.dart';

class BtnCustom extends StatelessWidget {
  final BigText bigText;
  final Color color;
  final double width;
  final double radius;
  final EdgeInsets margin;
  final bool isBoxShadow;
  const BtnCustom({Key? key,  required this.color, required this.bigText, required this.margin,
    this.width=150,
    this.radius = 30,
    this.isBoxShadow= false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width.w,
      height: 60.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius.w),
          color: color,
        boxShadow: [
          isBoxShadow==true?
          BoxShadow(
        offset: Offset(0, 5),
            blurRadius: 10,
            color: AppColors.mainColor.withOpacity(0.3)
          ): BoxShadow(),
        ]
      ),
      child: Center(
          child: bigText,),
    );
  }
}


